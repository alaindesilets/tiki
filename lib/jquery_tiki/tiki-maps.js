
(function () {
	var mapNumber = 0;

	function getBaseLayers()
	{
		var layers = [], tiles = jqueryTiki.mapTileSets, factories = {
			openstreetmap: function () {
				return new OpenLayers.Layer.OSM();
			},
			openaerialmap: function () {
				return new OpenLayers.Layer.XYZ(
					"OpenAerialMap",
					"http://tile.openaerialmap.org/tiles/1.0.0/openaerialmap-900913/${z}/${x}/${y}.png",
					{sphericalMercator: true}
				);
			},
			google_street: function () {
				return new OpenLayers.Layer.Google(
					"Google Streets",
					{}
				);
			},
			google_satellite: function () {
				return new OpenLayers.Layer.Google(
					"Google Satellite",
					{type: google.maps.MapTypeId.SATELLITE}
				);
			},
			google_hybrid: function () {
				return new OpenLayers.Layer.Google(
					"Google Hybrid",
					{type: google.maps.MapTypeId.HYBRID}
				);
			},
			google_physical: function () {
				return new OpenLayers.Layer.Google(
					"Google Physical",
					{type: google.maps.MapTypeId.TERRAIN}
				);
			/* Needs additional testing
			},
			visualearth_road: function () {
				return new OpenLayers.Layer.VirtualEarth(
					"Virtual Earth Roads",
					{'type': VEMapStyle.Road}
				);
			*/
			}
		};

		if (tiles.length === 0) {
			tiles.push('openstreetmap');
		}

		$.each(tiles, function (k, name) {
			var f = factories[name];

			if (f) {
				layers.push(f());
			}
		});

		return layers;
	}

	function parseCoordinates(value) {
		var matching = value.match(/^(-?[0-9]*(\.[0-9]+)?),(-?[0-9]*(\.[0-9]+)?)(,(.*))?$/);
		
		if (matching) {
			var lat = parseFloat(matching[3]);
			var lon = parseFloat(matching[1]);
			var zoom = matching[6] ? parseInt(matching[6], 10) : 0;

			return {lat: lat, lon: lon, zoom: zoom};
		}

		return null;
	}

	function writeCoordinates(lonlat, map) {
		return lonlat.lon + ',' + lonlat.lat + ',' + map.getZoom();
	}

	$.fn.createMap = function () {
		this.each(function () {
			var id = $(this).attr('id'), container = this, desiredControls;
			desiredControls = $(this).data('map-controls');
			if (desiredControls === undefined) {
				desiredControls = 'controls,layers,search_location,current_location,streetview';
			}

			desiredControls = desiredControls.split(',');

			var setupHeight = function () {
				var height = $(container).height();
				if (0 === height) {
					height = $(container).width() / 4.0 * 3.0;
				}

				$(container).closest('.height-size').each(function () {
					height = $(this).data('available-height');
					$(this).css('padding', 0);
					$(this).css('margin', 0);
				});

				$(container).height(height);
			};
			setupHeight();

			$(window).resize(setupHeight);

			if (! id) {
				++mapNumber;
				id = 'openlayers' + mapNumber;
				$(this).attr('id', id);
			}

			setTimeout(function () {
				OpenLayers.ImgPath = "img/openlayers/dark/";
				var map = container.map = new OpenLayers.Map(id, { controls: [] });
				var layers = getBaseLayers();
				container.layer = layers[0];
				container.markers = new OpenLayers.Layer.Markers("Markers");
				container.uniqueMarkers = {};
				container.layers = {};
				map.addLayers(layers);
				map.addLayer(container.markers);
				map.zoomToMaxExtent();

				container.modeManager = {
					modes: [],
					activeMode: null,
					addMode: function (options) {
						var mode = $.extend({
							name: tr('Default'),
							icon: null,
							activate: null,
							deactivate: null,
							controls: [],
							layers: []
						}, options);

						$.each(mode.layers, function (k, layer) {
							layer.displayInLayerSwitcher = false;
							layer.setVisibility(false);
							map.addLayer(layer);
						});

						$.each(mode.controls, function (k, control) {
							control.autoActivate = false;
							map.addControl(control);
						});

						this.modes.push(mode);

						if (! this.activeMode) {
							this.activate(mode);
						}

						$(container).trigger('modechanged');
					},
					switchTo: function (modeName) {
						var manager = this;
						$.each(this.modes, function (k, mode) {
							if (mode.name === modeName) {
								manager.activate(mode);
							}
						});
					},
					activate: function (mode) {
						if (this.activeMode) {
							this.deactivate();
						}

						this.activeMode = mode;
						
						$.each(mode.controls, function (k, control) {
							control.activate();
						});
						$.each(mode.layers, function (k, layer) {
							layer.setVisibility(true);
						});
						if (mode.activate) {
							mode.activate.apply([], container);
						}

						$(container).trigger('modechanged');
					},
					deactivate: function () {
						if (! this.activeMode) {
							return;
						}

						$.each(this.activeMode.controls, function (k, control) {
							control.deactivate();
						});
						$.each(this.activeMode.layers, function (k, layer) {
							layer.setVisibility(false);
						});
						if (this.activeMode.deactivate) {
							this.activeMode.deactivate.apply([], container);
						}
					}
				};

				var defaultMode = {
					controls: []
				};

				map.addControl(new OpenLayers.Control.Attribution());

				if (layers.length > 1 && -1 !== $.inArray('scale', desiredControls)) {
					map.addControl(new OpenLayers.Control.ScaleLine());
				}

				if (layers.length > 1 && -1 !== $.inArray('navigation', desiredControls)) {
					defaultMode.controls.push(new OpenLayers.Control.NavToolbar());
				}

				if (layers.length > 1 && -1 !== $.inArray('controls', desiredControls)) {
					defaultMode.controls.push(new OpenLayers.Control.Navigation());
					if (-1 !== $.inArray('levels', desiredControls)) {
						map.addControl(new OpenLayers.Control.PanZoomBar());
					} else {
						map.addControl(new OpenLayers.Control.PanZoom());
					}
				}

				if (layers.length > 1 && -1 !== $.inArray('layers', desiredControls)) {
					map.addControl(new OpenLayers.Control.LayerSwitcher());
				}

				container.markerIcons = {
					loadedMarker: {},
					actionQueue: {},
					loadingMarker: [],
					loadMarker: function (name, src) {
						this.loadingMarker.push(name);
						this.actionQueue[name] = [];

						var img = new Image(), me = this;
						img.onload = function () {
							var width = this.width, height = this.height, action;
							me.loadedMarker[name] = new OpenLayers.Icon(src, new OpenLayers.Size(width, height), new OpenLayers.Pixel(-width/2, -height));
							while (action = me.actionQueue[name].pop()) {
								action();
							};
						};
						img.src = src;
					},
					createMarker: function (name, lonlat, callback) {
						if (this.loadedMarker[name]) {
							this._createMarker(name, lonlat, callback);
							return;
						}

						if (-1 === $.inArray(name, this.loadingMarker)) {
							this.loadMarker(name, name);
						}

						var me = this;
						this.actionQueue[name].push(function () {
							me._createMarker(name, lonlat, callback);
						});
					},
					_createMarker: function (name, lonlat, callback) {
						var marker = new OpenLayers.Marker(lonlat, this.loadedMarker[name].clone());
						callback(marker);
					}
				};

				container.getLayer = function (name) {
					if (name) {
						if (! container.layers[name]) {
							container.layers[name] = new OpenLayers.Layer.Markers(name);
							container.map.addLayer(container.layers[name]);
						}

						return container.layers[name];
					}

					return container.markers;
				};

				container.markerIcons.loadMarker('default', 'http://www.openlayers.org/dev/img/marker.png');
				container.markerIcons.loadMarker('selection', 'http://www.openlayers.org/dev/img/marker-gold.png');

				if (navigator.geolocation && navigator.geolocation.getCurrentPosition) {
					container.toMyLocation = $('<a/>')
						.css('display', 'block')
						.attr('href', '')
						.click(function () {
							navigator.geolocation.getCurrentPosition(function (position) {
								var lonlat = new OpenLayers.LonLat(position.coords.longitude, position.coords.latitude).transform(
									new OpenLayers.Projection("EPSG:4326"),
									map.getProjectionObject()
								);

								map.setCenter(lonlat);
								map.zoomToScale(position.coords.accuracy * OpenLayers.INCHES_PER_UNIT.m);

								$(container).addMapMarker({
									lat: position.coords.latitude,
									lon: position.coords.longitude,
									unique: 'selection'
								});
							});
							return false;
						})
						.text(tr('To My Location'));

					if (-1 !== $.inArray('current_location', desiredControls)) {
						$(container).after(container.toMyLocation);
					}
				}

				container.searchLocation = $('<a/>')
					.css('display', 'block')
					.attr('href', '')
					.click(function () {
						var address = prompt(tr('What address are you looking for?'));

						if (address) {
							$.getJSON('tiki-ajax_services.php', {geocode: address}, function (data) {
								var lonlat = new OpenLayers.LonLat(data.lon, data.lat).transform(
									new OpenLayers.Projection("EPSG:4326"),
									map.getProjectionObject()
								);

								map.setCenter(lonlat);
								map.zoomToScale(data.accuracy * OpenLayers.INCHES_PER_UNIT.m);

								$(container).addMapMarker({
									lat: data.lat,
									lon: data.lon,
									unique: 'selection'
								});
							});
						}
						return false;
					})
					.text(tr('Search Location'));

				if (-1 !== $.inArray('search_location', desiredControls)) {
					$(container).after(container.searchLocation);
				}

				var field = $(container).data('target-field');
				var central = null, useMarker = true;

				if (field) {
					field = $($(container).closest('form')[0][field]);

					$(container).setupMapSelection({
						field: field
					});
					var value = field.val();
					central = parseCoordinates(value);
				}

				if ($(container).data('marker-filter')) {
					var filter = $(container).data('marker-filter');
					$(filter).each(function () {
						var lat = $(this).data('geo-lat')
							, lon = $(this).data('geo-lon')
							, zoom = $(this).data('geo-zoom')
							, extent = $(this).data('geo-extent')
							, icon = $(this).data('icon-src')
							, content = $(this).clone().data({}).wrap('<span/>').parent().html()
							;

						if (! extent) {
							if ($(this).hasClass('primary') || this.href === document.location.href) {
								central = {lat: lat, lon: lon, zoom: zoom ? zoom : 0};
							} else {
								$(container).addMapMarker({
									lon: lon,
									lat: lat,
									content: content,
									icon: icon ? icon : null
								});
							}
						} else if ($(this).is('img')) {
							var graphic = new OpenLayers.Layer.Image(
								$(this).attr('alt'),
								$(this).attr('src'),
								OpenLayers.Bounds.fromString(extent),
								new OpenLayers.Size($(this).width(), $(this).height())
							);

							graphic.isBaseLayer = false;
							graphic.alwaysInRange = true;
							container.map.addLayer(graphic);
						}
					});
				}

				var provided = $(container).data('geo-center');

				if (provided) {
					central = parseCoordinates(provided);
					useMarker = false;
				}

				if (central) {
					var lonlat = new OpenLayers.LonLat(central.lon, central.lat).transform(
						new OpenLayers.Projection("EPSG:4326"),
						map.getProjectionObject()
					);

					map.setCenter(lonlat, central.zoom);
					if (useMarker) {
						$(container).addMapMarker({
							lon: central.lon,
							lat: central.lat,
							unique: 'selection'
						});
					}
				}

				container.modeManager.addMode(defaultMode);

				if (jqueryTiki.googleStreetView) {
					container.streetview = {
						buttons: []
					};
					var StreetViewHandler = OpenLayers.Class(OpenLayers.Control, {
						defaultHandlerOptions: {
							'single': true,
							'double': false,
							'pixelTolerance': 0,
							'stopSingle': false,
							'stopDouble': false
						},
						initialize: function(options) {
							this.handlerOptions = OpenLayers.Util.extend({}, this.defaultHandlerOptions);
							OpenLayers.Control.prototype.initialize.apply(this, arguments); 
							this.handler = new OpenLayers.Handler.Click(
								this,
								{
									'click': this.trigger
								},
								this.handlerOptions
							);
						}, 
						trigger: function(e) {
							var width = 600, height = 500;

							var lonlat = map.getLonLatFromViewPortPx(e.xy).transform(
								map.getProjectionObject(),
								new OpenLayers.Projection("EPSG:4326")
							);

							var canvas = $('<div/>')[0];
							$(canvas)
								.appendTo('body')
								.dialog({
									title: tr('Panorama'),
									width: width,
									height: height + 30,
									modal: true,
									close: function () {
										$(canvas).dialog('destroy');
									},
									buttons: container.streetview.getButtons(canvas)
								});

							canvas.getImageUrl = function () {
								var pov =  canvas.panorama.getPov();
								var pos =  canvas.panorama.getPosition();
								var base = 'http://maps.googleapis.com/maps/api/streetview?'
									+ 'size=500x400&'
									+ 'location=' + escape(pos.toUrlValue()) + '&'
									+ 'heading=' + escape(pov.heading) + '&'
									+ 'pitch=' + escape(pov.pitch) + '&'
									+ 'sensor=false'
								;
								
								return base;
							};

							canvas.getPosition = function () {
								var pos =  canvas.panorama.getPosition();
									
								return pos.lng() + ',' + pos.lat() + ',12';
							};

							canvas.panorama = new google.maps.StreetViewPanorama(canvas, {
								position: new google.maps.LatLng(lonlat.lat, lonlat.lon),
								zoomControl: false,
								scrollwheel: false,
								disableDoubleClickZoom: true
							});
							var timeout = setTimeout(function () {
								$(canvas).dialog('close');
							}, 5000);
							google.maps.event.addListener(canvas.panorama, 'pano_changed', function () {
								if (! canvas.panorama.getPano()) {
									$(canvas).dialog('close');
								}
								clearTimeout(timeout);
							});
						}
					});

					container.modeManager.addMode({
						name: 'StreetView',
						controls: [ new StreetViewHandler(), new OpenLayers.Control.Navigation() ]
					});

					container.streetview.addButton = function (label, callback) {
						container.streetview.buttons.unshift({
							label: label,
							callback: callback
						});
					};

					container.streetview.getButtons = function (canvas) {
						var buttons = {};
						$.each(container.streetview.buttons, function (k, b) {
							buttons[b.label] = function () {
								b.callback(canvas);
							}
						});

						return buttons;
					}

					container.streetview.addButton('Cancel', function (canvas) {
						$(canvas).dialog('close');
					});
				}

				$(container).closest('.tab, #appframe, #tiki-center').find('form.search-box')
					.unbind('submit')
					.submit(function () {
						var form = this;
						$.post('tiki-searchindex.php?filter~geo_located=y', $(this).serialize(), function (data) {
							var layer = $(form).data('result-layer');
							if (form.priorList) {
								$.each(form.priorList, function (k, m) {
									container.getLayer(layer).removeMarker(m);
								});
							}
							if (container.vectors) {
								var toRemove = [];
								$.each(container.vectors.features, function (k, f) {
									if (f && f.attributes.itemId && f.attributes.layer === layer) {
										toRemove.push(f);
									}
								});
								container.vectors.removeFeatures(toRemove);
							}

							form.priorList = [];

							$.each(data, function (k, i) {
								var icon = $(i.link).data('icon-src');
								if (i.geo_location) {
									$(container).addMapMarker({
										coordinates: i.geo_location,
										content: i.title,
										type: i.object_type,
										object: i.object_id,
										icon: icon ? icon : null,
										layer: layer,
										collect: function (marker) {
											form.priorList.push(marker);
										}
									});
								} else if (i.geo_feature && container.vectors) {
									var format = new OpenLayers.Format.GeoJSON, features = format.read(i.geo_feature);
									$.each(features, function (k, feature) {
										feature.attributes.itemId = i.object_id;
										feature.attributes.layer = layer;
									});
									container.vectors.addFeatures(features);
								}
							});
						}, 'json');
						return false;
					})
					.each(function () {
						if ($(this).hasClass('onload')) {
							$(this).submit();
						}

						var skip = false;
						if ($(this).data('result-refresh')) {
							var form = this, refresh = parseInt($(this).data('result-refresh'), 10) * 1000;
							setInterval(function () {
								if (skip) {
									skip = false;
								} else {
									$(form).submit();
								}
							}, refresh);
						}

						$(container).bind('changed', function () {
							$(form).submit();
							skip = true;
						});
					});
				$(container).trigger('initialized');
			}, 250);
		});

		return this;
	};

	$.fn.addMapMarker = function (options) {
		this.each(function () {
			var container = this,
				lonlat,
				iconModel = "default";

			if (options.unique) {
				iconModel = options.unique;
			}

			if (options.icon) {
				iconModel = options.icon;
			}

			if (options.coordinates) {
				var parts = options.coordinates.split(',');
				if (parts.length >= 2) {
					options.lon = parts[0];
					options.lat = parts[1];
				}
			}
			
			if (options.lat && options.lon) {
				lonlat = new OpenLayers.LonLat(options.lon, options.lat).transform(
					new OpenLayers.Projection("EPSG:4326"),
					container.map.getProjectionObject()
				);
			}

			container.markerIcons.createMarker(iconModel, lonlat, function (marker) {
				if (options.collect) {
					options.collect(marker);
				}

				var markerLayer = container.getLayer(options.layer);
				markerLayer.addMarker(marker);
				
				if (options.unique) {
					if (container.uniqueMarkers[options.unique]) {
						markerLayer.removeMarker(container.uniqueMarkers[options.unique]);
					}

					container.uniqueMarkers[options.unique] = marker;
					$(container).trigger(options.unique + 'Change', options);
				}

				if (options.content) {
					marker.events.register('click', marker, function () {
						var popup;
						if (container.activePopup) {
							container.map.removePopup(container.activePopup);
						}

						popup = container.activePopup = new OpenLayers.Popup('marker', lonlat, null, options.content + '<img src="img/spinner.gif"/>');
						container.activePopup.autoSize = true;
						container.map.addPopup(container.activePopup);

						if (options.type && options.object && $.inArray(options.type,  jqueryTiki.infoboxTypes) !== -1) {
							$.get($.service('object', 'infobox', {
								type: options.type,
								object: options.object
							}), function (data) {
								if (container.activePopup === popup) {
									container.map.removePopup(container.activePopup);
									container.activePopup = new OpenLayers.Popup.FramedCloud('marker', lonlat, null, data, marker.icon, true, function () {
										container.map.removePopup(container.activePopup);
									});
									container.activePopup.autoSize = true;
									container.map.addPopup(container.activePopup);
								}
							}, 'html');
						}
					});
				}

				if (options.click) {
					marker.events.register('click', marker, function () {
						options.click();
					});
				}
			});
		});

		return this;
	};

	$.fn.setupMapSelection = function (options) {
		var control;
		this.each(function () {
			var container = this, field = options.field, map = this.map;

			if (! field.attr('disabled')) {
				$(container).bind('selectionChange', function (e, lonlat) {
					if (lonlat) {
						field.val(writeCoordinates(lonlat, map)).change();
					} else {
						field.val('').change();
					}
				});
				map.events.register('zoomend', map, function (e, lonlat) {
					var coords = field.val().split(","), lon = 0, lat = 0;
					if (coords.length > 1) {
						lon = coords[0];
						lat = coords[1];
					}
					field.val(lon + ',' + lat + ',' + map.getZoom()).change();
				});

				var ClickHandler = OpenLayers.Class(OpenLayers.Control, {                
					defaultHandlerOptions: {
						'single': true,
						'double': false,
						'pixelTolerance': 0,
						'stopSingle': false,
						'stopDouble': false
					},
					initialize: function(options) {
						this.handlerOptions = OpenLayers.Util.extend({}, this.defaultHandlerOptions);
						OpenLayers.Control.prototype.initialize.apply(this, arguments); 
						this.handler = new OpenLayers.Handler.Click(
							this,
							{
								'click': this.trigger
							},
							this.handlerOptions
						);
					}, 
					trigger: function(e) {
						var lonlat = map.getLonLatFromViewPortPx(e.xy).transform(
							map.getProjectionObject(),
							new OpenLayers.Projection("EPSG:4326")
						);
						$(container).addMapMarker({
							lat: lonlat.lat,
							lon: lonlat.lon,
							unique: 'selection'
						});

						if (options.click) {
							options.click();
						}
					}
				});

				control = new ClickHandler();
				map.addControl(control);
				control.activate();
			}
		});

		return control;
	};

	$.fn.removeMapSelection = function () {
		this.each(function () {
			var container = this;

			if (container.uniqueMarkers['selection']) {
				container.markers.removeMarker(container.uniqueMarkers['selection']);
			}

			$(container).trigger('selectionChange', {});
		});

		return this;
	};

	$.fn.getMapCenter = function () {
		var val;

		this.each(function () {
			var lonlat = this.map.getCenter().transform(
				this.map.getProjectionObject(),
				new OpenLayers.Projection("EPSG:4326")
			);
			val = writeCoordinates(lonlat, this.map);
		});

		return val;
	};
})();

