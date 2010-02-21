<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key={$gmapkey}"></script>

<div class="wikitext">

{if $gmaptype eq 'locator'}
<form onsubmit="showAddress(this.form.address.value);return false;">
<input type="text" size="60" name="address" value="{tr}enter address{/tr}" />
<input type="submit" name="cancel" value="{tr}Find address{/tr}" onclick="showAddress(this.form.address.value);return false;" /><br />
</form>
<form>
{tr}Lon.{/tr}: <input type="text" name="point[x]" value="{$pointx}" id="pointx" size="16" />
{tr}Lat.{/tr}: <input type="text" name="point[y]" value="{$pointy}" id="pointy" size="16" />
{tr}Zoom{/tr}: <input type="text" name="point[z]" value="{$pointz}" id="pointz" size="2" />
</form>
{/if}
{if $gmap_defaultset && $user}
<form>
<input type="submit" name="cancel" onclick="document.getElementById('gmap{$gmapname|escape}_ajax_msg').innerHTML = '{tr}saving...{/tr}';saveGmapDefaultxyz();return false;" value="{tr}Save current map view as user default{/tr}" />
</form>
{/if}
{if $gmaptype eq 'locator' && $gmapitemtype eq 'user'}
<form>
<input type="submit" name="cancel" onclick="document.getElementById('gmap{$gmapname|escape}_ajax_msg').innerHTML = '{tr}saving...{/tr}';saveGmapUser();return false;" value="{tr}Save as user location{/tr}" />
</form>
{/if}
<span id="gmap{$gmapname|escape}_ajax_msg">&nbsp;</span>
<div id="gmap{$gmapname|escape}" style="width: {$gmapwidth|escape}px; height: {$gmapheight|escape}px;{if $gmapframeborder}border: 1px solid #000;{/if}"></div>
</div>
{jq notonready=true}
function showAddress(address) {literal}{{/literal}
  if (geocoder) {literal}{{/literal}
    geocoder.getLatLng(
      address,
      function(point) {literal}{{/literal}
        if (!point) {literal}{{/literal}
          alert(address + " not found!");
        {literal}} else {{/literal}
          document.getElementById('pointx').value = point.x;
          document.getElementById('pointy').value = point.y;
          document.getElementById('pointz').value = gmap{$gmapname|escape}map.getZoom();
          gmap{$gmapname|escape}map.setCenter(point,14);
          var marker = new GMarker(point);
          gmap{$gmapname|escape}map.addOverlay(marker);
          marker.openInfoWindowHtml(address);
        {literal}}{/literal}
      {literal}}{/literal}
    );
  {literal}}{/literal}
{literal}}{/literal}

function saveGmapDefaultxyz() {literal}{{/literal}
	xajax.config.requestURI = '{$smarty.server.REQUEST_URI}';
	xajax_saveGmapDefaultxyz('gmap{$gmapname|escape}_ajax_msg', gmap{$gmapname|escape}map.getCenter().x, gmap{$gmapname|escape}map.getCenter().y, gmap{$gmapname|escape}map.getZoom());
{literal}}{/literal}

function saveGmapUser() {literal}{{/literal}
	xajax.config.requestURI = '{$smarty.server.REQUEST_URI}';
	xajax_saveGmapUser('gmap{$gmapname|escape}_ajax_msg', document.getElementById('pointx').value, document.getElementById('pointy').value, document.getElementById('pointz').value, '{$gmapitem}');
{literal}}{/literal}

{/jq}

{jq}
function loadgmap() {literal}{{/literal}
  var gmapSize = new GSize({$gmapwidth|escape}, {$gmapheight|escape});
  {* size has to be specified explicitly in case div is hidden *}
  gmap{$gmapname|escape}map = new GMap2(document.getElementById("gmap{$gmapname|escape}"), {literal}{{/literal}size: gmapSize{literal}}{/literal});
  gmap{$gmapname|escape}map.addControl(new GLargeMapControl());
  gmap{$gmapname|escape}map.addControl(new GMapTypeControl());
  gmap{$gmapname|escape}map.setCenter(new GLatLng({$gmap_defaulty|escape}, {$gmap_defaultx|escape}), {$gmap_defaultz|escape});
  {if $gmapmode eq 'normal'}
    gmap{$gmapname|escape}map.setMapType(G_NORMAL_MAP);  
  {elseif $gmapmode eq 'satellite'}
  	gmap{$gmapname|escape}map.setMapType(G_SATELLITE_MAP);
  {elseif $gmapmode eq 'hybrid'}
    gmap{$gmapname|escape}map.setMapType(G_HYBRID_MAP);
  {/if}	
  geocoder = new GClientGeocoder();

{foreach key=i item=u from=$users}
	marker{$i} = new GMarker(new GLatLng({$u[0]},{$u[1]}));
	gmap{$gmapname|escape}map.addOverlay(marker{$i});
	GEvent.addListener(marker{$i},"click", function() {literal}{{/literal}
		marker{$i}.openInfoWindowHtml('{$u[2]}');
	{literal}});{/literal}
{/foreach}

{if $gmaptype eq 'locator'}
  GEvent.addListener(gmap{$gmapname|escape}map, "click", function(marker, point) {literal}{{/literal}
    if (marker) {literal}{{/literal}
      gmap{$gmapname|escape}map.removeOverlay(marker);
    {literal}} else {{/literal}
      document.getElementById('pointx').value = point.x;
      document.getElementById('pointy').value = point.y;
      document.getElementById('pointz').value = gmap{$gmapname|escape}map.getZoom();
      gmap{$gmapname|escape}map.clearOverlays();
      gmap{$gmapname|escape}map.addOverlay(new GMarker(point));
    {literal}}{/literal}
  {literal}});{/literal}

  GEvent.addListener(gmap{$gmapname|escape}map, "zoomend", function(gold, gnew) {literal}{{/literal}
    document.getElementById('pointz').value = gnew;
  {literal}});{/literal}
{/if}
{literal}}{/literal}
loadgmap();
{/jq}