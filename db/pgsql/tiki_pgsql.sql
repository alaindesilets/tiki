--$Id: tiki_pgsql.sql,v 1.7 2004-06-23 22:33:54 mose Exp $
-- Dump of tiki_mysql.sql










CREATE TABLE galaxia_activities (
"activityId" integer NOT NULL default nextval('galaxia_activities_seq') unique not null,
"name" varchar(80) NOT NULL default '',
"normalized_name" varchar(80) NOT NULL default '',
"pId" integer NOT NULL default '0',
"type" varchar(10) check ("type" in ('start','end','split','switch','join','activity','standalone')) NOT NULL default 'start',
"isAutoRouted" varchar(1) NOT NULL default '',
"flowNum" integer NOT NULL default '0',
"isInteractive" varchar(1) NOT NULL default '',
"lastModif" integer NOT NULL default '0',
"description" text NOT NULL,
PRIMARY KEY ("activityId")
) ;











CREATE TABLE galaxia_activity_roles (
"activityId" integer NOT NULL default '0',
"roleId" integer NOT NULL default '0',
PRIMARY KEY ("roleId","activityId")
) ;











CREATE TABLE galaxia_instance_activities (
"instanceId" integer NOT NULL default '0',
"activityId" integer NOT NULL default '0',
"started" integer NOT NULL default '0',
"ended" integer NOT NULL default '0',
"user" varchar(200) NOT NULL default '',
"status" varchar(9) check ("status" in ('running','completed')) NOT NULL default 'running',
PRIMARY KEY ("instanceId","activityId")
) ;











CREATE TABLE galaxia_instance_comments (
"cId" integer NOT NULL default nextval('galaxia_instance_comments_seq') unique not null,
"instanceId" integer NOT NULL default '0',
"user" varchar(200) NOT NULL default '',
"activityId" integer NOT NULL default '0',
"hash" varchar(32) NOT NULL default '',
"title" varchar(250) NOT NULL default '',
"comment" text NOT NULL,
"activity" varchar(80) NOT NULL default '',
"timestamp" integer NOT NULL default '0',
PRIMARY KEY ("cId")
) ;











CREATE TABLE galaxia_instances (
"instanceId" integer NOT NULL default nextval('galaxia_instances_seq') unique not null,
"pId" integer NOT NULL default '0',
"started" integer NOT NULL default '0',
"owner" varchar(200) NOT NULL default '',
"nextActivity" integer NOT NULL default '0',
"nextUser" varchar(200) NOT NULL default '',
"ended" integer NOT NULL default '0',
"status" varchar(9) check ("status" in ('active','exception','aborted','completed')) NOT NULL default 'active',
"properties" text,
PRIMARY KEY ("instanceId")
) ;











CREATE TABLE galaxia_processes (
"pId" integer NOT NULL default nextval('galaxia_processes_seq') unique not null,
"name" varchar(80) NOT NULL default '',
"isValid" varchar(1) NOT NULL default '',
"isActive" varchar(1) NOT NULL default '',
"version" varchar(12) NOT NULL default '',
"description" text NOT NULL,
"lastModif" integer NOT NULL default '0',
"normalized_name" varchar(80) NOT NULL default '',
PRIMARY KEY ("pId")
) ;











CREATE TABLE galaxia_roles (
"roleId" integer NOT NULL default nextval('galaxia_roles_seq') unique not null,
"pId" integer NOT NULL default '0',
"lastModif" integer NOT NULL default '0',
"name" varchar(80) NOT NULL default '',
"description" text NOT NULL,
PRIMARY KEY ("roleId")
) ;











CREATE TABLE galaxia_transitions (
"pId" integer NOT NULL default '0',
"actFromId" integer NOT NULL default '0',
"actToId" integer NOT NULL default '0',
PRIMARY KEY ("actToId","actFromId")
) ;











CREATE TABLE galaxia_user_roles (
"pId" integer NOT NULL default '0',
"roleId" integer NOT NULL default nextval('galaxia_user_roles_seq') unique not null,
"user" varchar(200) NOT NULL default '',
PRIMARY KEY ("user","roleId")
) ;











CREATE TABLE galaxia_workitems (
"itemId" integer NOT NULL default nextval('galaxia_workitems_seq') unique not null,
"instanceId" integer NOT NULL default '0',
"orderId" integer NOT NULL default '0',
"activityId" integer NOT NULL default '0',
"properties" text,
"started" integer NOT NULL default '0',
"ended" integer NOT NULL default '0',
"user" varchar(200) NOT NULL default '',
PRIMARY KEY ("itemId")
) ;











CREATE TABLE messu_messages (
"msgId" integer NOT NULL default nextval('messu_messages_seq') unique not null,
"user" varchar(200) NOT NULL default '',
"user_from" varchar(200) NOT NULL default '',
"user_to" text NOT NULL,
"user_cc" text NOT NULL,
"user_bcc" text NOT NULL,
"subject" varchar(255) NOT NULL default '',
"body" text NOT NULL,
"hash" varchar(32) NOT NULL default '',
"datetime" integer NOT NULL default '0',
"isRead" varchar(1) NOT NULL default '',
"isReplied" varchar(1) NOT NULL default '',
"isFlagged" varchar(1) NOT NULL default '',
"priority" integer NOT NULL default '0',
PRIMARY KEY ("msgId")
) ;











CREATE TABLE tiki_actionlog (
"action" varchar(255) NOT NULL default '',
"lastModif" integer NOT NULL default '0',
"pageName" varchar(160) NOT NULL default '',
"user" varchar(200) NOT NULL default '',
"ip" varchar(15) NOT NULL default '',
"comment" varchar(200) NOT NULL default ''
) ;






INSERT INTO tiki_actionlog VALUES ('Created',1038712078,'HomePage','system','0.0.0.0','Tiki initialization');
INSERT INTO tiki_actionlog VALUES ('Updated',1038793725,'HomePage','ross','192.168.1.2','');
INSERT INTO tiki_actionlog VALUES ('Updated',1038793754,'HomePage','ross','192.168.1.2','');
INSERT INTO tiki_actionlog VALUES ('Updated',1038794026,'HomePage','ross','192.168.1.2','');
INSERT INTO tiki_actionlog VALUES ('Updated',1038794132,'HomePage','ross','192.168.1.2','');
INSERT INTO tiki_actionlog VALUES ('Created',1038794163,'NoHTMLCodeIsNeeded','ross','192.168.1.2','');
INSERT INTO tiki_actionlog VALUES ('Created',1038794197,'AWordWithCapitals','ross','192.168.1.2','');
INSERT INTO tiki_actionlog VALUES ('Updated',1038940707,'HomePage','ross','192.168.1.2','');
INSERT INTO tiki_actionlog VALUES ('Created',1038940749,'LisasPage','ross','192.168.1.2','');
INSERT INTO tiki_actionlog VALUES ('Updated',1038971383,'HomePage','ross','192.168.1.2','');
INSERT INTO tiki_actionlog VALUES ('Created',1038971411,'JobHunting','ross','192.168.1.2','');
INSERT INTO tiki_actionlog VALUES ('Updated',1038974004,'HomePage','ross','192.168.1.2','');
INSERT INTO tiki_actionlog VALUES ('Updated',1039232946,'HomePage','ross','192.168.1.2','');
INSERT INTO tiki_actionlog VALUES ('Updated',1039233364,'HomePage','ross','192.168.1.2','');
INSERT INTO tiki_actionlog VALUES ('Updated',1039234052,'HomePage','ross','192.168.1.2','');
INSERT INTO tiki_actionlog VALUES ('Updated',1039617016,'HomePage','ross','192.168.1.2','');
INSERT INTO tiki_actionlog VALUES ('Updated',1039617624,'HomePage','ross','192.168.1.2','');
INSERT INTO tiki_actionlog VALUES ('Updated',1039617646,'HomePage','ross','192.168.1.2','');
INSERT INTO tiki_actionlog VALUES ('Updated',1039617668,'HomePage','ross','192.168.1.2','');
INSERT INTO tiki_actionlog VALUES ('Updated',1039618839,'HomePage','ross','192.168.1.2','');
INSERT INTO tiki_actionlog VALUES ('Updated',1039739934,'HomePage','ross','192.168.1.2','');
INSERT INTO tiki_actionlog VALUES ('Updated',1039748495,'HomePage','ross','192.168.1.2','');
INSERT INTO tiki_actionlog VALUES ('Updated',1039768550,'HomePage','ross','192.168.1.2','');
INSERT INTO tiki_actionlog VALUES ('Updated',1039947392,'HomePage','ross','192.168.1.2','');
INSERT INTO tiki_actionlog VALUES ('Updated',1039947473,'JobHunting','ross','192.168.1.2','');
INSERT INTO tiki_actionlog VALUES ('Updated',1040866181,'HomePage','ross','192.168.1.2','');
INSERT INTO tiki_actionlog VALUES ('Updated',1040866201,'HomePage','ross','192.168.1.2','');
INSERT INTO tiki_actionlog VALUES ('Created',1040866218,'NewPage','ross','192.168.1.2','');
INSERT INTO tiki_actionlog VALUES ('Created',1040866230,'NextPage','ross','192.168.1.2','');
INSERT INTO tiki_actionlog VALUES ('Updated',1041569358,'HomePage','luis','192.168.1.2','');
INSERT INTO tiki_actionlog VALUES ('Updated',1041800610,'HomePage','ross','192.168.1.2','');
INSERT INTO tiki_actionlog VALUES ('Updated',1041822095,'HomePage','ross','192.168.1.2','');
INSERT INTO tiki_actionlog VALUES ('Updated',1042143529,'HomePage','ross','192.168.1.2','');
INSERT INTO tiki_actionlog VALUES ('Updated',1042143584,'HomePage','ross','192.168.1.2','');
INSERT INTO tiki_actionlog VALUES ('Updated',1044981129,'HomePage','ross','192.168.1.2','');
INSERT INTO tiki_actionlog VALUES ('Updated',1045204033,'HomePage','ross','192.168.1.2','');
INSERT INTO tiki_actionlog VALUES ('Updated',1045204274,'HomePage','ross','192.168.1.2','');
INSERT INTO tiki_actionlog VALUES ('Updated',1045231844,'HomePage','ross','192.168.1.2','');
INSERT INTO tiki_actionlog VALUES ('created tag: test',1057791054,'HomePage','admin','10.0.0.3','');





CREATE TABLE tiki_articles (
"articleId" integer NOT NULL default nextval('tiki_articles_seq') unique not null,
"title" varchar(80) NOT NULL default '',
"authorName" varchar(60) NOT NULL default '',
"topicId" integer NOT NULL default '0',
"topicName" varchar(40) NOT NULL default '',
"size" integer NOT NULL default '0',
"useImage" varchar(1) NOT NULL default '',
"image_name" varchar(80) NOT NULL default '',
"image_type" varchar(80) NOT NULL default '',
"image_size" integer NOT NULL default '0',
"image_x" integer NOT NULL default '0',
"image_y" integer NOT NULL default '0',
"image_data" text,
"publishDate" integer NOT NULL default '0',
"created" integer NOT NULL default '0',
"heading" text NOT NULL,
"body" text NOT NULL,
"hash" varchar(32) NOT NULL default '',
"author" varchar(200) NOT NULL default '',
"reads" integer NOT NULL default '0',
"votes" integer NOT NULL default '0',
"points" integer NOT NULL default '0',
"type" varchar(50) NOT NULL default '',
"rating" decimal(4,2) NOT NULL default '0.00',
"isfloat" varchar(1) NOT NULL default '',
PRIMARY KEY ("articleId")





) ;






INSERT INTO tiki_articles VALUES (1,'tesw','test',1,'A Test Topic',10,'n','','',0,0,0,'',1045076460,1045076538,'test','07:01 nzst','02193ee83ac93ef5d4a439b802d72034','ross',4,0,0,'Article',7.00,'n');





CREATE TABLE tiki_banners (
"bannerId" integer NOT NULL default nextval('tiki_banners_seq') unique not null,
"client" varchar(200) NOT NULL default '',
"url" varchar(255) NOT NULL default '',
"title" varchar(255) NOT NULL default '',
"alt" varchar(250) NOT NULL default '',
"which" varchar(50) NOT NULL default '',
"imageData" text,
"imageType" varchar(200) NOT NULL default '',
"imageName" varchar(100) NOT NULL default '',
"HTMLData" text NOT NULL,
"fixedURLData" varchar(255) NOT NULL default '',
"textData" text NOT NULL,
"fromDate" integer NOT NULL default '0',
"toDate" integer NOT NULL default '0',
"useDates" varchar(1) NOT NULL default '',
"mon" varchar(1) NOT NULL default '',
"tue" varchar(1) NOT NULL default '',
"wed" varchar(1) NOT NULL default '',
"thu" varchar(1) NOT NULL default '',
"fri" varchar(1) NOT NULL default '',
"sat" varchar(1) NOT NULL default '',
"sun" varchar(1) NOT NULL default '',
"hourFrom" varchar(4) NOT NULL default '',
"hourTo" varchar(4) NOT NULL default '',
"created" integer NOT NULL default '0',
"maxImpressions" integer NOT NULL default '0',
"impressions" integer NOT NULL default '0',
"clicks" integer NOT NULL default '0',
"zone" varchar(40) NOT NULL default '',
PRIMARY KEY ("bannerId")
) ;











CREATE TABLE tiki_banning (
"banId" integer NOT NULL default nextval('tiki_banning_seq') unique not null,
"mode" varchar(4) check ("mode" in ('user','ip')) NOT NULL default 'user',
"title" varchar(200) NOT NULL default '',
"ip1" varchar(3) NOT NULL default '',
"ip2" varchar(3) NOT NULL default '',
"ip3" varchar(3) NOT NULL default '',
"ip4" varchar(3) NOT NULL default '',
"user" varchar(200) NOT NULL default '',
"date_from" datetime not null default now() NOT NULL,
"date_to" datetime not null default now() NOT NULL,
"use_dates" varchar(1) NOT NULL default '',
"created" integer NOT NULL default '0',
"message" text NOT NULL,
PRIMARY KEY ("banId")
) ;











CREATE TABLE tiki_banning_sections (
"banId" integer NOT NULL default '0',
"section" varchar(100) NOT NULL default '',
PRIMARY KEY ("section","banId")
) ;











CREATE TABLE tiki_blog_activity (
"blogId" integer NOT NULL default '0',
"day" integer NOT NULL default '0',
"posts" integer NOT NULL default '0',
PRIMARY KEY ("day","blogId")
) ;






INSERT INTO tiki_blog_activity VALUES (1,1045209600,1);





CREATE TABLE tiki_blog_posts (
"postId" integer NOT NULL default nextval('tiki_blog_posts_seq') unique not null,
"blogId" integer NOT NULL default '0',
"data" text NOT NULL,
"created" integer NOT NULL default '0',
"user" varchar(200) NOT NULL default '',
"trackbacks_to" text NOT NULL,
"trackbacks_from" text NOT NULL,
"title" varchar(80) NOT NULL default '',
PRIMARY KEY ("postId")




) ;






INSERT INTO tiki_blog_posts VALUES (1,1,'test',1038714935,'ross','','','');
INSERT INTO tiki_blog_posts VALUES (2,1,'[http://www.nu2.nu/contact/bart/|Bart Lagerweij] published [http://www.nu2.nu/scr2htm/|scr2htm] and gave me credit for authoring the new version!\r\n',1040400064,'ross','','','');
INSERT INTO tiki_blog_posts VALUES (3,1,'Adding an entry to test the full text search function.\r\n\r\nHere are some search terms:\r\n\r\nJobHunting\r\ntest\r\ntiki\r\n',1040866143,'ross','','','');
INSERT INTO tiki_blog_posts VALUES (4,1,'jobtesting job testing test',1045237538,'ross','','','');





CREATE TABLE tiki_blog_posts_images (
"imgId" integer NOT NULL default nextval('tiki_blog_posts_images_seq') unique not null,
"postId" integer NOT NULL default '0',
"filename" varchar(80) NOT NULL default '',
"filetype" varchar(80) NOT NULL default '',
"filesize" integer NOT NULL default '0',
"data" text,
PRIMARY KEY ("imgId")
) ;











CREATE TABLE tiki_blogs (
"blogId" integer NOT NULL default nextval('tiki_blogs_seq') unique not null,
"created" integer NOT NULL default '0',
"lastModif" integer NOT NULL default '0',
"title" varchar(200) NOT NULL default '',
"description" text NOT NULL,
"user" varchar(200) NOT NULL default '',
"public" varchar(1) NOT NULL default '',
"posts" integer NOT NULL default '0',
"maxPosts" integer NOT NULL default '0',
"hits" integer NOT NULL default '0',
"activity" decimal(4,2) NOT NULL default '0.00',
"heading" text NOT NULL,
"use_find" varchar(1) NOT NULL default '',
"use_title" varchar(1) NOT NULL default '',
"add_date" varchar(1) NOT NULL default '',
"add_poster" varchar(1) NOT NULL default '',
"allow_comments" varchar(1) NOT NULL default '',
PRIMARY KEY ("blogId")




) ;






INSERT INTO tiki_blogs VALUES (1,1038714515,1045237538,'Stemming the tide...','A weblog that attempts to stem the growing tide of blogosity on the net.','ross','n',4,50,63,2.00,'','','','','','');
INSERT INTO tiki_blogs VALUES (2,1044982448,1044982448,'test','posted at 08:52 PST (16:53 GMT)','ross','n',0,10,2,0.00,'','','','','','');





CREATE TABLE tiki_calendar_categories (
"calcatId" integer NOT NULL default nextval('tiki_calendar_categories_seq') unique not null,
"calendarId" integer NOT NULL default '0',
"name" varchar(255) NOT NULL default '',
PRIMARY KEY ("calcatId")
,UNIQUE ("calendarId","name")
) ;











CREATE TABLE tiki_calendar_items (
"calitemId" integer NOT NULL default nextval('tiki_calendar_items_seq') unique not null,
"calendarId" integer NOT NULL default '0',
"start" integer NOT NULL default '0',
"end" integer NOT NULL default '0',
"locationId" integer NOT NULL default '0',
"categoryId" integer NOT NULL default '0',
"priority" varchar(1) check ("priority" in ('1','2','3','4','5','6','7','8','9')) NOT NULL default '1',
"status" varchar(1) check ("status" in ('0','1','2')) NOT NULL default '0',
"url" varchar(255) NOT NULL default '',
"lang" varchar(2) NOT NULL default 'en',
"name" varchar(255) NOT NULL default '',
"description" text,
"user" varchar(40) NOT NULL default '',
"created" integer NOT NULL default '0',
"lastmodif" integer NOT NULL default '0',
PRIMARY KEY ("calitemId")

) ;











CREATE TABLE tiki_calendar_locations (
"callocId" integer NOT NULL default nextval('tiki_calendar_locations_seq') unique not null,
"calendarId" integer NOT NULL default '0',
"name" varchar(255) NOT NULL default '',
"description" text,
PRIMARY KEY ("callocId")
,UNIQUE ("calendarId","name")
) ;











CREATE TABLE tiki_calendar_roles (
"calitemId" integer NOT NULL default '0',
"username" varchar(40) NOT NULL default '',
"role" varchar(1) check ("role" in ('0','1','2','3','6')) NOT NULL default '0',
PRIMARY KEY ("username","calitemId","role")
) ;











CREATE TABLE tiki_calendars (
"calendarId" integer NOT NULL default nextval('tiki_calendars_seq') unique not null,
"name" varchar(80) NOT NULL default '',
"description" varchar(255) NOT NULL default '',
"user" varchar(40) NOT NULL default '',
"customlocations" varchar(1) check ("customlocations" in ('n','y')) NOT NULL default 'n',
"customcategories" varchar(1) check ("customcategories" in ('n','y')) NOT NULL default 'n',
"customlanguages" varchar(1) check ("customlanguages" in ('n','y')) NOT NULL default 'n',
"custompriorities" varchar(1) check ("custompriorities" in ('n','y')) NOT NULL default 'n',
"customparticipants" varchar(1) check ("customparticipants" in ('n','y')) NOT NULL default 'n',
"created" integer NOT NULL default '0',
"lastmodif" integer NOT NULL default '0',
PRIMARY KEY ("calendarId")
) ;











CREATE TABLE tiki_categories (
"categId" integer NOT NULL default nextval('tiki_categories_seq') unique not null,
"name" varchar(100) NOT NULL default '',
"description" varchar(250) NOT NULL default '',
"parentId" integer NOT NULL default '0',
"hits" integer NOT NULL default '0',
PRIMARY KEY ("categId")
) ;






INSERT INTO tiki_categories VALUES (1,'test','test',0,0);





CREATE TABLE tiki_categorized_objects (
"catObjectId" integer NOT NULL default nextval('tiki_categorized_objects_seq') unique not null,
"type" varchar(50) NOT NULL default '',
"objId" varchar(255) NOT NULL default '',
"description" text NOT NULL,
"created" integer NOT NULL default '0',
"name" varchar(200) NOT NULL default '',
"href" varchar(200) NOT NULL default '',
"hits" integer NOT NULL default '0',
PRIMARY KEY ("catObjectId")
) ;











CREATE TABLE tiki_category_objects (
"catObjectId" integer NOT NULL default '0',
"categId" integer NOT NULL default '0',
PRIMARY KEY ("catObjectId","categId")
) ;











CREATE TABLE tiki_category_sites (
"categId" integer NOT NULL default '0',
"siteId" integer NOT NULL default '0',
PRIMARY KEY ("categId","siteId")
) ;






INSERT INTO tiki_category_sites VALUES (1,1);





CREATE TABLE tiki_chart_items (
"itemId" integer NOT NULL default nextval('tiki_chart_items_seq') unique not null,
"title" varchar(250) NOT NULL default '',
"description" text NOT NULL,
"chartId" integer NOT NULL default '0',
"created" integer NOT NULL default '0',
"URL" varchar(250) NOT NULL default '',
"votes" integer NOT NULL default '0',
"points" integer NOT NULL default '0',
"average" decimal(4,2) NOT NULL default '0.00',
PRIMARY KEY ("itemId")
) ;











CREATE TABLE tiki_charts (
"chartId" integer NOT NULL default nextval('tiki_charts_seq') unique not null,
"title" varchar(250) NOT NULL default '',
"description" text NOT NULL,
"hits" integer NOT NULL default '0',
"singleItemVotes" varchar(1) NOT NULL default '',
"singleChartVotes" varchar(1) NOT NULL default '',
"suggestions" varchar(1) NOT NULL default '',
"autoValidate" varchar(1) NOT NULL default '',
"topN" integer NOT NULL default '0',
"maxVoteValue" integer NOT NULL default '0',
"frequency" integer NOT NULL default '0',
"showAverage" varchar(1) NOT NULL default '',
"isActive" varchar(1) NOT NULL default '',
"showVotes" varchar(1) NOT NULL default '',
"useCookies" varchar(1) NOT NULL default '',
"lastChart" integer NOT NULL default '0',
"voteAgainAfter" integer NOT NULL default '0',
"created" integer NOT NULL default '0',
"hist" integer NOT NULL default '0',
PRIMARY KEY ("chartId")
) ;











CREATE TABLE tiki_charts_rankings (
"chartId" integer NOT NULL default '0',
"itemId" integer NOT NULL default '0',
"position" integer NOT NULL default '0',
"timestamp" integer NOT NULL default '0',
"lastPosition" integer NOT NULL default '0',
"period" integer NOT NULL default '0',
"rvotes" integer NOT NULL default '0',
"raverage" decimal(4,2) NOT NULL default '0.00',
PRIMARY KEY ("chartId","period","itemId")
) ;











CREATE TABLE tiki_charts_votes (
"user" varchar(200) NOT NULL default '',
"itemId" integer NOT NULL default '0',
"timestamp" integer NOT NULL default '0',
"chartId" integer NOT NULL default '0',
PRIMARY KEY ("itemId","user")
) ;











CREATE TABLE tiki_chat_channels (
"channelId" integer NOT NULL default nextval('tiki_chat_channels_seq') unique not null,
"name" varchar(30) NOT NULL default '',
"description" varchar(250) NOT NULL default '',
"max_users" integer NOT NULL default '0',
"mode" varchar(1) NOT NULL default '',
"moderator" varchar(200) NOT NULL default '',
"active" varchar(1) NOT NULL default '',
"refresh" integer NOT NULL default '0',
PRIMARY KEY ("channelId")
) ;






INSERT INTO tiki_chat_channels VALUES (1,'Main','Main Chat Channel',0,'n','','y',3000);





CREATE TABLE tiki_chat_messages (
"messageId" integer NOT NULL default nextval('tiki_chat_messages_seq') unique not null,
"channelId" integer NOT NULL default '0',
"data" varchar(255) NOT NULL default '',
"poster" varchar(200) NOT NULL default 'anonymous',
"timestamp" integer NOT NULL default '0',
PRIMARY KEY ("messageId")
) ;






INSERT INTO tiki_chat_messages VALUES (1,1,'test','@ross',1045321261);





CREATE TABLE tiki_chat_users (
"nickname" varchar(200) NOT NULL default '',
"channelId" integer NOT NULL default '0',
"timestamp" integer NOT NULL default '0',
PRIMARY KEY ("nickname","channelId")
) ;






INSERT INTO tiki_chat_users VALUES ('@ross',1,1045321261);





CREATE TABLE tiki_comments (
"threadId" integer NOT NULL default nextval('tiki_comments_seq') unique not null,
"object" varchar(32) NOT NULL default '',
"parentId" integer NOT NULL default '0',
"userName" varchar(200) NOT NULL default '',
"commentDate" integer NOT NULL default '0',
"hits" integer NOT NULL default '0',
"type" varchar(1) NOT NULL default '',
"points" decimal(8,2) NOT NULL default '0.00',
"votes" integer NOT NULL default '0',
"average" decimal(8,4) NOT NULL default '0.0000',
"title" varchar(100) NOT NULL default '',
"data" text NOT NULL,
"hash" varchar(32) NOT NULL default '',
"summary" varchar(240) NOT NULL default '',
"smiley" varchar(80) NOT NULL default '',
"user_ip" varchar(15) NOT NULL default '',
  "message_id" varchar(250) default NULL,
  "in_reply_to" varchar(250) default NULL,
PRIMARY KEY ("threadId")





) ;






INSERT INTO tiki_comments VALUES (1,'d25ae3a84533b6c29bd5091a3f85e5ab',0,'ross',1040866317,6,'n',0.00,0,0.0000,'test','Adding an entry to test the full text search function.\r<br />\n\r<br />\n\r<br />\nEdited at 8:20am PST\r<br />\n\r<br />\n\r<br />\nHere are some search terms:\r<br />\n\r<br />\n\r<br />\n\r<br />\nJobHunting\r<br />\n\r<br />\ntest\r<br />\n\r<br />\ntiki\r<br />\n\r<br />\n','7abe3cfdef89650bb9c6b6ffc6e225a9','','','127.0.0.1');
INSERT INTO tiki_comments VALUES (2,'d25ae3a84533b6c29bd5091a3f85e5ab',1,'ross',1040866338,0,'n',0.00,0,0.0000,'test2','Adding an entry to test the full text search function.\r<br />\n\r<br />\nHere are some search terms:\r<br />\n\r<br />\nJobHunting\r<br />\ntest\r<br />\ntiki\r<br />\n','dd0f295766976b56ce191f1460326f49','','','127.0.0.1');
INSERT INTO tiki_comments VALUES (4,'6d7f618fdb6590000b06a03865b40191',0,'ross',1041800576,0,'n',0.00,0,0.0000,'test2','test3','edba96cd2acd74c87f7f41f60ccf93c8','','','127.0.0.1');
INSERT INTO tiki_comments VALUES (5,'d25ae3a84533b6c29bd5091a3f85e5ab',1,'ross',1044980617,0,'n',0.00,0,0.0000,'Posted at 8:21am PST','Posted at 8:21am PST','7034e40ba20b87a3222213184bbd1a2a','','','127.0.0.1');
INSERT INTO tiki_comments VALUES (6,'d25ae3a84533b6c29bd5091a3f85e5ab',0,'ross',1044982298,1,'n',0.00,0,0.0000,'test','test','05a671c66aefea124cc08b76ea6d30bb','','','127.0.0.1');





CREATE TABLE tiki_content (
"contentId" integer NOT NULL default nextval('tiki_content_seq') unique not null,
"description" text NOT NULL,
PRIMARY KEY ("contentId")
) ;











CREATE TABLE tiki_content_templates (
"templateId" integer NOT NULL default nextval('tiki_content_templates_seq') unique not null,
"content" text,
"name" varchar(200) NOT NULL default '',
"created" integer NOT NULL default '0',
PRIMARY KEY ("templateId")
) ;











CREATE TABLE tiki_content_templates_sections (
"templateId" integer NOT NULL default '0',
"section" varchar(250) NOT NULL default '',
PRIMARY KEY ("section","templateId")
) ;











CREATE TABLE tiki_cookies (
"cookieId" integer NOT NULL default nextval('tiki_cookies_seq') unique not null,
"cookie" varchar(255) NOT NULL default '',
PRIMARY KEY ("cookieId")
) ;











CREATE TABLE tiki_copyrights (
"copyrightId" integer NOT NULL default nextval('tiki_copyrights_seq') unique not null,
"page" varchar(200) NOT NULL default '',
"title" varchar(200) NOT NULL default '',
"year" integer NOT NULL default '0',
"authors" varchar(200) NOT NULL default '',
"copyright_order" integer NOT NULL default '0',
"userName" varchar(200) NOT NULL default '',
PRIMARY KEY ("copyrightId")
) ;











CREATE TABLE tiki_directory_categories (
"categId" integer NOT NULL default nextval('tiki_directory_categories_seq') unique not null,
"parent" integer NOT NULL default '0',
"name" varchar(240) NOT NULL default '',
"description" text NOT NULL,
"childrenType" varchar(1) NOT NULL default '',
"sites" integer NOT NULL default '0',
"viewableChildren" integer NOT NULL default '0',
"allowSites" varchar(1) NOT NULL default '',
"showCount" varchar(1) NOT NULL default '',
"editorGroup" varchar(200) NOT NULL default '',
"hits" integer NOT NULL default '0',
PRIMARY KEY ("categId")
) ;






INSERT INTO tiki_directory_categories VALUES (1,0,'test','test','c',0,3,'y','y','',1);





CREATE TABLE tiki_directory_search (
"term" varchar(250) NOT NULL default '',
"hits" integer NOT NULL default '0',
PRIMARY KEY ("term")
) ;











CREATE TABLE tiki_directory_sites (
"siteId" integer NOT NULL default nextval('tiki_directory_sites_seq') unique not null,
"name" varchar(240) NOT NULL default '',
"description" text NOT NULL,
"url" varchar(255) NOT NULL default '',
"country" varchar(255) NOT NULL default '',
"hits" integer NOT NULL default '0',
"isValid" varchar(1) NOT NULL default '',
"created" integer NOT NULL default '0',
"lastModif" integer NOT NULL default '0',
"cache" text,
"cache_timestamp" integer NOT NULL default '0',
PRIMARY KEY ("siteId")

) ;






INSERT INTO tiki_directory_sites VALUES (1,'test','smithii','http://smithii.com/','United_States',0,'y',1051808623,1051808623,NULL,0);





CREATE TABLE tiki_drawings (
"drawId" integer NOT NULL default nextval('tiki_drawings_seq') unique not null,
"version" integer NOT NULL default '0',
"name" varchar(250) NOT NULL default '',
"filename_draw" varchar(250) NOT NULL default '',
"filename_pad" varchar(250) NOT NULL default '',
"timestamp" integer NOT NULL default '0',
"user" varchar(200) NOT NULL default '',
PRIMARY KEY ("drawId")
) ;











CREATE TABLE tiki_dsn (
"dsnId" integer NOT NULL default nextval('tiki_dsn_seq') unique not null,
"name" varchar(20) NOT NULL default '',
"dsn" varchar(255) NOT NULL default '',
PRIMARY KEY ("dsnId")
) ;











CREATE TABLE tiki_eph (
"ephId" integer NOT NULL default nextval('tiki_eph_seq') unique not null,
"title" varchar(250) NOT NULL default '',
"isFile" varchar(1) NOT NULL default '',
"filename" varchar(250) NOT NULL default '',
"filetype" varchar(250) NOT NULL default '',
"filesize" varchar(250) NOT NULL default '',
"data" text,
"textdata" text,
"publish" integer NOT NULL default '0',
"hits" integer NOT NULL default '0',
PRIMARY KEY ("ephId")
) ;






INSERT INTO tiki_eph VALUES (1,'test','','','','0','','test',1051858799,0);





CREATE TABLE tiki_extwiki (
"extwikiId" integer NOT NULL default nextval('tiki_extwiki_seq') unique not null,
"name" varchar(20) NOT NULL default '',
"extwiki" varchar(255) NOT NULL default '',
PRIMARY KEY ("extwikiId")
) ;











CREATE TABLE tiki_faq_questions (
"questionId" integer NOT NULL default nextval('tiki_faq_questions_seq') unique not null,
"faqId" integer NOT NULL default '0',
"position" integer NOT NULL default '0',
"question" text NOT NULL,
"answer" text NOT NULL,
PRIMARY KEY ("questionId")




) ;






INSERT INTO tiki_faq_questions VALUES (1,1,0,'A Question','An answer');
INSERT INTO tiki_faq_questions VALUES (2,1,0,'Another question','');
INSERT INTO tiki_faq_questions VALUES (3,2,0,'Gotta have a test question','Adding an entry to test the full text search function.\r\n\r\nHere are some search terms:\r\n\r\nJobHunting\r\ntest\r\ntiki\r\n');
INSERT INTO tiki_faq_questions VALUES (4,2,0,'Another test question','Adding an entry to test the full text search function.\r\n\r\nHere are some search terms:\r\n\r\nJobHunting\r\ntest\r\ntiki\r\n');





CREATE TABLE tiki_faqs (
"faqId" integer NOT NULL default nextval('tiki_faqs_seq') unique not null,
"title" varchar(200) NOT NULL default '',
"description" text NOT NULL,
"created" integer NOT NULL default '0',
"questions" integer NOT NULL default '0',
"hits" integer NOT NULL default '0',
"canSuggest" varchar(1) NOT NULL default '',
PRIMARY KEY ("faqId")





) ;






INSERT INTO tiki_faqs VALUES (1,'A Test FAQ','A Test FAQ',1040550065,2,3,'y');
INSERT INTO tiki_faqs VALUES (2,'test','Adding an entry to test the full text search function.\r\n\r\nHere are some search terms:\r\n\r\nJobHunting\r\ntest\r\ntiki\r\n',1040866259,2,4,'n');





CREATE TABLE tiki_featured_links (
"url" varchar(200) NOT NULL default '',
"title" varchar(40) NOT NULL default '',
"description" text NOT NULL,
"hits" integer NOT NULL default '0',
"position" integer NOT NULL default '0',
"type" varchar(1) NOT NULL default '',
PRIMARY KEY ("url")
) ;











CREATE TABLE tiki_file_galleries (
"galleryId" integer NOT NULL default nextval('tiki_file_galleries_seq') unique not null,
"name" varchar(80) NOT NULL default '',
"description" text NOT NULL,
"created" integer NOT NULL default '0',
"visible" varchar(1) NOT NULL default '',
"lastModif" integer NOT NULL default '0',
"user" varchar(200) NOT NULL default '',
"hits" integer NOT NULL default '0',
"votes" integer NOT NULL default '0',
"points" decimal(8,2) NOT NULL default '0.00',
"maxRows" integer NOT NULL default '0',
"public" varchar(1) NOT NULL default '',
"show_id" varchar(1) NOT NULL default '',
"show_icon" varchar(1) NOT NULL default '',
"show_name" varchar(1) NOT NULL default '',
"show_size" varchar(1) NOT NULL default '',
"show_description" varchar(1) NOT NULL default '',
"max_desc" integer NOT NULL default '0',
"show_created" varchar(1) NOT NULL default '',
"show_dl" varchar(1) NOT NULL default '',
PRIMARY KEY ("galleryId")
) ;






INSERT INTO tiki_file_galleries VALUES (1,'Test File Gallery','Test File Gallery',1038717160,'y',1040868439,'ross',1,0,0.00,10,'n','y','y','a','y','y',1024,'y','y');





CREATE TABLE tiki_files (
"fileId" integer NOT NULL default nextval('tiki_files_seq') unique not null,
"galleryId" integer NOT NULL default '0',
"name" varchar(40) NOT NULL default '',
"description" text NOT NULL,
"created" integer NOT NULL default '0',
"filename" varchar(80) NOT NULL default '',
"filesize" integer NOT NULL default '0',
"filetype" varchar(250) NOT NULL default '',
"data" text,
"user" varchar(200) NOT NULL default '',
"downloads" integer NOT NULL default '0',
"votes" integer NOT NULL default '0',
"points" decimal(8,2) NOT NULL default '0.00',
"path" varchar(255) NOT NULL default '',
"hash" varchar(32) NOT NULL default '',
"reference_url" varchar(250) NOT NULL default '',
"is_reference" varchar(1) NOT NULL default '',
PRIMARY KEY ("fileId")




) ;






INSERT INTO tiki_files VALUES (1,1,'gd 1.8.4','This still has gif support, right?',1040550043,'gd-1.8.4.tar.gz',257631,'application/x-gzip-compressed','�uF�:\0gd-1.8.4.tar\0�[�[�Ʋ�W���n����`�z\Z�9��4���ֶ\ZY�d��ҿ���JZن��>�{y\ZY�?�������J:[?�v�]�����v��n���F?~�~�u!z�v��n5:=!\Z�N��?�|CL��4�e(�wV0?��=J稻��_�7L��rq0t��?z�������.���i��\r��f���NԿ�ſ�������4\nk���&*��֬X|V|&����S��;�A(a0�$\"����?��e\\%��i<\n�]��Ņ��|v�PV�t���?[O}�j��QOvk��lV͚k�k�\Z��x+��E0�>��QE�����{�d�$�/B?������K5�Z�k3��{I���i�v�e�*���\nA�(���x��\Z�b�����j�-�$áݑ��E?\'�8t�_,��b��G�W��g�بW��?>���Z���^�кQz�y�w��K�,_��*�6?�P�dPȗc%���\"԰*���e��K?���\Z6�Ά��S�SQ�1�.j�:5W��mH2�YiS\"-�1��[���V�к��6a��J:s���(����F,��Y��J+�,s����W�D�K�3׉G�>R�p�i.K��W��� �+��`��և^`I?��CL�}-p���H��7��x����d�(Ї3�?�[��a���ٛ�?��c9��?�8����W�Fł=\nƓ~��~	�k5��b9�wқ�2N��scQ5h���&?��0��H��{�AV\0���\Z	�o�qu�xzv�!��9���p��#Nx�X0�ø��ttvx�%}b\"�4?�\0��>`J�\0$��^�I���(��V�{�v�6�l�7�\'��`w4|aaf\nh�uv?���J�?�c}D�b���h�W���!?����p�$�U?Q���a<*��.g(Ħ`_G�/��Ǉ�bj��t��e������������3���S{~	�hp��?c:j_[&?4$ �x1Bm?�}����X��C\Z����Hl?ja]�U�<>���l����Ro\'����_�����d��4hi�s^ނă�����XO�V�d�E�%�3���?���\rsj�I�?��!&��$6N6705�a���M}�=�^�F��.�k��[�E\n�2�̓��o�pa²)8	3|����$��$l�\\?^�ۿX�6\Z?I�Z�^�]���yoo����Z�X�,�G?��?)F�ʩ?�,Ғ��\"��W��a���������Z*�\Zƚ?R��b�r�BZ�|H����(��/�+}L��T\re@(؀���G�g2��s\03��y��RA���$E�Y�Q�V��Vrdu�(�`\n1	%e���j�-勷�?V��+�pY..?��n��@�ɮX�k?L�ɂ��K�R&��6?��+��P��r�M�/��EZ�ֿp���}��ϗ�ד�nq��R0[`�?�2]�t���k1+$����2#��/�Kp���K����e.�7��͈섘�?!�X0m�V��d��L\\@P�R]T���\'kSƯ��F���R\rJ-N#�t�����I^)���Z4?����?	���������\\c�	/hk���]�������-�Y�~�o�PA�z����\n��|H�+���^��ǇJV�-�+&�6ޙ^kt\r=7*�VJ��G��\\KA��Է1-V1�9���?��iybh���hm��3���f?q8t(\0a\nU�:�E��w�?��B������@e�1�<�i4�]<��?�4Z�������[�E���ѫ�S��2�[��.�9�k��>/�h�7�Gʛ@�A�\0q��r{~�����������C?m\"Z??ߜ\n���5;�����?����S��$\0qkvut}�<i��A����$�yY�6!\r�@+�����$�\n���QY\02?\0ȓ\Z��s2�]�Ci�G�W6:�G����k��[�\\����tyͮm��5Q��Cq\n�]�tm�u�C�;t��koP)&����=�p誈Ԣ�MWj�s���U�@��f�!4B� 4B�!�_�u�;=B��\Z�p��ݡat��{��xB�!l�m��M�B��2(R�a�V �l$¹MV�f+�	�x�ޣZa� ��g� �0��ò��6[? ���5�?� ��fM� �HgER�4E�Tǀ��0��i�l���I�z6B�����^�F:\Zi�HE�(�T$EѤ*��LwT4�C�$ MB�$M�\"A;��S߯o��l���@�4I�MV�I�M��$�&+ئl��C�B�d�i\n:$��v![��?+�q����c��&�6�`x��	�M�l�\n6\r(��Ś�6O\nl�vͼ/�>{��r? l3��tyR�\n]��%[tI�.MV��.�rI�-�r�A�eC��\\�w�E<]R�KR��`��tIJ��ګz��G�%1[�H��bҽl�_?yc?��;4 H\r?��<��#�{���Hv�m�H�\r+	�E\"��!�ᗊ\'\"��w���g��$+B�K\Z֢%ۘ�-V�6 X4�Ń?�:d��s/��,���|�l�4T�i�6��	T� �M_h��ی�g�D: A4��}X�����\ZVp�X<Y�M��I�6�m��m�q���#\re?�#��\'�^#~��O���/��Ҁ�tD0?�C�;�N��\0v����u�	��f\'�[H��V�^]�������/!��Z�T�8[��\"�-�\"�-��hq> �0��?\rz���\0�7��v���ީ~�>T\0�cJ?�:%ٗ�ng����!�\Z�\\�\Z�*�.ph>ˡ:��h2��%݂[w\\!�{�����x�a_�5�E�[��\n�o%��j�h^.�Vo�7\'�]<�O�X?���إ����A�UƓ@X���o����ֻ��/��8~#\Z�֜ k��Ľ��e�˵��(ʰ	?P1x�S���F�>\n�����Bc�1nl��(���t㾬�ẇ�	<l���)gh�?�Y�ჟ�~xҋ�_�\'򡠡���}t�Os�d^F�A,=S�P��D�(b�j$��	V�\'m�i���X�����L��?��8�uēX�*��@��0T	�r��MU�W�S�B��)F��C�h��;�`��s���@6�9�C�-�)��*1�R�n J����m҃b2�A��)��2��I�����*Q�*�C��?�3��CB~�?_�`?mz~���Q�\'?8�.d:jZ\n�҂��M�3r&�GѶ��Y����o��%�g�DX��PIO�2[bH���+q�-P{4l?���x�����>ܑ\r\Z+��o�D<{��e\r4�)T ���/����W���\r�����~c�I��E��-���� �~Ƶ�ĭ}�j�ƣ�氋���F3�6Z�Q<�*B�B��x��0L�4�_�л�8��������� ����GU?̧1?��I�8�uͅ�B+?G�;h��Lߒl\n�\'r� ? ���]�����˳[�4��8���^?��F}A�7p?��po��1��� �]��Ň,��^]�����P���A�)�߾?������?�j������a���F��4L���T���*?�=�`��!3»ӳ����RI��JV��߲݅I�B��mR1�]b��^�g��E�P�<�*��hi�$�Ģ{�\\?T\0�rmX��1�Y���d\Z*��SF�uX=?\0�	��EO��/�?8�2�L`қ�y$�r!�fAi�]�$B!�U*?�D676��Ų���zu���8#1CN�o�?��ӱq\0A��5r\n�?����Q�`L!���@��\"�+�f�\ZH��ʓ��aJp#�L9ݰ�2n��?�����n0�`i+%qT%�F��m��\"��ؙA����\Z�F?�E�.H8����˔)Mfe�?�?�!wTY�(hۀ{�*�Hߢ�����DJE���+���x��\\��L=�;lF7�7[�aܱ$H�w�lV6SJ.~uzav|�R��?\0\\PH�B�m�v	m��{���<[k?��\r\"-(\\\0[\0\0�dL��#��\0�7�`@�u�Ћ����o�����j��ݧ�7@	W��H�Qo\Z�V�J���7`��e3�őqT�V�\\/�����0n?�1|�ٟ�Xș�irO7�7�B��RGan���N�2�-��5��$�)T��w��~�����S6�4҅h&Yc�wn4żQ*�x$�����)�`)\n]�*J?ޔ��	t�F�g4�<eZ���N^�ў���i�{?ID?\0�,�����T�?:�6X�%�?VN?A�W��k\r��B�G��$f3p�xW�d�wCX�y���v�٤�Z��d���RKJu?�$TF�Q���=�:?o��\\M#<���4����|�����U��C���@��\n`�Iܺ�\n��Cq��n���`@�ҟ��22����7,�^�Eѻ�������%���<);�;����_��?��9JL�b9�/g�N�BG���\' �²2ӷ��X���2��*�R�Ti��r�?�鎄�q\"Ô��4�t���MŹ�9�=1��/B���\n��k@�c4\0�u.$B|;����B�T�Zϰ̜�!�XB4s!z`<������쾾��Xdư���#�I�A3G��o�	��TL�^b�@�Y9K�x�U7�F=Z|bo���On���;<>[��M{��t���n����t�W�?\nT�c��h׶<;G�?����|�1��|Hen�!�òx��R�k�]iOz����Lɡʒ�\Z+?���?k�EG�_�%�J+T�S�_/��<�3y~��g��<�ʙf���>���>�ѳa�i;�-<\r�6LNq���M�7�+.���\"3������seȭw���^J�A(����~��j�:���[�^V�+`�=�l:az�-u��9�XfK��R������U%~t9�m���)Tҹ��\0?���dI�k��T��3VtbQL�@�F���Q�(\Z��$�^ݩ�RHK�S\\F,��6�W�zj/��~����l����ƅ^щ5�?e��f���}A�?�z,��$���?��q扮͕�\rS�\r�^:�M�?��?�H�?R��?�?8�$�*}�y|�8�|?�Y�������Z���YN2��8.��u`\'g?���9Ƽ�n� ��c�E�7��\'&%��$W�0�?�A����u)L���Q��<.O@�D?�	1��S��H?0B�Q�/�Ox�9��Ƅ��8�c�H?�4��Z]�u����E�LJ~�Ѩ���6�,�)�f�E�=�(��?w��0�=>]�Ӵb�[&�(������`�a�����|��e�\Z����3�#v��v�2}	�Za�EM�%�(r��J�N��p)B���e&gJ��/�V?r?��{z���wԷ$�B¾:�܋�8��_	,�VI}v_�$O�iS�����z\r_B�0J4&��uT-=��/�@x,�8��e|L�H2\'�yJ2G��f���۶��������ik��\"ɗ\\�淹7����{ڞ�>yh����H�H�V��w13\0?�?����M#� 0��`%�l����t����c`ы�:A0�=^���V\\�ef::6�\Z��w�MT+�Pk��N?�Y�X����g>O��c{�k&���.�D��������[�]�K�#1�N!},�d!��*��d��o��#ڳD�\'�۱�8�?��\n�Il�PO�o���>��P(???EhB���Ӈ�%����\"�ߧy�ıR�?�++{�z�G��x�[aX*+\'��c���&?f���k+�?�J@I!g8\'>$�|��E\'\r�ܢ����v���)�Ub�{Y�]y?=^8t|Ԧ�\n���n���H�i-v�n	ي_�&����]���p�?Ma���M\"\0F͙ݮj܉��.��k;~~?�ap�Y�?\Z*0��}�X%0?�\Z�A����_��31�1��$�$��5}	AM�wq?����;q��H`_����cg�Ɵ�ӑ����~����X�vD�*�>5B��b���銋�s��R��?�����0\\� jh1Z�Ȕ�dx?R��|K��_w�w��Հ�]1[�^\r�i�VI��?_*���l�Z���\0�Kh�RmM�\0�?ꃜ���#��=/��S����?�_b�G��{�\"�.u\r���*�����D>#pv\\�����g	>~��_	B<(nZ���\n�Ĵi�;�>RC���R�C����G��<R[֟p�v�� E?�8�$yA�\\����\\2ƠO2V?�x�T�U�?59�>97���:2�U��	�NE4VGL\0�&&�O´�7zYB���p�\"�$#�tu�mB�J}���h��\r]�ܙA8��*�|�E0uW�7�9�����JA�=�h]�m����oc��&?b��8F]cD��#�~K�������r�-&S8?���8Ɨ|W�rؽDw�x�KV��j \"�X��?���F.�2�3�6�Dy	��B�<j{Y��ܨe���Z�H�C\\�H��\'1vs��lė�ͥ,��|.��@�~(z��&$KM��\r?a�\rG4��I1\0��y%�D\ZM�S����������2z����-����V&�K�LI�Fۅ��m>�޵~\"?q1\rq��4�ՓS��Z	�RI%/�N�i\nSǩ�J^��a�	��Q��.?�.��.�i\nŵ2g�Zsv�6�j	��hʠ<�P�ٷ%?�1�;?��J�@Ǒ;?Z�46}=9���n?��8�Ҍ>�?�t�o��G`�Z��j�_%��)�P���P�&DCH�,$$G?�q�Ve��5�a�������B����[�	��\r}p�7��+,��2�;��+�?�@�?9J5�#��4���W�O1�ÌV�#������?A��������/wwwwӻ>��\"�w��d��52c��`�F9{���	�ݱ��3\"*<CD\"��SCT\0fV��;�HB&�G�d�?|#ߑ�\r�}�h��ݴ?\0?�5��¸�;�pN�\\q�y���&?���tQMduG��{��y?5/�!�<>�w6��.��FFZ$lKj��sKu��~)�1��O�\\j?[r�*����\Z5t�9fB�?\Z�7E\r+�\ZV�\Z.��p�ia*QC�ih\"��?n�EF���9��N�T�T?�-�g\"8q�{p��p������U��͎��;>Fe���F)�:8�����I�0iv\"X�Z�����i�|MG��ɕ�5��W7W����?\0{/�D�Z�Jĩ���]<0\0?�gpbm�����;�C�G�f�t�?�}�0V}��:�1b�YF�{-ܙ��򚰂�3�m��O^����a%ƚ�o�0L��I>�A�����Pg\n0��]�y��G�@��{�[oD�ZLH��V�4������eM��ǘ@zń��^�?W��(�&D�2�<�x#�_X+��?ҫ��t��\n;Qس��ܾ��\0��kۋ�x�Ω������)�Soi�`Ps8W���,F!�ƒ/�|��e������̿F��t]�>£.��\0~*г���Μ锟�?���Y����R��ǋ�1L����.�s��?�qs�*��8`.��L�0Z/p3�~��ON�.����]`�f�L��R�����s�H#�,L�S�$ϖ��_C;��?������?��Ey���+�3̧���\\�l%�U�����񞆲��[\\���\"�iRB8�\0e���^TLT�(r�?؆a���+`��I��̈��I�S\Z�)J�\Ztl	������E�y�iV�S4P)�.������Ü���Pt��!ȷ;�X\Z}�#?mH��1��8ӯ*T�t?*���ӓ�I��)�)��b=�O��V�p��]��?y����7�1R�}��M�cW������EuL�QJ����\r��l۩K����}X,B�U�	_���`�r`�|FՓ�)��gut^<�J�z�B�[ ���°b��\"��s����h\'n ~���1jpy��A�	98[����Ip����� �%���$�a��	�g;�bJ59|�M�c�T�����`���	w3Γ�TX)�(�*F\Z��`a��<�~�R�;��TkK,.����x��s���2{d��\0b�\Z\Z��.d�81ƿ�� N��n��m��]���f�Uc5�>ĩ�=S�yY͌ya_xx�H�爱b��`�v���.��p��X�?�A?Iǖ�(�S�/���Dh����A0�bר�:�\Z�=w\"L��B3� ��?���TgЉ@u��\ZI�����1�C!%�V?��G�T\n�ْ�჉P\Z?c����PB�(�,`����5EH*��ܨVSu��\n4��l��_��n6����F�LK�M4�#}6�<��`/y߭y	���S�l�0�\"i�jq����U�\"d��� �D.�Tš\Z�W4h�%(~~nC�W���?��f��|��{��D��1y�jg�g&�`����W�Y�~��~�=5�>Α6F��pH<�s�Bt*	�\\�;D?!�\0���QW�N���?c��G|��o�;7P$�|��/G1�a�G䢀�~a_�?��g�yDe|���x��{w��w<���|~XU�\Zsp�š�f\r��?&�H,e6����Z ����+_���Aq6ܙB7�G���=��ch�J�ϣ�uI����P.�p��w�.�r\'?�8��:ċc�L��8���7X7/�|�$&���N��?tF\0�pn��y���Q��Ak5(�?8(���%q@�k,H���l�d�?���I�p�G-S��	?p�Vu �)���)Zyjt+g`i�E��@��3O[\Z�������!���c+R�r\r��kZ�YoAp{�	�qg�Z8!�3Ex>UO�бǉ�\n�&Ւ��G:�?/�?O���6q�U���UM���5yn��j��@�����W�?\r�?+�L9���N~�b�7�×.`�Y�U���c�Y��?|9U��EV?��uKv[��&�;�j⨨���*�B�Ҭ��k76�?��0w�f�f�0_��`����1�?���`�P�1��a���x�b�1�]��!Z��[8t�Z�=�qa�x�X&t�[-�Ŕj���	��3H��P�>��W?�cR,��mN6�R�JYٲ�\\��>��zYQ��\Zw�4�|��g����2C\0���uŸ��hF}���Y?��^?�\'8<��=ު?�[�Qm	���R�\rX}��\r<���h�E*M�wp��x\'��r0�/��&�����?}f��@�T�B?��ۀU�RAC��\0��lT��FE����\\�އlqve�\'%y>�p�θU����,�(��,�X���\Z����?�ۅM�h��~vG�G�y�H�a?WT�g~#�O�11���s󀠱��9��wJ����a�W�\n�6Ja�?�����S��q���r�h��k�$ ����M�?q��/L�JU�d�؃?NP!�؞`x`Jb��;���wW<��P�?]���?����bW<�Y�? �Q���b�V?m`?\0G��}A��~�`����G?�K�v���?�?���$�[	�����<�������x���C���w�΀�\"�G�\0��?(ڎ����!��H$�$��I�ؔ��C���ߗڙ(�5Q�J����+�AQt3��$�lإ�/��R[�j�@�-\rmc�O�3\"67x��j?uL���iE;ٱ� ~�=�/�����foߙ��\rz~A���S����s��t��?����=?y����o���do�37\n�z�\\.��V�{x������	���7���P@X?����b\'�w�o�oE<�W��Ԥh��G���9u��%�g�w��AKp���B�����+�\"l�.O��� 4u�?��<���h�,�?�_y4!Q�p�t�s��}����-�P f%*DgP1�k`�rk���PG=�`ХBMs?�q����L��8�l��~�VWb?x�bG����F;�ql�?�:���^���v:�4�h?�}{���\'�H���P��K~?B���ԭ�+�uΖ5HXL�X��A���oCx���ߢV���m}�ݱ�9�R8�]B��g?��w?D9�}/��̱6�}��6;��7�\\�5�	l	��Am(�~��YZB������B�\'4�5�y\\����gj���TI�\0�u ,���?�?�\'<}m?�ł���b,ڧ�38cf�_�?�\r�/5���r9�kK�O�V2�s0]?~�x�{0��qN��C�g�DRI`~:$7ͻ?����M���(�%NH���{���`�L�/Z_]��!��d��E[\ZT\ZX�`m��O��ׯ��ʹf�!��8���G��������^�/�D��?Η�?�\ZsB�=a4K��O~�1t�j\n��c�;:����E͔�H��9³^��I��g�?��W3>f/��^��|�~��eH�}Эh�+~��i0w�\Zl��~���U��a�\Z��k��ùLj\0�y��#uҧ)��9\n?���W`U\\��8jRS�^	�Q�C�2H_�������.�8���h�j�_1��\0���Sz95������O[y����è?�cH#��\0�	��L����~1��o�HO�+���?�?��?p�EeѡR��.�g�H���@�l��0fB=Y?O�+��-y#~����?AoK?�x�𫞈����3��/�Y򠈸Q<���z43Ra�?C(��s5KA�1�^���\Z����?U䘣��X4E<?��q:)J�+>���/�//Up����nd�\n4�k�Q��AVG�v:�O.a�Hcǧx�_�T������;t]������c:,��Y�K=��&u�H����z���?a���E�M^�붣I3ڹH�ه?�z����%���\"�mb�\r~��g5乪LU�%��U�U9pL Qv��g�!�M7������\\��&���u�=��m��Y�X����n�9���|7ٱ�?9%ҡ����הL=��1�`�𴴕?�FZ��\"S4h��o�~RM0�!`���N8���,����,��Q(�;�ṳ�ݎ��%x�̯�03(~#mާ�2��\Z��V(y��\0�	?�V3�_e\0\'�<�+IgG׽�6Z�	���?9������6?�+EM�K�b�C�&Z2�Ad��R��[ �?�GFz�y��@��?v3EB\Z�?hꌌl�//��E��?+��DA��;Јӛ\rmn�{�[sVk�m���l~9�R(iP�	�Q����k0TJ�OI��?�/�}|����WoO�x����#�cY��n��\"��?�O><~{����oOx�!P6\Z^)]�rѲ���\Z<~���?��\0�����B���\0�@��>��OR(+	�Je��*\0��\\PVa�>��O��[��F\0�]���۟�||��������lt1�|+S^8e+;�������V�*���y�٫���J2�\no~\Z�.��C�_i\Z\nÀW݋����R��%���uEV)=QA?��̞9�l�F��ڀHw����O��O|?��om�9w�����g��y�ӟA���o�Ͷ�A��?�g�g�wo8��{��~�`��l{0�;����_<ڟ%���?��?N3�?�ϛ\0g���M|ȤɈ�GK�,��=�D��?G��2���{����n�e!ݽc�k��	3���\Z�	-}�q�0rg\\ �����^�||������\'?��w���nx���]h!�-�n�����#�x��	?�\'l�m?��~?l�{G!�̈/>[8�so��{�03^�k����0?(�?a�0Yo�\"�%\\��Na?_4&�$F��^BC�`����i�V�|��3M+��oǂ�j�+\0�,�c�7v��^`SV\0��r�A^Op��?�6�`��\r���@)H\"�~AS�o�\Z`=�,�s���l�DC4�a��ۯ�{۬J0sB�	�&�\Z�?��pW�+�Բ)�f8�`Ã�.��l!�%���p�l>�\0St��h�D�5�ニs�p �B�xM�=pi�����So�E+D45�\"��9��y�%##1y<g!c�0�,v�C�h���2c����h��z�uS�R諻���iH��=V�??������h�{�{̶r�R^D��Cߖ�?/�����yfX`A�I����0��XmXv=H�!o�)7�1�%C\n�1@��#@�-��?����񦫞�S��=N+3g�B��\Z\"�`H��$ﴦE��N�<?�Θ��g*�����آ]���~LOL�\'����\"�jEb(\\�Jϼ��DX#���^����4�x#��E��%w�Ë?k>�#�A4��p��ߢE,\"<4C��je��7�ɒ�?���`��+L?`�S�K�;��t����Ew��1��M%��!����Q����Ȋc�de\\?K��rǽ^��Y���pt_�yߕ�P>gj�l?�>0�h��?2|��g\0	�3���V:��J]@ޗ	�ʓ%�����	=g��)�3\rۥ���A��fd�?d.� x$v��X���09�,�����4t��x6�;2.}����Sg��1�C�#?3WX�����]�]����G�z2u/=���hЌ����0��u-e�?���T4f`\"E��?`36\r�}�l�܎w��?K����xo7U9~����,]��`�}��$�:t(Q?����	6�������?S�c�r�iCT�/Y?���x��M}o��bt`�\\q?�/��x�7ĉeՄ���Y$VX�it	n?w�_t{������{޼翠�\\E��>�	~e�~�Ϲ{&��w�?� �3IF��4S���-\Z��N%rm�3���\\w\0�|]��Pr]Hg�C�H�`L��&�Θ3��<�������|�{�](X�(��r0w�?�3ً$PFq�ߨ�s��ٵwh�������t9����S�W�DhՉ�cS`$��XI9Q��\"���^��TL�˱�^>�o}X���L�]�#��W\"Ir1�`\n?R\r綬E?&���AA��Ujr��Q�+*?Z�������yR?-ȶ�8C���#�a�	G;�?���?1#pA�\'�-u�rq�JЈ���ekz�����X�1%v\Z$#�\0?x�Uky��j\\�s����Z���+��+qs��^����+[��+2\Z7]�`�����0C�]{л�Q`�h�d������?}|��\Z4~\r���&D��)���{r&�3�AS�B$?��n�\0:��Hr8|\n��$�C���^��������=��+	4���TYp���?�H���P??�GM#]?Z	W<J�I���V��3��T�r�Fn�?i[�֧�0�~.	�~^�}��urFm�P�q+��{r��H���0�mI�b�)]��n��2K������Ι/����*��d�p`��;���teO��g.SvV��q�p<�����d�Ҍ?�7F@�1��<?�a���7��Y��.�E�-ۻ��?�h�B�B�L�-Ǭɢ?��t@L T1!��.�yKC�����w�0i=�S/O�EE�38�#�k60k�5�b᱅�[H�5f�0@�>{%�`,3�O�����?u�`���Av0��4��lÒ9.�N�z�\'�WY&��1E�Q��G?�u�r��~�)�K����?ҪC�gҭ�7�7�g8�O�T�LW65SF�u�B�&*�\'�pq�4<g:�?��a�8r�1a_aj���\\�p�2ᠩ?��i�_�?�\r&{g\0���It�*[H��F��|���Y2�\0�P�\'������wo_�ڃ?\'��Y���c�!�:؂8��\n G�lfl�n��F��Bܕ����w1�.U�W��*UA?�Uj�m�O �В�a3ug��{�*���i��X�D�ڸ�jn;y߈�F\r|4|%gy�~$��vf^�}g��\Z6�pÃ�?m	��[�6;@?�{�����g+ߙy#���&J�T��c�0U�xZW�����l:>c:�N�-L\r��˄��C?������AX�©������7��n�g�|�oa���P�翞8Nr�?V�ճ4��>��Z/ޜ|����v���wo�x~|���9TB P�]x!��+O�)��Z*�WCf&��5��,#�E?_����{�P�v��nS��[CL�?\Z3hʰ��>g0X��%C3������2\\�<�\n��ںCd�\"���W6����5����o��O;�K�gO?����~z�����,��xk�?�Q�[��F���?ab�x�u:�BM(ڀA6ƃ�%�����/�P:f���O\'�޽Uh��!�{WD�@��K�&c����[S��_-�O��B�#�ި����O{�?����޻w�6�s\n��D��c�Ԟ/���3�8�n�|kh;vo� �?�=\\�;�s|��\Z�X߇�d�;��DL΄�x@?��)�َ�u�/?�c���_���F�`�\r��%jR��uK�?&�)��vE�&�\'\r�}�x>�H8����&�a�\rIr��9F��{�`V���ĕ����d\"��B��C;^�\"��F5DL2�\0xN�-�ҋvD�3nq�@X���78��8ݖ�W<?�s�ɤ�.!�5F_��	U��8�qoM0�����Cf�r�@>�Y1v���Շ<��,��#O�\r)H^����?�d(Q\'yLg��$AP�C<�\0q�J�����e\Z��U���I��B!-�4ͳ��6��#�8�*�=�&��mo-����-��J��\0@�Z1�ݱ�\nё�+Ɨh��d�,���������?��i[���X����%���px+�7�\'O�C��;ee�_b�|xz�:�U�-x�*���:�P���掚nO���h��8*�{�z΋�D��$��ʾ��Mr������?s}��,.�ò�V����/�W�s����ȃ�\0������1UHӹ���Êv)�Ⱦ�Ǘ_?�\0:�������x�{�����N�#�?Ry�󔨸NZ��j�S�R�NDf*/ڦ6�-MK�nT.2���p��AD?��d([&�3$;�qT\'��\"U���z���M�5�;߀s�ٕd3�)	�_U�7����?�U�A���{����g����M�ɕ�L�?\'5pueh	i�/<_\'~z��`_<~}���V����p�E��<A�ϙ�����謙Gg� q�KN8�a����.X�蠚�\'�K������oE\n�<�Hg�<��ǿV]�Ϟ��	wm��������<��c:PȺ\0V��\"?�@P�f����>�zR!�~�Ke��C�&6�d�;�@�e6�7�l���+[�9X��Uek�A��� ������T���3�!y���9�����5�s�S;@ڤѤ�������fv� \rV��P�Fe^G�˶��p�����4������K�u�D&&��+��L%�-��Q\Z����;�k�{�5.N�3b�	�\"#���t��O:�E��?���Eq<�S#�N:�`낰�s�o�H=��j�u�A{rp��?��������#\\Ul\'s-Ӧ�f#�a|�\"5$�������.bn������+=Lb[ӗ���O�x�=��\'�JO�\0�Qlm�=��Z�?ky`/�6�Z��{~�S�ge�#H��i�Dz$%F;=:\"Y���\0�V_}x^`O/\r��o��o�x�?8oz����S�\Z����%�Rr�@����D�W����x�{x)���I�⚧�F��~���C�{������|��~����Q*����y~dZ�?�44�Ɔ���������d�6�5��B���Ύv�d7%�u�06b�?��7�Wʾ�Q�{C�?�a�$�5��\n=A���X�W�RJq�C̿ƅ?2�?��+;�1�(�z�����xomi4��\n���@eI?#Z�cQZ��9�<�վ�X�Fb��.��P���H&E-0l��&E�� ��1^`��*��?��C��;��)A�\0M��\Z���w�]\0(^.>c3z��2��@o� ?�U��u�����Z@����{�R��a�����?w�X�i�-xx5��$>��@H#�׆��Z�fs?�<U�At\Z����\"�K1�#�-?�\n�\r��!�U��!�e{�|� ����p��e�?i�Y2�#����?̰c��7������W�t���on����a��r|_�b����?��7 ��������lS��ږ̨�]A���?����#��L�r`gב�6,�i)���p�?Lt�a�p�v�%-m[���X�If\\P-���ql��g��?�#$�8�~A�,K�?;��j|�T��ߣT����%����H椶�ug�?/�ɟp����4�?�M�C�8�\'J;��p��g�?4w�R�O�����G�v��R��U�|�������`�>���M)����Yz�{�\n�eD�?>}۳�{�a4p��l��?;��}�Вݿ\r�	g�:Ŋqԗ��0]���K�;fu\"d�����4�xWU�+M�JKe\'[�ϟ�%�9��Ü|A�-*1@�+��S��vp�\\ft?oUA3�2:��z[��m��U���󚱕oDO���g�-v	=�s8R����(dL\"u�`������?�g2�	��\r��f?�����~6R8�n�&��48�)��?Ѕr�?n�H��O5䠂�ę;4 C%�to	�.�q�p��3_?�<C�g�!�\ZO��\n�9S�� [�\r�0y�?_	�V���{s\r��������6�<�V���ׂ�)#?��EF�e�8� �!�!]��Jz��/5Q?��Sq����3�p����G�+����h�h�F\"%OG�����d_�nnW�bϞ�2ә��\'�K�?R�5�4�?MR_Qv���?ܤ����:��\Zwk���\\u2_�\nJOW&�vt���\\���.�7l�@��iI�/��,Ӯ��gct�g�X\"���2:�9s(�eo����{�Iq��$��Cew����Fgr�Ex��n���D*��=��0�Q�u\nu�,\'��l~�K���?���u��Mx�k�W��x�g�f�ԟ?O��t��}�Ԍ��A����I;gh&Y�?�?�Ǯ��h������>��L�l�>%��l^�hU�e�>0�5�pd&��%�M[EY,ޠ�K��?�#Q��cIhw��?�-�Pk��1%���?I�	��?�� mE5\n��=�E���\Z?<ᾆ��b������fr�	�`ol����ݿ̤Aq?_�]�,|mR�u��2Ä=�X�Z�@�n�0�a�{�aS6{6����1;lig�?�2�;�jY�)KDb\nF�?(�u5\r���q�uy.\"�G犴Ix2lU��08�1۠}?GRx��/bo6_���F$Pޒ,�F����˙r��q@��\\pK�Z#Ρ�TJp�hT)w?�xַ��,�?�Z�n����~CS�\rJ�op����F:�z�.�3_\",�tf�:��$0�rmLo�\\z36-���?H�\':���3(J��h���]-��?��ʌVޘ�WF�?�+�c�^� ���o�#��Rn�-h0�� �#QJ#|Q�+�1I�5�K^!��^;�3H��B �b� ,$��;��c�:���20ɰgs�e+*��q�ݦ��ċ��zt�x��ӈ6fG+�)ؖ���G�N���K�{�#ڤ�2Mƞ\0�+���j�`HA��r��=���#�v�z�T?���|�R�h��?����Ƈ0�!��Ǳ�#�?`�1�&?t�x�Ҳ��P�d~t�W�tK.ѽ�?�B9I��v��?i�U�O���p�a����B�~�O����b�S�Y��ˑ��;��d~̣\Z?bydL�b*�����e��?Ց�/ׇ��p���2�D+��-��H��ꇯ�=���?�0Q9:�?Q\"��#8�:��?�:�aYAa�z_�bc?����b���{�(���`��K��i��I\\I�M��v��2��d�����*K�?�w���%��w��_�9�-��O�T1f�Tp/Pr�7��@KD)���J\\D,�N�UK�.��3f g������0%��?�蜻4\n�-�O$�M����4���v\\��&r���\r� �y�F�\\⦀�$->�\nj��˅_0&I;�=�-X��C��2�si)%�˄i(^�[��-�	h�X�e����|�ב�\rZ�7�L��[���p\\���ǫ���? ��f7<���!�scq�p�\0Z�݉��񘒩k�.�8��.?�7���cW�$��d�npZV^/��.�feu��?~�o?��+��W:�nNqN���*H]����h���^#�a�|�eM�n6����.V/e��n��e?BC:s����?�P�O[uTC�v25T-�)�_|�M��E5G@�k�?|��H�U�/�d}��)�G��Ơ��T�C�?��`���{0u��P@/�3d0��M�^\'#֨nu��R�� @@���s���Qx(���X�J+���$l�2Ɋ�)/V�b�_����@���џ��ѱ�k�D\rY�ův�����D�.~���~Ǹ��7|�W4N\r�� 	4�UWTu�UW�*w�0m���`��>\np=:�����$ܑĶ?��Q\ZX�ɮ�;!�S�Y^���\"X�?��I3X�$�q?�0�Q���?O��\'��L��;�����1Y��?�H���`$�|X%m��6zl�O��|�9�x#�U�J;�ʻ��!�[�ǟ�3�l��k?��^��h��fv?c\"f�8�b�y�A�k�b�d��oX���	�A���p�!�.�|0�Y�\nGŶ�)��)PG�ʅ+��p\0u㵗4ו?dC��JT�T��WD0g ��8����#<����86k��,���s���rmNK�g)�X��t�?�1�\n�\n%�K��l�얭u�OTb�]qkT�1pjmj?G0��&nH�Fa0v日����6�؅�88e0E�w-��.X��?�\'S�a�͎ƭ��Bq���z\r6��80����f^(�(�ՓU�zQ�?BF?|bM0.CAD?P�P;�x3LU���+*�,CeF~�ߕ��_HO��v������a{���*�8��9!�@����Gw�s3�R�u3.=�/2�Ggմ3��r�b(=�U�z��.�Ɋ�%��������:U�L���ae�\'�3�J��?��A�_K�:�6�?~7��)��YY���)٬�����cУ�����N�9g�G���ө{�r�$�3V���<�j-�S�N�8���E;�r4M�-���5%�ì%�h���5��?5o?��Gjrt�6��|vE�p6+�W�Փ�\nO{�Η�U���^�<p�.`qV	o0?K��+t����%�_E��VF��+��>yo��t2\"�`�\r��Mj(����7�\r�\"XS�~q$�9d���z��Y��-G��}��iW6��\Z���UǞzQ��dp�c�ù;� �?�@Lr\n��g~\"n `-^B����?m)�,mµ\Z��WFk�t��؃�7O�KJB3��?i��2]�q\\���!#��X���11�O�7���b+<�1��N��Ԕ�B>�0%��rye� ��.����P��?Q�A��|y���䣋��8:Ҙ~�x�}t�/W^k.D\\Q�2�o����OEE]N˔أdн<�R�A�gF}�=�|��\r?y,|����د&v|_[!HL?d�ϓ4�/�Ê_��ʩClQ��i�wC;d�ȯ?�@��jϚa&ʜ�\nG[��\0��a��[�%��v����6���T$Ȋs=~\Z����P��e\\^L�!����2\'vr�pz#��K�W��iA҈K�R�U��\0H�G�h8wFt?n�M�?,ͱ 9e�}�{�j8*M��VW*���R�p�M��Lᆯ�tS���O�b���-b�a5@߉Zj2\\EJ\0�@�����aF���]�s�B��}\n��c����\\ש�շ1��OS/�ef|��M�Ց����a4�+H+��A1zY�w�X�Z�-3�v}=��z�?˂��TKRf�&��~�Q��b���m*l��h:Ӹ;v<lr~U�h��+/\Z�	��uU*��r�@<)d��?�CsRuQ�>E��FH�����c��a�鯾��>��Խ�]�,Tь�v?��_�.�\nt��7��8�o�-\n?�!m?g�b����%�/�.���;1��W����;��/N�=C\rZ�8ޫ󽺽�ڥ�b����-\\���C��=g�ݔ�0y����^R�戶=jb배�xyfU)t��<�#�]��v�/=��2�?����pE���~JUc���xB87�1L�����mr�I�қ�F?�-�|tz�?��S��ceXĔ��48�$�^�h�R%]���L~�FVI���)u\'s���,\\B`�Mh�<?�!���!B5e���3<��v�x�b����T	O����k���!�ɢt�r^$������.\'�L��b�:`*d�u�q�s�߶lf�-�I�tQ�r*��CV�l}=�\"��gf��oL�H%�������S������ğ���p�황?�z��+X?��^]p�?�)��$�r���=\"aW�+~�m�)��#�*�?�;�y8a�:^\'ϫ���.oO6�3���@vc�s��/L�,B�a��y0]?Q�4?�9?[��o{��)ψ: ���>]�?d���8�T�7^x��#B_`�F�,\"\\zc?��\ndjǥ4_G�uֱ��D�.O��\\�̽�jc����v*c�������k</|�)�;a�.�A#��ajSTl�	v�����7�>u@�@8��V���ӄŅh�O���rtn�@���i��b@�v>;�nw�ZH��p�\"�SGu��g���v�*�\\��?�x�w>�;!?R���i��>� ��r��z5op�(?���������g�h���+l�?4�J���/��#��a���j)�x9��T�\0�=?��>�0���4j�+j�����?��+�h�\0��#}?#���>�݃�{��?�2�	V��k�\Z��3����_L�\0o ���0�n*����+߼Wx!�?��{`��A�i\\��t�KTI/?:���\r^6�Z�L-��) �c���>`X�h�EF�~a]p{��7��gX����L?����I);�VS�_EGo>\n�����o���B\'��a�y\n��j�/�b���ާ�ɿ9�����L�ǿ��\Z?�V���Y��\r2Yphd��h������\"��oa{:]uD��tܱW�;.\'N�%�����fk����]�Z��A�y�x�K<�\'�χ��{�<�Qro$J�����B�i���s�1��4�r[m��cF�������hu�Є�y��;ƌӲfA2��%��#b���2�	�Ͻmp���\\A��O�Ds�0cl��oqs\"@B�xm�b��G;�R:��\'�^lC�b�\\���^��<�H,�8e�#�s��?�CH�\"�h:f�����V ~_��\\����*8喚v�t:i�G�\"����H:�yM/�T�?��7}��pxo�������wk�m�?u���%�?�\"\n/���?�`[,a/�)e�I��D�v�w0\0;柎o�w�����cw\Z�?&^o�������`c?}?M[[�7^8�`�ϸ�$����$5��̢����~����i�A��������Ckˉ�7�s�txh��<<�I���`\\�\'-�3�w���S��=�\0�f��<���_{�l�ǟ��gg�0����?Ĥz�P�cۢ�F��B>�pgܟ���[fo��}����m�,��\ZlU�?�h��\'����h�$\nM��m{l��a��U��C���KԒ��kDUbޔ	�(JL{�3�HZ�����j�1�T(#6�2�8�(��-�L3k��(Qu�?We�K�Td���W�����+�Je�강�VQ�B3?���W\rUF��vh.�Q5&g�EU��RU�yI��+6�5�7�Z��Ҩz�	808��ɕ����Y���j�L]��UqQrI&�l>�a@r�\"#�}��ɪXd`�Ux�ڊb\\e)�/���MŸj���_�������j�ڬ�*���Ƹ:�6�J��?�h�pŸj���_;����W��� Fc\\UV��r?q�Lo�+`4��~�n�61\Z�����qQ��p%rp8�6���Wt��ڻ�����}����fQ\\]\r]]���Ÿj���?[��G^Kg:����T-c[=��ͫ�3�c��fz{rt�����Z[	����\\m������]���ɢA��*�֪���/y��7�U�)�3��J��[��í,���)U����G�(�Z���js�1?�^\\�6 b\\]�u-�qՆ����o����q�\\o��\r�����l�(�U�C��sQRr���pՎޞ ���(r0.�ƗZ$9�\'�04�?�ƶ�᪩�=�\'%�ʔV��+q��5m*4�\'U4�@�0�W���-�[�D�O�����q?��6;:lZ[	�,��6��?�c�Al��&��H�Zz��{�pe��Vd@_��j������W��v�I�6�5�j͎q@���2��(�,̨ ��?�?\Z�jsq2�H-W�Fm�����oo�H�yYWk���+ʤ�M�-�u,ʴ�ke⪽8����\r�RJ%j�U����K�8��a0B*�7�1�qՖ�n��Rd4h\Z��ZEF������k��J��-&?�eY[Nĸj�o$q�4�_b�|[���|��*����?�`�B�����er.y��&��_.���HM0���,J�?E�#�\'�Z�<���W�W��׾h,?�fz{üRFn��\Zc�q�\\o�)�M�����z�z�7Лϧ�\r��J��?��x\rn��WW\Z߾V\\�\Z$�J1�<\\�\'�?1�ԇ�5.8�JRW�\'N�@���ê�j��q���&5�*�����	M���JkS���\Zj��}1�6��k:��nTՠ�H37�;���Wm�ۋ�YM�+�(��j�UW�?KU�t�C��j�V���=�=�_��P��B��<�p\r6���Cm�IW���$&�yd�F[ŠV�ս��dr8�u�U�1Ƹj��W�W��g��좵�{���m�\Z]CQU\\5��3��\n�u)j̯ڈ��\0`sE)��+���A}�p��߮�^�}�A>H%���y#\n�Uqu��@����\Zl~.U<h,Z�sm��m�~EUq�\\o��UJ�U�3V}qQm\\5���L�u�BM�Ia���7GLN[�����=�]m����e!]�Y�����k�+u\"�(�������0S��kK}o_vQ&�l���J�>�!�h�z���\Z��+,Z?lOoo>�rE�!��6]�EooP���BQ�Ĉ��XWk���QZH}�j�,\\�p�N�����x������m��b\\�\Z�?�_�	j9\\���n�5*j��������)�n���q��W��ۋs�E����Ue���T�+�T\"�kQ��Z�K]s�A1��U[��EE��:�\\Q��M�o�(JI���Y�t5?r��A��ڼ�=��F������r�nF���F��\n�ۋ��Td�h3�j�o/d��1���J�(�|�-c?�u����F����X��Z��6��� �G]T�O�?��Bi��O%d]��K*\Z��W�<�E�<�شy�\\�Z-Y�?�\r��*���?QA�Z���y�%?l�(E3���f\Z��ԇF��RT{I+�j�rЬ(g�?�_Xd���|\\X?��?R��z$k%d]�SBbQ��]wQUd5�:��n�4�D\r�\Z<��2���S7@YƶR=\Z��B�ޞ*\07RC��j��c?�a�HA���T�9��Ǭ��fQPd]��}��O�__E�aQ(�EĖ�a)d�%1�>HSQ��V/�X3d]�~�JAU�U\nYWxS�1�3��J?QOP;���+���ӌF\r������*Ⱥ�KT˒QYI�J�e�\"��H��<K�	�2SA֕�u�?M��r��j�|?y�*�jG�OA``�e��)��7�ZYmX��E?�T��eꋊj5�jdU����y\rr��E\n��0��)Ⱥ�$�7�HA֕f��E1��u?�T� ��䉼�E\n�n/T���+���?\"Y_��Lk@�_9�2���˙ZG֭_Y�\Z|d�j��U�bտT���[\r��n5�\nȺ��+ �V����[\r��n5�\nȺ��+ �V����[\r�<�Z�b�K/R?u��W@֭_Y�\Z|d�j�?u��W@֭_Y�\Z|d�j�?u���GVk��~�E\n�����	�/_�8;� Z>.0���R?UA���7�׈\n��E\n���#Y�(El)�+�0N���sh��Ws�g�?�pHꠎ���Y�Ж���� +_�O� 9��\"?@��|eEM)K��\r�����5{4��@3�EU�kd�w�6��,R������v?>4!+[�/gm,�?\"Y\\������2lx�ꗀ�_����A#��E� ��\\TD\n��?�aUY�5�(5��l�7ԒȺN>x�hj��\"Y��2L��-e%?�h�5��_Y}�)�o?5��u-R?u�\r>����@C�_���j�S&QAV[��f@?(\Z���G�j~`**�q���`ʵ�d���U�Ġ�N�RKWD�Bm�EI����ZQ4m[jQ���\r�hh�?eXI�/�|A+SA�_.�Ơ%&�:!?dU��i��n�2��(�k�,��aFV-\r>_@&)�$ ��i?�P�e����\"\r5�BV�([Y�5��t��X��1��E1��]źV����U�.V\Zj)U7Y����Z~����U��Ded�5ܾϜg?\Z29[C�V��)��_<�[d�ol���� �0s����RȺ���$8(hH�q��.�,d%4�?����m� �?1Lj�T�&f&�a�\"�����dd%B_R1���?�T!��-ei�\Z4Z�F�\nSiY�VFV���_��!�FA�^#���@�R�P� k?Y���2�\Zچ>����:lh��?u��`6�H���mӰH����#�Y?I&?����OME��ʰF�\"�Ac�aRk�A%�\"�k$Ȩ���!=w�\ZT�D��?5h�)-^�cPy˰���#k��S�B֞nHu��FV�����?�f�<&@�x�ʸe[�Ѥ�R\Z�7\0Qs@\n��}�e��@�׌@m� $�a?�cE *#+�׾`��9z-̬�hM���:��+/Z�4���3C�0[��EV\nY�4��A7���\n�j�����?��3��Y�O���?���(K�������׀P��H�\"Y���S�YMZ[1���D|\n�mUDV-\r�9�D?��ϵd�,�\\�9HX[)�v\'�\r)>m��_�*���0�b9� ���,�ʴu����Y�:�8�?�zw�n������ePiSd]a>�k���T\'�����\Z���52Jq�/��j�iw�(��`�9~�Ⱥ��Y�u��QYM}�VWJ�Y�cT?UI�7�!5f}��$d�>ɪ5@V��ö�?�U9�&T1?|1�*O�\'j%��Zr?�E\Z��NMr-�.2�e�\Z�Z��ո2�4d������X$��@�QOmZTY�4�����D�M��ˠ���V@Ve\r�mix�?UY�W�d��o��!��_���d��M�����DѠ���\\�y�dU��SkN����4ԨT�K\\��������\r�\\EDVQY�A����?�&8ndջ�5ŠR��e\"�f.����f\"��_S\Z�Ld]�-?��{�CM�(�Z�^�;��$H�?�^��QB�\Z�z���\"��_T�⯼Ȳ�<�����?l�����wn�`���5<8�X[����wp���T{�D����h�6�Z�Fo�g����7u�s\'�� �O]׷���9�;���Y����?g��w���l<ast�;o�?A���o�Ͷ�A��?�g�s?�J��p��?���������J��2����v\Z,#w:ͬ7v?o�M����M��;�?�|���ۓ��h�?x�����b�?��t�_˽�܅oo?�f|��?�&���-\\����}�:cwAK}\0o�?�:���X��2��3k�t<���������=�p���:����c��,��͚�F?�?�כ-}�7��ښ,��;Ǧ���/u_x���$����o��̙v??����~����i�A��������Ckˉ�7�s�txh��<<�	���`\\�,�3�w����^�6��t\Z\\��Q0_�Z��Ckk��w��}��Y|v�l\0Sx���O\0���b�2=�h4]�]{�l�;߶�?��81�����?����Q�4��������Ar����ݮ�M�is��\\�3X�\\�3w�-g�Eק��*+uԽ��za��ԓ��]�l�>x�����_�W�Ti�z?�Ik���8sAE��wT��bj�;���tl�b\'��Ҭ�����9cA�C��n[��?�k�;�_Kt�b5$v���:b�9	{��c�	����FA�v���z�I��s\rB�2�Ma�h��T?�^$v�΂z��)FF�?\\줆��$j�bq���jVP;���:R.������t�?J�w�Z���x�8�m�;�-��d� Y�.�I��5eRr/??Ak�r��\"�\\�>^����jgN*�e�/��c܈�PAz�� FOk�r�x�\\C��_���@�M�R���\Z�kL=uU挡5���R��|�6�s��\\+v\r$׵C�rgÕK�k�@%!�F�!P�6v��5�\\j��bT\\}?rN�\Z����fs����׉z�Rk��1z�p4\'/��F���m\ZFW� Y 5:�j�%?��Zs{c���M�g�Zsb$��?�Iӂ����g3Zs�A<�̧v22�?���ǆ�1\'e*]?\Z�2��g�Fj�Y5���\"I2n6���zZ��XKA?����?�s���k[������T�\Zp�DO�֜�H*������i1:CGP���*�y��R�QqAy�4Ӛ\Z\\Bb$�1��$�hB��h#��,�*.FO�9%PU\r-] >I��<���6R�1 0CY���&ZsBgQ�U�����<�DAb�l��<�٠^4#��RGV֚$[_k���YA��詠5����\0o^P��.=�֚8?R\'��?���\r�Bk���Yw�F���i�Wn�-�\\�����\Z���-FO�Zsӂ5��j��i-��JZvy��i#B#5щ��u?��P�\r���ל�-�U�u��5\0V=M}��Dm0�6QДŧM����r��6�[ە�Rs������������[m?VFOs�9�xS�����\'�d��RH\r���z�k�EN��A��\"q��i�5\'�h�&R5�����S_k����6d[-�4њ��|m��z�h�m��2�d�)�\0=?k^ˎ�l��?�5o=��h?�h|\ny\rq��l��N���14�[�=�?�hÛ�	?P��}�k���X=M|�m��5Ԝb�ע5k�����JA�F~A�q6?�b�6�5���i�5�k����܎���9�έ���hͩ\Zk)hߨ8��5�0hp�L\ne�n[3*�k�k���CNM5�8;M}��\Z���X2ѳ_sšՒ\\������S_knWȬ�;5@O�f�� ���(��5?�0p�X�d�G��$׽&�f�l��?5�����\'�F?�jcq5њ�mA{���֬5���1��?]��GVA�JA#�4њP���*�ƚQ��+�@��m����y-�d�`��s�\r��	z���|�\Zmh:�� �5�\n+���ּ6�)#�+t[yp1z6�k6?���Xqu��_恵5�ʅ2I��^����Y��|�mRO��s�à\\AF�mЉ��k����r���߬��	�FO�Zs�@D��9���X�䪫5���j��?��-��S��,H?}>zT���CAk��JZ�t�-� �b���k�*H�|�����P`d��T\\=��f�Ay��P��z9��i��\"�����1z��i�Md�CF��i�?$U#�?Mܸ�=����	�?R#S\\�.�6��J	���b���\nm�d�>�p\\syQ?Id�R=�~?���ݧVF-�I����\Z�7�{���1!f�飭�O���	>`P�S6Tj(E��*�?���tR���etE8?�4񉂟�a\Z�G|?����4?n.*0�l�6jZ-��4R`�e�|���4q\n~Z��\\� �A�H�6�?�����4]��u(hu}mP�e�@�c���~ڻ&�L�͓_��?�@G{�k���~md�B�?�)���Ӓ\n~6���\n��g�VAeH�l��\\����L6�ZL��*0*\"k����~6�}^������g��T�JY*�*���?���C]e�X����9~6{a`-rIC�F�F��gÙ5���h*�(��h�V�?֟3�tK!�L�F�F��R\ZR?���b�����͵Q?a+����+��SA6��RK�hm�ZF�K᧴��0�2$o3���(��p���(P�s��m_�?����+�Oë��?7��������?��ٰ��f(��.BY\'~���ϕ��e\\��>�������՟��s�?���%��?��s>~n��|�������՟��s�?���V��ϭ��?�[�9?��s.~\Z]\'��(��՟��s�?���V��ϭ��?�[�9?��s>~n��|�������՟s񳎋o~?��f�s��mCAf�?&��R`h��*��ҟ��e7;Ftm�4�%�V�@/���륽����jC���$r��jT���m�(��ӟ\r1�)@	�H4����\'�?yd��శ�F\n�J�)�����?7?]�h��!L�O���ֆ�6Pz-�H��0���5hp��M�O��Qu�T���\"�UHr>�.Es�(�֖_9b�� fc�� �,��2����ck�@��~m��נE�x���?�\nɟkh\07�@��_)�s���m(��������??M�\ZL�0�/���\nY?f�ܧ��*�lP�Ĩ�~�\n~*���9���*H�O���Z�����ds�?�?~�\'��W=�d�ϱTP\0���Z����a� &8?M�7j(�7n}m8~�\n񓚸l^�৹��	��JAu��%�Q��E�G�Oe����ʴ[6X۳OsoL(3�iR����Z����5����O�{Sm���/~��?�\0͒,�c��3�Z}��5�_N�0r�����:��_5p�� ~��\\S	���s��qK?�M��3�?�RТ��������k(����盃�\\\'V��!�3��4��[�&���6AG&�����\r��y�)��	��Ֆ�7?�\'_�O��_$~\Z�?6���\n\n����?�?k�\"~�Y__2~�5^_�(��k(P��^?M��n���늟\r����~\Z�\nH3��Xj�gP_�k৾�����MvA\n�&�6����\'��-~��l��?��?��0%5)�����<�d����W�clc����h�e�T}�ܫ?��U/�������낎���Am�u]бV����[�\0~��σ�����o��)q�o��.~���U\'?��5�����:{Z��z~���#�@uv}����\ZʂS)�<?����hmhm$\0�Jꓦ��Z�Oe��	~R���[�Z�\'F��\\�?\'\Z������t�D^\\7?��k����\n�g�w��?��<���e�q\nRFo�T�p��������K�g����?�����%��O�����o��@���?oj}ɂ�SFl?>?x��)�I����V��G?M����\\�Tԟ�tP��&T�V��J�t(��/?����Q��V0H$�ze9\r�Z탾ꙩ\\0��~Z�0��(��ȿ�T�?z9��Ò�rA�lT�?����s\rt�ǟ�?� A�t�Tԟ,����O�95�bt�|��;]���(H�k�~��[���W�?����b�d��y?Br���?��l\"�o ~*�����\r�O�����?�٨��6q��O??�m�֩�e�s\n?Z?�3��I�m�E�缩U�SINI�����R`YY���E�G6���Y��ܹ��������cm��[���<(՞9����>Z�?����<�	99�B{�M]��	m?��S���h��GN�{0S�����l������?\'�i��>��!�m�f��ޠ?���3�����p��?�������탒��#�6�?��?N3�?�ϛ\0g���{�N�?/��x�����?Zg��e����X��h>]���r/#w���O��J���?�	з�������3vD�\0V�\r�ֱ�\\�]\0�����Ϭ���$\n����\"�����ӕ�OǷ�;�����ӱYk�(��1�z����FX[�E0���ز��?y�;�.�qw掽嬻���b�L���aw����;��?���]/��?x�Z[Nd�,]��>��=x8��C��,�k���?)�w�V�y03�Y��ip�F�|�j?G�����)��\'g��3����ϟ\0<�7\n�0�-\\���h����ٸw�m	$̑qZ��s!�͚����?�F��X���`W�������ݮ�M��^���-�x���v{��]FB�wԽ�Z��KZ�����Ã��b�n�\r�hÊ��:	���=�Qb5�?/\nX�#P�h�A��A����QQz��\n��?q�5HS&5EڰɞP�3Ѳ2ؙJ8����5zk\Z?�0��U5�|�5X��3q��2XrZ�5���t������Q`6A�L/�_8��r��9��~k�X�2�5T?q����2ldM��J��L�U� ������BN�b>\n�S�����*1 ���4���m?���\\��W�X��&U����/�)�0�5��?r�a3�哤�1��*=�#2)->?���xD&m���x�e=�:���R]�ZB]<��ͬ#>���Z�Ȥ0$��j	���Q)?��W�ab3�n��Ur�^�1��x�,l�׽Pi�J^����m�8�z���q-#ڻjy��*�<W��Z��5�{�GTBg?�{K}�Ǹ�~�%є�ֲ:��| ����\0Yi�패m?!�(�8H?�?S<�J:��riR�`}�G\r90��K����s_�\Z��mƣ`��r#ZǞ��?-u?h�~�?=�#��ghQ�Tj�̈J����ϑy_���B�G�N𺺕S?eFTRg�f_c_���GS�~V�An�J#*�3Y\'�0�E��l�R�:��V�?�Hy[vDut�?\n����?�����ķ�FTRg0C�Y����?�li?Cy��U�c1���3���fq��`�=V@N���3�\\#\rU�jjB���`�#jeo\"�GT_�G�f?C9l��s����>�QK�#��g��c}#D�&��Ks�<f�>���Q}?AS���`PP9��W�G��&�!ۚ�Ti��ANu�&*̑�*��5�M�l��\Z#��g�QjF�1Wn��L���0���Ԡ�[8�Y�,\ZQu?� b�oK��\Z樎�Pf�\Z�:x?��Y�9�$�~�c��E=�����P��m|���3����Q+{)��#��4?��x�&#2T.��GtXAg�^���&X_�?op,T�G�?�&�ɰR�T��?����:���o���3��:�*/�<\\?�?A�P�Ǽ�\Z1$�Q�{��3ԗG�uT�۲#��3�����+�Ѻt�����c3���34E��稺�?���n~�)S:*9�{��Qi����g(dI^���?���ac��������o���:��7�訅�V���z~�ڲJṟ�8�[�Z�eGTOg��c\r���3Ľ�d��t���#�l:�:~m�6A{��p��Mt��#2T��x,;�u��ɷ\n+0Α������Q��v]o�o��?\"�2xnuU��+����2#jIg�F����P\Z*z�g<&`n>Gut���m?�U}V�ut���II�91)Z�vFT��?Of	�+�Uc�{����Qy����ע{?(�@{�������&�24��@9	 K�߲#*�3p���ZsTRg��WMT�?����1_xe����00͑R�h�l`��\Z�g�~�b�W2D[%�PBg(�\Z�ǼUVKe�4G��g(3�|�d��F4��\rh�~�@X� �A��ӖE�dp��T�ՠ5M?��CҠL�ʬ��\ZH�!���i �\\?��Y*5ቷ�?J(W��1����\'.��a�J~���Xx��T7MC�J��\n?�	�z��J�E�$inaxLT.�]z�J9Z��J?u	�m�!cZ��R������?���\r6�=T��T�!�?���,��yT��.�ٴTg��?�>zYn�J!>�߯2���yC2j�������)�I8�*g<*�UgHm{Z��ƥU8�u�y�t����g\ri=�Ce�mz��ʕ��zr�&�R�m�!��=�a�d=j�P��>�!�,~h?K5�ð��P?/\'�t����U�R?M��{,5�R�� �ty�����YVR�m���y\r`�M�z�!��oq�CZsb�ҕf�^�?ʦ���?�?6?\'r�C��Ejf��~?�?�<�S�C��1u�t�?�0�/O{��.�:>*C���	#���2�/O{h#e�xT���iW�4��!}y�õK��?�<�V��������j����?�?�<�A��������j�?��?�?�<�V��������I!y\r�!}y�C�$���Q��;$�QJ�W��[eH&�(��ZLK�,���ch�de?\Z� *�r�J$�=�V*�I{̧ú�TZ{�_\0���o��,)ڃ�ڼ�2��\\Y�\'�̚�\nkX�Y{�t��aKC2k*5���t�?�?��?:=כ�j����!e�eH�ʳd`D	^���R�4���2x��X�ka�52J=&�\0V�GeH�m����,��^�dM�iZ����e{�jY���=����0�R��O�D�%f֢};H>�	��k)\'�dI1uM�!e�4�7j�}�����:GU�Tz�������w\r��2$��PA�^�GeH7m�\"��(C*}�kj#�����:���a�)eH��CJ ��x)6U���Y��?Jk%9^�|�RjR�(n�pHf�A%?F�?=�C*�b�=\\�,��1�z�΄����A��kxLTVZVg����C�[��h�%+���R��n�	����\Z�7mH&���ҽZ�ac?��C�����Z?%�?kH��b=C��~i(rM�ke����+����k��Z2,�l(\r�/=��kiX6��Rj��[eH&�C>�����x���\r��ZR���ǺC:�g)��ݴ!�k@x����\rF�?\Z_��B��8�}[���CzP[�3m|L��ǆj�pP]{��C��=45.J?�T�D��<(o�?�T£o�?L;7|Hm��(K[����?�/j��!�������^}ٖ	�룴�������Ae�w݇d�5yÇT��P�|�W��?\Z��BYqHY�Q���;5�Ǌ�o�oK�R鸇\ndY<�����c>?�?���������J��*��r�&ʄF�oH�(�[�|H��(�M^�?��o��8�7��&뱇Z�$�g\r�j;$\r����?Ji��T�=\\�,��Z#<{hwH�GM�sH)Tʷ�?\Z��}�f�B����ڇT��Eŵ������!U�%K?�k9���hM[�ä�?�	��cM«�k25e�����ǚ:^�\\�%ג\nE�!�֬!��=\\�!m^{�Ax�P��T�m���kR�3��Õ���PT�J�T��fb-�a�Y�(�T�!��=4�x}�m���C��4l	�JN�a��/�k�$�C*�=T�x�`H%��\"�}݆Զ���1d=j|HR߃ʊ�?	��_9�1��&���2��o辚G���Ȳ��/?��7��[Ξ��wn�`���5<8�X[���=�w������̉����\"�k�CG�דs/�\'�Ե�?����>u]ߎK�D���v�g����A�~o���x�&ov�;o�?A�Ȭ��ٶ�7���������Q�?��C.��������2�آ��v\Z,#w:ͬ7v?o�M����M��;�?�|���ۓ7O>����;+�|W+�TƺG��2���{���~�͘��]�M`�[[������u���$\0�a�u�3�w�\0�e��g���x��gwz?o�{��������??�x���ج�i���x����z�?���\"���sl���μp�?x��{�XQw����̙vC������.�K�;���w�0���Awhm9�XK�վo��?<�������?=\n櫅wvٞ?	���&���G;:w퀽�|g\n\0�,dnu�h����ٸw�m	�e��##���H�6����{��K����{?�,�����n��&�\\��:C�g�5tg�(`��Y1��aw08��;��?��yKv�![��~�K���(��V?C��r���K	2e_^���d�z��0�2�o\Z�?��?��Z��k�F�?�s�צ�A����@�\'�!�픽�v8�M?�MR��ez�K$)�.�A��p�j���?��	�׷�HJ=ז�?���70<d���b�)�mM�Z��6Od�o)씇��$<B��J8��o��` �A؃*b2�?��J#�� pK9Y\Z%ɤub�M���?����]ERVx��sp�O\')��C�rAȺ�{��.�)��]3|J�k5\"%ۺ�ɚ黊���)GЯ�YYrD��\r��5����\Z��:���\0�nDAtRŴ,��	�3\\��\\�Cw�R�Pl��=пI(�ck��?���\\�ޔ��<�?�t�?Uw;�2�R����L��ݮ�a�4��+�;ت��l�M�}�Z��D:I�#j�a��e��е~��j_�˘��.����,�(6��j��R��f���e1�U��(4��p;C5�?A�!%w�D�]��?׺Ma���O��?�t%|W��	1??��j�O���e���y��r\'O�Z�C��Sݾ,I\r%�4�<����\nݖz�:a1�U�e���\"ͦ �&�Muu ���?�,�l�T�{\r�e�?W#����C������c_�\r��I� 㡎����xȀ��}��a��4��?R���&U�Β���n��?��??���C!?$H�\"�U�eI�Sk,]-E4U�e�@Hკ����?�j�:?w�H�,�Ǡ�L����2afI�K\r\"��T����4.�j����[w5yY\n�%�5�w5yY��9J�����eU]��71���c[�[���K��ڂ��IYV^��?-)�+�1��%�U?�b��ٗ?��<m�\n?9��?��	ga�C�����]վLLs	fn�i\ny~1�ՂcK�?��)�?-��]y�&��Zr���������Z|l��]4�j��^���5�]\n��v��\"�\n�IU��Wž�H����ܵ�襭�����?��0��T��U�/�Yh3PRpץ��&��P�։�����*�7Gu�]M^��6?�b?�P�j����|U~r����wu�Y�v�e�IAF|��&����l�%�b|�c_�մL�lF��?^*LV��݇\"�۔���\'u�e	4�#�	����C���z������@^f�8O[mG�����eI�X˺|P۾��CI|\'�?�tܵ�C+U�Ƀ:�e�!�2��S����}�CՇ��.!/K���o�ý�x�:ً4�����y&������KÈ�k,�	4P���;��K��\n?re��&��.�ڿ���\Z(��_�\0���*�Q@�2V�P��N�dc����:ƫ��&D�@}�:D%�~	��,H�h��hvLd7��Q\0�fd�=Tg*��+?���)�eU+�P�ƫ��f��H�\Zd>h8Q\0�}���;���j��o�c9�W=X�? �#�v$g,=�*>T�x�T?y�o���/9K�Z�TZJ�S�j%|�\n�me�Y���~P\0o�xI1�P9�lZ{P\0o���W5�o��U�������L��x;gFRL㹀�� ���I?d�of�ے�y��?��Q�Rҟ<��\'���a[Q�yO<�d�\ns��U\0oKr�ff�k�(�?�W����5}��7�~L�W?hr&���4i��:�d�Pr&�?��``�>(����8�kH���7�-�E�+���6��)�����	��3\0]��6�A���g)��6�A�o�䬘��o�䬑�\0~S%g�T@��*9�8P�o���t@\r\0����rB�k�M��S]���M��5�]�o�䬜��\0~S%g��@W��\0~S%g��?6�M��e�]�𪒳��j�!?z<;�)�KM���%g?p�+�x��(�Y۰EaJ6h+%ʛ�찈��F/!9�*�Τa|��b\\����\03��8P?��7}Se-)��?��b݋�\r��U�%/?�\"2�6U���\0�%��������TJ�I���U|P㩥��H?,�+p#�2�,�4�T�t.�k�9KQ�A|�	�\\%�K�\rv=/as֕,kxP\0���9S�i�x�tAk�^e||\n����3Zϖ�XwEə�0�P�]��(���9��b�)W �%F�b����?����4S�9�R\r��7�\0~?��Y\Z�1�8kPCM}m�Җ��m����̼Af?DC��w�|�~?Ut�R����^��fJVF� �[+h�^=W)NTWS_3��������:6��o��*��֔�%XL	��*��R�+1�|}��P\n�}��ѵ%g!vm\0?L��Ƶ�^�ŹƇ�\\�~���%��x�9j�\\>��ڡ�!4PkVW^7��C��*UL��FQ?Ƈ�rm����=�$��zb�����?��S�k�Puq��*��{5HE��*�<�*�/Cь���7?�ȩf��\n�j�*����x���Cy%k8�\"9��U$g�ȯ�Pyq�9��r��|O<�J����$�?�x;��) �����z��p�(�� n-�W�W�8]�\',�J��Z��W�N�M�3��\\+��ٜy�f?\\k��C!�mκ��4r�v�F1s��j������R����H�7�V��C)R)%9�[�p�&kq&�N��,�KE)���b6xA�Pi��q�mNM\Ze��+\0��͙z��CET.�PF]?��l-�P��ԦӀJ�<�}�/%9��aq�GQ�\"��<? ހx��Rh3/�}�?�	�R�����U/�-��l��}NhGy3H�?�YҠ?��0=T�esi�jCJ�\Z�bd�-�*�r�`HTy(x;��\n\0_��,	k��Y&�Pi��Q�KI��r��W����UO�dYM��u\Z(x)���ү�P\n�BًS��C�P�B�І/�����\0^Mrfq�+\0���\Z��S޴�ʯ�Ch?���j�	k�{�o�T&���R�m����<�����?l��x�L�ܹ��������cm��[��`?�G��̉����Bm���?��b����7u�s\'�� �O]׷���9�;�\n��������A�~o���x�f2�?��Ǡ�?d���l������z�?����?�d����\rWY�f��%�gFla�;\r��;?f���7Φ�X�&��?�_>{������?Zg��e����X��h>]���r/#w���O�7���?�	�\0k�\0��c����]C��Al���}�����=���:O�����.B/��~��>]��t|�����/X8��6?��7[�^o�5Y3�}�-[[ݙ����wg��[κ�n�μQ��ꇬ8t��;v������{��zap�������r\"�ɖػ}��?�=�!��~��zأ`�Zxg������`�n,�1{��s��K�w�\0X�B��P�?�˱ko�?{�ۖ@���Q��ĳ����\'���EY����8L��������ğk�X��b}?��\r-�ݷ����n�~�~��ϧ݃~������p��CFU|}�$ .��`:f������~�5����~�?�!r�?1~\n����̀��Q(ưmXʹz`I?@S�e|��+P�~��-�F&,�vƇd�(��������	M8���[dM������Q���?�4��+rM�?{٧�g)�P?�YH���������X�Xҽ�����Y���,]r,ڰ?���^��hJ�֢���(9�f\r>2c/b�ɕ��d�q�1��iy^��e��?Sfd��H9:υ��Ƭ�c��X�qg��g��^i��E¥��/��ԄTE�A��i0���<�`Y��F��-��$K�@i\r��AU�\\�G�N��G%f�AW�������^?uS�����f��h�q?�?�n�\\��I���I�5�Ѹ�M �As�����YJc?��B.0Huc�?��k�&.�鲨�?�z�~Ғ��9?���нv����+$w�q7i.P@=�Fs?m٘��m�9L1��Ӧ�؅q7�\0}�j�	?�+e���M?A?ݶ�BV7i.``�E^���R9����`��ݤ�@V+5�w��b.u��[wz�R7���C�uSNH�Q ^S���:�Q�Y(�S�B9\\ �b��6fӘ\Z[��)�J(\0y�1�fD.�!?��]�H�����ݤU6�R6vc��HSDO�ܕ\Zw��J+�di�јt\ri��T�&�Rs���,�?�&��$`*�0\Z�E`nPSy����&�\"(`Y�yZ�b?\\�ob˹2!���\n$K��M�I^ZSI�����\\����g�B�LA`n�����;��+�2�C�H����w��\nb��W�a4f�`��R?g#�<諥�\n�3y�H��&�\n�M��r�t�J?��h�?ꦜ.?�pfA?=���\nt�r�$Xʴ��?�\"0����}/�h��i\Z�ƟyHKs?�?��Y��?�\\@��Li�y����0�H^OP����������?f�w���FS������圅�q??7I. h��n@�g��.����@?�����$?����r?��3�d�vIS�gB�L�T�e��A\'R1�N&F���@--���M�E?X�J���53<�\nt?\\!���?YP�?���ϸ����\n������MH�є����I��,�f.?��̾I&�.;�$�6�9[k�~ٽl��*;�a_79SY���O��!�t1s\r	��OZ!�In�iM�c���Q��g���\rP�����R�1���Yoi7a!�j�?H��RmP~R��~��D��.K�mP�T�@�	�H\"�S�g�@�T�)D�=?�A��VV7�i�� �Bs?&� �3?I\'����r�A6�,)�J��DQS3�S�*��E|�d@a֊4�*s?ewL�SA�&3h���L2*�ǣ��*-�M������\n���I�.��O���%��!�0%�rVU�O����B�~���T�/��?1�p��?-l��f�Eх��S+��F?����4-*�φ�?1�p�l����φ�A*�p]�l��4��φ�A�P���l��\r��φ�?!�p=�l���φ�?!�p=�l����φ�A~�a��l���O�h��-?>P�A~�yQM����1�4j?MΖ��VW�H����?Z��A�n�x�S�f�k��������&�Mz����(�[\Z�\\=yνl�@4y[���~ր�T���j���ǣlR\'f��_��0��J8Kӵ!\n��y&����~1�Z?ٟ�~?���>�*?�~�}???�P�?�>[���3�f.�n<~�`Ė&��O��/)#M�]����������� !-J�����E��[��B����>�������c??jL� &�$�5�׼��5�Ϻ���N��I{���_�\Z?\'#.��~�)LL�DZi�����\"���?I����?��-�s�Y��[��0�?�$��s/OOT��g����x���m��Y�x�4���~�~��x��A)=>5�g��O��xv?��6��D3U�:�r�B�~���$-L?�)����,��^��t?�Y@�9z��\'�󠈿%�IPG��\Z���������N��|�\r���i�~�����ٯ.Ok����?ՌǦ�~���\Z���v�P�i�����~r�6����\\�����<�p1�L���49\080�c>�T@�&�B���~զJYU��$7�-W?H��DRXk�~P��{y�O������-����,M��\n�9O��+�O4���\n�~��_(�?�֔~�y��5�\\�A�ٸy�~������R�Y$�t<9�A������$*�]?�+�&�$�n��&f)S# �~���@v����m?�^Ш0K�%��)���S��\Z/��\\b����?-���Ol����Fӷ�\\XW��P?�����~d�?�d3\r��A9��y?�R�ּ�a)zk�O9~?G�J�IW�1�GN�Tt�T�4x�~ʞw���p?\"\\�c����/oG��/G���݈���z5b������o�p�����_�������p���?���˸R,�@`+m����(��g���b��R��������Io߇��z�?�$��c;<�=_ggf_�{�sF�>[�����q�?(�uΞ;�譭U�\\P}�s�T�G���?7s�������te�vKpB�#�c�s��	M{\Z0>0����F����\r��ąemy$^0l��&��Ùδ;_.�A���$wYe{�x��pg��=%����y��_��\0X�����z���s���w�;�~X?7�w�S���]�!�&�kp���.{��?5���+��;3W`���o���K/���?Y�>S-&�����Ͽ\r~g\r.N�&����g��ʟ/#��q�zX�a������)L������1CԘ��}�?:��v,\'�~��%G��g�H}�C�2FV#��w�H�r���a�/�@�\nd?|d��0Z��\n�\"&�?c�;6�\Z?�?�ڱ�n�dL�ĸ����Z��l�`��8�w�����������c���S�����0��3�?r��\0�\\�S����x:���\'%�b�Ӗ��#�)_��2e�Wi?�A�8#	&pPSt��7��툾v?Ms�&%�>��~\Z�����5�T��ck�{?x¢et�2?L�0?��3���l�f�T1!N��VeCb���q�>V?Ś�����h���@fC�ϞH[[�H�d-�?���V���wO�K���(�d���V0�?������`����\'�%~v�d��eݟ����������?͠{���E��??�B��8ҵ�(|��� $$������8p�\\F�\"������\0��L�ٮ-<7d�uX�GlZ�ExD�[�\0�y�\\�/2��mI1P�8[ple)O�l�?��\Z�`��܌��z�S��淿a�Xo|FXo��*ޱ.Iv��(t�KM��R�\0���֠Bv�O� `��\na��d+�FD��q߳a.\r$�E� \nS��Y�������_qVL�8?��b8B��/ ��� `���[��ي�@oĸ�N�G��ŕ9:��>/1\Z֔a0i�j�!�>b��?[[D�[\nɾ|6L����$ҳ�P#ҭ�\0�Yv iP��tB?#5$HL�5W8��B�b#0[���R��<wIjcsj,�ݽ#��K6H���?���e?v?�A3j���\"T�z� a٨��8��tC���,�5$q1��<�峺,�l܀C�)�q�ƺ�,��Ĩ\n�3��V��1�l4Os�e#�+Z=��\r����R2�i\\Q��6��\\�*��W����ܱO@�4I4�y��Jw�\\?��q/�O��bN���(`�=?W�R�;��wi^\r����~���פ�J�>�������}��.�S�,3w���.���?�\Z���޸>�\n��%v\nӬǓ\0l?_1OI��̋J��$�?�\rTی�{�LI�?�}C��x?\\\0m�:�\\�[�����8Q?Cd\\�2�:Ӽ{8%g]ST�?���e�pF��(����m������������~�\Z\r0?���\0&bR1����#�vZ�^����YD;��`���{���䲯,[�1{\'{�:v<��m���;Fr�T�^�D���d\n�VL?ES�Q^n&vg\0�x�GE�BJ\rpD<�Nd\04v x�c�D�\'�en�>��}��ӧ����;��l�U�\0T��)IZ�2~zЧ?�?��J0�o��|@����x��>�S[�t������\ZHw�rᬔχ�p�?h���P@�g�QkLX��.�T@�Bo�\r�7��k�g�r�εԤ�-)&y;�R\\*f9.����q��??������R�bhl��s��r�iO�ۈvi]R7M��nR�?��Y�+�Ү��y��<9��|�$�Q��H g�of��?���?3�E�6�[1�QK��X�p9��	S�W=!$��/��Y_���(�}t?�]��g��t��`��Fo\"��|C?�^��d]3�R���p%#x`��FE[1�d?�\'D��0\\��\'?�fa#>YW�?uF��e���n6������|�}q:��`?((����N�?��??y��-�6���?α���a*)åV�H؆!OC�����93z��iz�/�?�lOi�H��X��7��c��\'+XA� A��`E�ɑL2��3�9;v�ɛ�!�񊄕��2�|��?���@�5�<��D��RDb<v�rڊ?�M2ى\0{��-J5��sW�1p�*�Ҭ\"^�����d9m���6v\n�`�x����}v����wY���?�E�ؠ���wq�b�c�/^.\\6���i[B/��9�4v��%.b �p�����	n0\Z�3��nҾ�Z���(��s\\je�$.Z-�i6�^!r�$��C�n*��Ѷ;�h�^�h6����6�R�)���_˭�T^���?O߼������u���_\n�	1#���~���2�Q�}J�_�Ecj���޾z�2ٜ(�����s:]1!�� ݞV�#U�� w�(?_���?������:�]h����\0?��U*�oz�����>g5�/g���&��)�4����=.ʀ�h�j*3NhJ��Aʂ�EL�\n:B�]2��F�:h�!H�,��kw+0�d�;���ڼ��#�b�7�f��b���NM툊9�(Ai2�����?����W���?��D�/_qZ��\Z|��?�J��N��\Z�˩q�P���p�`�������M����P4�NoeBS��G[�?\rz	�E���R\"b�)#��(�v���T�Pxq�.\\��;�F�K���o`���8CF>@�¹��C�9bf��\rC�Vj]��\Z?��D?G`�a\\#L�Z���\"���FN�_����c�#���{����08�������M�ar���-	Z&.��_8&o�>��x�Ơ\0�\n���ۯ��\r�!�����r�`d?��\\�ÖG??q�&��N�ӲG��?\"�t�(l�TR	uA�RS %���/�߆}~��^��1�?���^���)���v�@\"=h�VC��>��j̓\nk�g����M]��~�-S��v�ڟ��)?���?�Ӫ@�bs��wN�?Z��Y���jE���=8B���?�o�%�����h�fj� H���K�\"Oa;��lc/�w�=�QB����&ޅ�\na���l�LK|�e9s�� �p`�\0���,`�ݑ0���F�sS��{��}ϴ���?�+F���\\Qq��sw:���Y�#�˟l KP����0`\0�~������6�P\'f�B�{�+$�����~\0O6�y��p��j,C����g��b+v������X�����BB�.�nG�H�~^���E�xz?���u�í0m0)��\r�-�)P�U$�Vq%e?5�j�M`[��Ա=n^p��!5P�|�\n���Ph���ٙz�?�An�Q>e�ӃD\Z�ì,I\"��#hh����ۡ��= ?A�\n�u0��M��:#`��?L%h/Aаu���9��V�\n�4�H�\0&��+��.�l�̂��V��c��+�b�a��8�)�\Z�,���sw�M<f����l�o�m��%�)�0���JBGǑ\"�UN,�&�+��n���;5�k�?E�]����?Q���w�����O���s��rdF�a/�b%v\0 ưw��=��\n?X��#�������[�\0\\������l��%��&�w�O��8��?a�Y����!�#��1�?���e,Ft@XU�D��?3�w�p7=��t+t??�Su�_{aG�BMUfD?���N��x�ip!�?�W\0��w��?\n[� ������gM\0O�����br0<�)L�E�����K4���������7gYz�E��7?�HX���\0x�LIY�?U�s���c�?wl7\Z�?�T���?������?�\'!��Cz�`R��?)jS�/#�8�鴸+W~�?~|�?\'I>\"@�#�\Z�3�J��U��\r,yIe�9�C�L{��M��}h��8�x��j�?R�H�k�M��}ݗ��1���q�p�4�O����� �{H��H���V�`6$�+��ؓ{9�:>���)Q.��䪰cbj���;�5��pD��Kǿ�UI`Y�6H���w�3C��AwUc!��T�=�$D\0$�	gA�#�~ٿa��$���B�kQxf,h�4�w!�!��?(�g{W�:��|p���C/KR�X��Mf���7�FB�j1���aӱ\n����m�[����F�K?:��?���<u��b��4{�,E�д#���&{��\n�Bڢ���PM�,��q��?�Q�KB(޲�6��E���X�gA0N|��m�P��%�k�k8+���#L~�K|�?͡�|�F�;*���-)$F$�f\Zt���!?v� �Wbܷ(�0�]��M��y���)�0?iĄ|�1#���c���	��`:V�?�Y�����]�ɞ57\0�,��@���W?���]P�v���q��;u#�~�]���,�Ul�	��^��O��2��e�\0]�?�Gj妺����T��h����\'����?�w���=ܿ���ȟ�<y�����?�?c���:y�����F���.=[���{�+��+Ʊ�<~�������3M��+>zl�-��9�\"�W��sт���g���K���`8밾l������ϣh���݋����S,�?�n?�:��s�Z(�X;�`�:��w?��N�����A�X��٣�����?\r�>����W����\Z?�\r?v�H_\'�=�����^�����c[$?��ς> ,F�\"�2��7;�,�?���E�B��̔\'�|���`�&t��ϙ��.a����11n��E�#�x���7�?��S�t\\����v���9�=>�В�0����l�x��/���r��ׅ�\"3ן�.�|c~J�wYC�`�T�m�Y9�M,�lL+O1-$�\\g�,�hoҳ�\\��.���-��th5���������IgY[/����?�^��<�0Sc�������:;�3=�D>g��!�P�K8�+e�<A!��#+�ˈ&\Z@?�]2$������?��[Оaʻq�6�cH�%�Q���A���* �e�8\0C{0�?�,���B�?�5�D��㬷��!آ�3.��?b��h�;�K��{�>_�m5S?^�8�;_�BL�h��.������<��&�`���L��?��l\n��]���-�\'[���ſ?uO?�@\0x�2.���4?�G�m��Ja������.�7����������=Y�]Lo��sF@��s\Z0nqt<|�^,\\�pػ�WN#�m`��!|�$jfy�34Ȝ�f��^�G������HK~.?���F�]�k��-����g[o���JD�?������0�Y;�Q?�m8��??�?�<۰hwA�|�4��?��|�\r�S/�9s�\0R�����h�̔)&��W�=�\nѠ??rm�;P�?����7�a���lxE���4�m~N� �o�:��+����8^�=��ED�;c\"8$\rc��#X������¼��,67)����d[p���wD��y��d?%3`���$�\'��WL�Є�?{?N�����Y�Lx�W??����#��?A�����/\"�x�J|�Pw1A�\'��`�2�9�����#���\\a D��/���6	���ц�ǀ������\rtQmR�8�\'�?o��?�:�ْ-&Ss1��=4���{Er�7��?��~d�_��\\�t�M�Z],ɪ�L��%?~>���S����~|x&,�����}�V(��l�;���5�be,��b^$_B��1�$��8/D��?�.�4��֜)�rq\Z54C��t�#� mPTAa��v�J�|eh�ቑ��a�s\'�.���?3����s��e?��??�]�/��y��H��~d�4����<z�_>\r�f���l�ӳ���c���7���o�b�K�=����/@��N��L?ÒXI��D\'K\\?L�tȈq���y�Ͻ9i??�^\"��C?J�,���ʶ?9r�oź8Ӓa��k�|b ù�h�	��?C?� ��A���sb�p$����d�����!��(����)L]�s?���~9��ĵ?\n�uah�X�erc����w�����?\'�����o��=�_�{�����h�د_�}�h+k6����=�7�\Z<x��?�������0qFV�Sе?�5vf��,�f�����3��a?|��S��9��t?|���C0UoZ��d�	-�c���u��y��f.h)\'!+\Zb�\rE%������Ek�Ͻ)S(v���i�qc/��w\ZL�(?������|����q��L�#�_FJ�9��~\Z�	�u�g���~�>�������]H�KH�$���&��-�?�6�B��S��C��	3\nX�/E���1?��Bl�q�����?f��4 �\'\0C���_�5n?a6v�]ɱc��Ά�\'���Q,�9S*�6�b�h����c��������uM5���]� -�3�O������øt2�H�bð�/0�x��Nui�Y#�G=̙�h?��d??��P;�	p�Lv��\nv���v�ټ،{��IG��h�G٧N.(�����^�o�\\��w��f�l��A��%��q{?>�٪��81ڂdjj��~��ns���eb���SȄ��=��,�K����ru�jԒ�m9?�??�Wǽ�xNp�K�(8@1R\Z1�f�@�V��<pָ*�����(?�@��1%1D�N���)��R�\\�1�?�S��h3iM�ȇ�1�R5��!���X�s�$??dc\"{�\"p�+`�$=����W�[�w1����bgCG#�/<�.�-�gC��/��87��!������q?pl�>f��d�^L��4X�>�Yz@n�Y�c���4=P�=��~��6�L) ��#�\0Pz4K�=�z�}+��K�D���t���b����gY��¹Gb\0�?34�|t�- n��\rϖ��cU,��c�[�c6�a�w@��P?��)�&��;��v��N�(?5�\"�?cD�L[r���+�l�L�����v�?�;im.!�\'��<�G6�\\?&�g�e�d�)������5�,E}c�Dw8-��:�J�?ΒX�L?��+�-����_�h��,jV�@8\'A�\\\n��0���&Dd���+yb�w?�?�?��o�£O�?\\˱?yl��~�dJʜ;�O�d3��������e�b=�w��q�0S�-!������������{�1�/Z������9e��.~\'?���G��,e���\0u��^�\n�x�DKX�b����|��������p{���T?C��C����\ZP7������oC��\\랹>��ޅ�cl�玗w\'�}�B������|��u�Tc��3487�g	� ��O���!\0����K���0��?L@���\ny�{2�G�\r��$f��?��+3\ZM�Ohc H3���嘕O\"�5�<������\n4t��f��fY�f��]WlH���!��rN�!ߢ��]�D\'d=���7$�8g�&㔡�e��KG�0�:�����r�2Oa�?��8v?�ó;Ƕ���]p?L�8_r8\0�?L�A��y�>(T*A[rF<���?x��Ի�d1�~��p�SӰAo�n���[��xEp><�����)�2�=G]0f���~p//_��hð�vH�D���B 3{�������`��c�=�Y\0�G\'��?�?��$u�$uķ�\"�1K?\'�\\�8����46?H\"5���<h�^ް�:>��`	��Nm���7?T�J�9��8�Am����O�T�9��?Y�/���L�GI܇�{����<�`��Y��n����us��\'S?���c�0��)�ƥ����)0���x�t�̱_��7 �}���u٢e��ΤXR|��˦��XAՌ�P?��%,�/������vڤ5~?aT�?(��	F?:�Ä�<{���O�O>�����رP��M�s�V��j0���cr�H�?��)�u�pq�.���G��f��4$�3ohǕQ��s�⧧˳�w���LA�z�lH\Z��	?���\0�`u�4zfDP`����+RO.���7�7�2bq�q�K��a+��??	?1PEbY%<���Yj:q:D�0�@�A��ޅ�H�ק c�zd�WDF{&2R�\0r�0�����%Gmo�c^�L�#8���Yt$�;�?�D}:\'7F`�0UWodc�ϸ=��<q���O?!{J�B!m�o#��rE1NT�^���?�M(\Z��b�ZF���:�ĪX]c�Q�����J�?^r��^��{G�u«�t��ݛ��O�`�],�{���[�ʈRZ�㌖�\"��]�q>�Ⱦ�ZD���Ȧ<�\r}Ҥ�Z���\n1����wؙ?�����]/(X��Y�5��-f�x�+�8�D?�A�����O�$ZˬR�ݖ:���|�6]�z��g��|�Fa8h��2z??���3����e�q�`�|\rV�&:{7�[/�W��`���)a>�^@�\r�<v\'�;��&IsE?T�.ͱ�4#?z>c��`�xy�o?�z����?B	�\\t�/�:�C�iԽyZ�t?q�>�1��p�{��QW�8�T3\nGL�E�?TG.�_�i�.h�6W�I\\,R?(\\V�$�|�\r�Q����-~ץ�!��1:�i1ܺ��S\"��жlX?�	�o{����@�=�\0{��A%�.^1i���[���W�6)�*�`���+�*����}.\0пF�Z�dI�kF(�ݴ�?�􀻻Ȭ��8a����KjG�1�X�l�ᄂ6�yo��0\r��?1L�,��4����z��+�0�.I�|xڋ�E��?�G�2l�.\rX��?[7Wb�]�w)�<�8�?��W�f=$�c�Ƣ!�7O\'�B�?|��b��v_<��\0R8f\\���:͘�D�iO�4��1w}8���i)\"AqB)1�\r���?�\"`T��:?r��u.��Ic�]+&`����z�.�?y�mq7���1�${���=M�y�3�ܣ���=�3�L�?�H�#?$�&������w)={�?ߌT�G\'���;O��)]_D5�8a��9Z\nC<��s0?�1����a6#��(Ե���g`\"=�ְ���/sz\n��=M�?f��p6�n$�_EKS&��(��Ѱo�FK�GZxF�i�a�紲�UE�\'t��	�_6ON�\nƣ���R���|��\\F&�����:sƻC7���[Py�?���*M�<�7P�?-�x��m���U�����\09��t��Y�Cr�_<O�y��<��>hsp*��BKى���M\"��9E��6��_gQ �+cBw���8������p�Z��Brj���_�K�����/Y��W��Y���hX��s7���!?q6?3�oq�-�f4o?00c��Όv|Y�.��`��g1��\Z��Dި�?�\"�\\��&C�*��0��N;Pr�l\0��k�7�Ў� �E�O�.ޞ����A?=X�4�sd-�I`It�%4�y��5�n�ELi\'�$�x?v{²��0���ǯ�d?y�G�g�y�\0\no������訋�\"�oM��n>?F\0����svR�����c�v���S2*p� ��Ž�?M���]֪�\0���d�I�7dm�L9� �����?��,�j��/#4l�����W���t$�O�/|{��tcp=_1�tq(_�دf,I�����S6�B\0[ⶑ*bQѢ�����@>��>��$�蕟,a��N��x$��{�4���K�L�2�5�\0V235a�� ?~��_?��1����)��$���G���q���\\���9D�E��@�ɜ�Wh��v�IhAƪ?]��S\'`�~3z�����w�����\Z�_j��-qQq�1�tc|��I����?�ȿ!7όq��������5�Aޘ����X6�T�0��+�\"5-R�P8b���)��#XO!�fc�Rp+r?�vm��a�:�\"`����e�+��?X�<X!�?P�ʰ�!�wf���1��{JB����n�Y����)���?�Z�/3؇w�8��G���� %�\0x�gOO�t{���)0&c?8S�h_���d��at��sZ�)���A���%��p�C�e�������U�df|��K��%�I���B��@Zc\Z�\r�CS�|-W�eq\ZϨ�L�z����jp�4�����?��?2�S�PPѮ�>?y@T\0D-��E/[�\Z|X��j���bZ�-=:�LMN�q�\Z�c��^PU=9a�E8�m�){�k}E�ņ,��pw����;t�w��p�GJ�b�:ch���]Qu�c9t;sLQ�L~IG��r�3�2K��N��p??t�[V��a��!r?�ɀ��A��g�Iݱ��%�/���Tf]���X�Bm@=�v�ي���W�ֿ���O���䒮w���r�C��������V-L:P�s?\"j�m �����RlP)�V(8�)`r~*Y\'?\r.\Z!-v�lR�:��b�\"�o���O�S0�N,⟻��1�ƕ�\0��r4cY,\n�d��C%�P�)R ? ���?$�o������C���w�YG�h��9*d�,��q�R�v��\n���D\"��a��*�����ԃ��h�<ɀ�e�D�����3�I����g%Q>Z?�XZȤ�[$8��G|)�9�,�?Y{�Ida�߅{i猧s��[7bR����P<�낔<<d���e�E?��n_>�+f9g��]��P��8�)?°!����L�rt&����M#a��?B�\ne�gQ���$�8z��飷��82�����f����c_5mi;2�����(#�1t	�� �*qc���S�B���S����Z����P��<� ]?C��\";�M!f?���Y�J(�:�?qg\Z{��I���)?ꑖ$��S������	Ϛh@���j(献�!~�Xb\Z�?��?L��:��-\0�j�F�}���~Kǻ��.��������?i�?�]*�M_�یFVb����Ŝ.�OW�l�jF�=���c�y���C2s;?q*c�1,��|�[�B\r���`:�ek���K	hO�~�]�~�$���s��d\Z�bW1�܋�@t?��S_r�<?^��8#<=� �2�[�`���%�`C�M0^�Q�� )���;�!6�(tCd�gʫ/h/dr?�ccdtl����\"�r�Q�z(��J,rp�?����ڰ��A�F�?u�4�\n$��fB�<]BE�8���Y0��R.Ɏ?��̙���t!�yO2�y��mϠ;R�R���4ƙ���S�0���)��2�hROXs��6�5�����T���+U�0xU�&	?�ky0�?��5��?�f0���M�$Fw?����\0?7�`6��?5���@y���[��h��g�D�!Ӄ�����˱�4��K���\0	8��)�0@�\rh�S�>?.?��*f�\0�e/\r�<��?�B��\n���_?��[�y\r�E=���J���\n�#���W�t�)��IE��D}�Mu���Ε!��q�?�8���?站Ό��|��S�h��Q�oV<��Ub�w���.{LWg��-3@\"p��8g� �?Ğ�y�RI3�`�GG5I.��%�hAJ#?w�}�|�Oú%���	�����¯���{0.�D_!!��>v���t<;��#�\nE�?���3xvu�6�\Zg���?a�Dlb�lPfCp�|G��9#/��rQ����\Z\"H��@?	����~�,1�M�6$��h���D�\nPq\Z\r�M�ֿ��%��OD�`���#S��A����\02.�^p�A6;�3T�΂�2���g��t�G��f�\n?5��BF?s �.p��{��[�\013�K�@0��?ޠ����jF}~�	�a�ۯ]�����L��Hy��Ľ,0pB�P�.O�<	����0�;�u��.@��z�u��I�@m�V�/���6	��(���Vd9��1�-?c	�%?E\nF������\r;J;�?��H<|�/�9-��ׄ����m��+�Y��Y�������%?��G��P?0@d�g{Iݗ�y����T�x�Z���i?_�6�\'b[>�X��K�$��>&F�.���?d��Q؛-}�7��6�p�F?�Oִỉ\'��l��lC�)�E�c<t�\0�l�͆sP�¤���$�!�lܟ?�2�2����X�G<���$P%g�@�u[5�M�v-ź�0r��̇�q\nS�^�s���m��|?V�Ӝ�r5��9M�{�la-�����F��ya���*�\n��<�c�tfE���r�Q�t��,<6�g��T5�j	���W�f�j P>�%�q�ȥ��)�2��<Y,�t<f�v��2�$W?����J�q�[��`�BS���SBx�?�D�`�d�f�H��]��Ml�(�[\"O�`�/Z�j�	\rJ�!U0m��(M��	/(?Q���L��2n0��\nZ���?=b���]6�ʉ%O�>IUo�>L>o��?\"�~.��\'?|�l��3�J��>�\r��1�\nӯiw���`9ŗ3�\r��(���l,��1�JJ=�9�dUqWp1>wr������ȧ�D.A�8&\n��},�?`ɂ����ק%��2>�bs�6?b��l���y�B�\\2NH\\�G�������N��:��\\%փ �����褱���T�$ԟ8Ւ<8��nI=�}\"�;�\'�<�l�`���x��ca�p?�>Q� �\'c^���_Y�E�*򎦸�1Ȅ��Jt�Ib�gdɺ\\�?��1K�ݱ��L��N?�z����r�?���1NA�\\�ڃ�zI�J�\"�%H�?\r�1����t��R�K�J�Cճ��H�zu��yx0\Z�{�g=m/�U���l��C� si~�#��~�}�6������\r�r<�6��?}����7څD�J�g��\"�&V*�������h8Cv(_�\Z�OC�?�Գ6t��x��D�J��O5��z�S�M!o?�kk\n�h��H\0(W$t	��#��b\"\"��\'���s/b�d�O�\0\"�T���>���¦�����8���w`d�h4�xKi���G����6���ܳ��XB_�����B�)�GH�\nѻw\n���C;\\E� 2�\"�k���lr:��y�y�K~A�?��*T�ӊ3/~�SW�5�o!��@���-f[�gp�A��l1q��4yП��N\'��Q9��de�xr�ld�5��7wE�ly@�%[\0p�����`}��U�a������zϛ�S�[�gQ�0^d?\">i��K�?C���R��2#R�Rf �&S�B��[5����d�$��ҟ;�(!g�9�	ЂL��s ���z_1�Z0\\)?�<��l�A�r�\Z&B�6r�J�]d���s�-��\0X�����T��bj���2Q��\'K�/��і\\$�굈�\0t�lz#��x7HZ��\r?�HL�6��a�F��?��e�\'�h(��l�g?�,Lz�?�QyV(83?;РWB¦���1(<�q��Ɖ\\�E��wlLf�Q8���b&Y�q@1Ҟ����^�6t���n����7Eb*;��`�#����qܻ䕬��u��<�1B��E31 B�okl?��D��Wt�3Zsм���>0f�z���럞=���1����\'�[ �������O���\'?.�_�?��?|x��c�|����O/_����?��w����^�Cwj�֞?=y�_�?�Wo����=�-�z(Q \'���q�\Z���A��R\'`ӆI?��$U��a�u����,8D��̦�=�3��1$@<�\0\r�YY�\0=7\r�D���si��F��$2�Z}[R��T?�B�m�/�?՞���Ǘ?�i?��FcO\\��[�[C�a�6{���?��8tӖj��o��3WɅ�?�Z���-��]�s)��\"��	��<<����f�z�1h{[�J�a1���h��a�cj�7Ɣ r�d�O�g߱:pP��yD<�\r�QXkm��\r#c��C�%co��-�;9��6E���\nH7��~慌�W��̌�Q䖥�Qn%3R�_���e�ћ8~�H����y�p�V��e��xz??q\Z �\\5��7S��ķ0�>���(��Q���0	E�� \\�d�Gp��S�1��tc���?W��lxQ��d+�̃��8,\Z\"?`Y��<\n|[�c�6���\n	Q�*��T�b�g\0�3�?�8bj64����ZB\"[:dt��-&�I�Ep��r�Oq�[e�#�=.�q������SACt�/�Ͳ��Ʀ�3S���B?Q]p\"R��9��Z��u> �*�Q���a�sv\Z���@���tMPp�;�ٌg�\r��?��s��j��1�S��g8]A��\'�?�1��ڷ��.�\ZTܱŴ�m�I�3|�N5g�ʳ�\ny?�9?hY�pp�30����G7�E5\r;VDy;���w$ù\0���G��x�	�����h��BD���)1��Hμ��ߓ��۷�Np9�����[%��=�jWw�|����G�=��//m�M�?�IѠ��c��?;Ɗ����������D�-JM?..�����fG�۾#q5��_��f\0)���p�JM�H��N^�?Y����l?_,.�=��>�������e��Y�l95.Ү�0�?��kf��1�uS���E\'gh��*�%�?�o��\\�[[��N�x�\\�M�U�0�!?eξ�k����k@¾���Ә�\"�?L�8B�y���/f?��d?ӹ�q\"PT�!PÃ��?x/$��$L(\Z\'�Z�9;&�&�Pi�����.�#Ip)��3��kָ��:ܣ�؞�\Z�P����Czx��s�bE��A�i0�|s��a�)��^T�\nJ\0����oS�Ɵ��?�y��ܖj*?�jp���{�l�]�h��@�枆���K<(7�?���o�V\Z��/�_�JS*W��T�;<�P���tp�ۂ�@���$0%��b��LI�_���!������	��O�V��K?ƿ?��g�.\\���]+?�c�/Zx�\0i�hψ���ݑ�C\"+y\\�N��g)�j��>��w��Jx�~�E �I�P�or�b�W��+t@Lk\0�B�Ӕ�`���;���6�|\'2r0� ��L��\0c�sᜟ�Ff��?����?Β��]Hjql��j�}2��1:w�#�I�C� ���%�3��;�����\'e�h8�-\Z����GGE�K~����4�q\0gc�����\'�eP?@.���>&��P2cK�:r�~�f鄻��2�!���巸�O;D�֟�l��udje���\0�Bz���l�H?�FG��]~��f�4���z�q�$2䷳�L���d*��L?��+�i&�8�?o*?�{O�� j�.y�q�\Z���.��L�?){�e���14^g�a��?\0(~Y\n{?�#�?^iw)v0Ē��ț�?4�@JV��y��g��\0^M���b��/�X>��?�,q��a6�L,?���E9�����w:��ݬЌd��0�����W9\0�)o?B�Ȯ��|�yJ?x>������3/m?z���L<�w!��Eq�`��p���J]��G�EiZ��u�A�g\'q=.��DBa�?���ylk��ʳg$(8I,[�?\r�6�vx`$�W\Zf�V��P,�I�ą0���	bL1�P:]5r�<�h?���\\�5Mi��m��YL��U���Rn�`r�\0�cc\Z9!�\Z�T?_y\r�aG^b/��;<qEAVd&�l�������H�h9�\0���X}�h��]�*d�dc�ƬJ(��`���$)�.N,�\\|.���ε��|��N�2p��i1�V�?���r��8�B��NL�	����F�#�$�IH���	@.L��4V���I� 0Ѿs����|/�?���7/a�����?s��\'�?�L�^\0�M�`G��l2V�C	]��L�@�������Yr����Z�V|��\n�\"���%prp �K��̠(�5�O�\n��ⷑ�pi�(�,X�a�a�Dń���?M�N~�Ц���_?C��4�?Ė`���\":\n�K��#S>]�tG%��L0j?_\'�l?)v?�I����f`n@m���CGp��8Ghg�}L�\n�iA��Z�L�7M��1�&���o#?�ܿ,*Zj:+&-GP�᪢�m�r7��&��\0������w�tqL2O&.}i>�������1!?���K�g�(�����?�5ve;�d����T�?�Q����s޳��#%>T���Z�Dx���Ξ����o?Uv�:����C���?�s?�\"v��`�b>�����*�I-�P�s4�\Z`�()�Cfx�N%g[���a������pr�C�9��D\0�a�X��Bnc�O���K{m��G1�>���\\��(�lh`XҦ\Z_��Q8�-���X���X`�3!\"_��� L$��V*R�\Z�]|D?�/ٲ\'���w�;���,*�%��Й:*�H\n<�{�0qUH��Dx��&1��&�\Z�����8�W�J��;!;whk���l w���W?N��	�SB�P��=�_k�iN	.�T��g��(Y�A�m�(�;��9(�L\'�`NA�Z~�S�.eE�Z�&@��g=�n�#/�)Ҷ�M�K��ɴ������s5	�)P�V)~\"=�Q�B�(^�� XS�?k��?�P�F\n��߶���#���i���Bʠ�$?x���0�e(��?�5Q?�0h�8��.��??��p�K�����ۧ\'�޽M?�)�E��C��x�2��;t�,�\0�7�8���0ϡ�}xr@�{a�8\nAB�6�c������5�K��YNjsU?��U<�K*�ks�<�,DVe�3vvU�\n���7���J�b;k\Z�v��۷L��~\n�=n(a�a����5���^�C{�_��N��p�֞F���7U����Z���7��aD�^2ޚ�nLD/[���\08\r�\0��B{x;��$pL�3�m�V���\ZsL=;�NA����d��G[��VY|�^�)qX��4���-��#8\r�>�Ӏ�Hۅ��a�Y̭;�[+��-+w�b�n<o�Fx�e��	)���ܰ��`�UlY/p�:�\n���@��?Z�}�A��J���\'�{0�z�#�>���K����@�?[����E\'P�+���c���)d�[FєQ�-�����	�(��v��.�p!5Iv{��K4�n5G�����<�\r��Ot�EH��C�t�.�ɵCͣԬ���o��-��q�c?q2>�����k_ \r��=>7�%!q3\r/s�=?n\n���;\Z�h�c�C�et���pũK[v�s�����??{��\Z�wC��T$?�׷H&�dKu +?\\��0r�I\"�����]���H�c94�09\nݪQ�!���(7�hȎ VI%i�g��<J�\n�nD7r��L^?�E�n��ɉ���	�\"�G�t㤥q�9n�r�c��;\r.,�?�ȋ��\r�L��`\"^�����^�=�㹳��1���.\"��|�n�?l�RE�b���8;��&a?���ZA��6��8/%f��&� ��t��Y	0w�ޠ�:6� ��4�ADy�?=������5�S��X���r\\��a�2\Z�˱UV��>���f�\0�zVR�°;1y.vZgc+&o�E�Q\n�S�ޡ 7UӾQSL�PJ�.���9�]~o��\ZOr���r���-x���ճq�l\\��2��e�?�\r?�g�\"{f�a{.��\rYܰ4?n��\rKs�a�ͩN�/�	�{g}��h�XF�C/O\Z��+	)�L`�k�Ͽ �7�ez՘ް��\r�\rۃ��f�o$�#�3\\�~��~�_��y�gp�g������d!*��d]\n\'��H�MeX=\r�FNly�\r/?�d������H0Yk!B����q��M��إ� ��npV��(PS��Yi�f簵�U�\r�5��������x��鬊>`�0�F?(��>���3y�yX�<f\r�#?\rsm_1�\'Q�-�\0�Ѐ��;���,�.Og=��H����.g���T�CN�\\�:�ƥ��\r�E��/ٵ�Qk?>�ݙ�/U��\'n���=�Ț��1�;�+m�77����͔x{�X��ZZ�\\~��;�R��	���hO��S`1�ܬ��������oasg�\"�쀳�9c�bv0�Jv?�$�3̚�����޾�8\0/B�����t���?�� q�?�V�7�	RyR�򔨂\\�~��Z�������?��c��C��-)q�w�!K�Q�{�/����G��6Y�fW�t��.�(=�7�\\>ل6N�m0[�s��n���?$���\r6�z?`���)��\'�M�Yө�J���8ɃE����?2���z�ƘK6� �\\�����Ŷ8}4��a�\r\0PS��^e�S^�%�IxmVיF+�.?\n��:	�^����\0?���L\"3t����Dc��?_�Zڜ�W�������9lťd⃻(&��؅$n�|5�,��=�l�g��`�\\�\05�p�Ӌ��Ѳ����`q�������V:C	�{�x:s�%��y�\"��?-�f��]�v�V9��_�*17�%��4�	O-a��+v��]����C�b�<��]ؘQ웆���;�u��Sq��?��Y�-��=Z��*�� �q�|sI�C�$\\���x2��7���,dX�2	�c�1�/��2P�\'��~�Hѩk�{���<�!�\ryL�\r�����.5Ҧ|Y?:\"��(x�q,��.SP�p�\"S�(�X����u�?��$��vY\"s��u�`�Q(~oe��$������1�?��\n�%�!��:�2�\0(z����?�<?TX�\Z�`��\" ����T5\"�)?��FRK�z?E�}\'q7^R~q�&W(�QV��l�ț�+�P(�!A��\\�|7�fZx����G<C�7$E�:.�AG�7D��	 �A�l�`?����?\'��Z�?mI}���r�?���������\0;7qɠ\'���pL��w�un4�ɛeH��qK��#oF����Ya�o��?�ZV6a�ƞR�Ҁ����a�\\�x�����i<��\'�I4��&ˑ��TO�S�Y}Ɋ]��l��V��\n�R�NKQ\',�X�a�-	��\n�,�dfT�Y�?(L�J�MJ�,��:?��_��v,�J�m�6ug����R��`m�9�ơ۩T�Mô?%��ڊ���\n�	?�Hm�{�CTSp_e��v��0�\ZkC���pu1�:�O�>��1��D5�O�U\\������\'?	�̎��Y��U^�h��\n�9���U�aݵ)�2�\n�]Ĉ�����ξ�����p�yB{�\"������xC@|�ư�炰�2L���\0=ֳ\Z�˿�ـ�m7��i\"�����j0�;)�g�\n9������V<+\\���ŉMx��m�\"���?-�0eG�D���\Z��.Vr�J��+�&����dDd�\r�A�c���}k\'��Ie����`(vH��k#�c�Vl(�\0\'�?�RY2�`K��5S�lXS��nͩ+v�?)M�x9n�-�r\\O��)�/�h������],��,�oq�oח�V,��\rI�O \r��Ǥ��x�xF��U�Gx�כN�G7]�w,��B�?)�?\'�N�0\'�*v?��:Ao�{i�N���]?\Z��r8�um��/���k�/�M���g����=�x0!��!b����u����R}؎X�GQ�Z���i�b�>�)�g�zV��B�����1�Ό���4�7�(^I?W?�b�#�ѹ� ��?�-��?�B�[$M�V\nU�?1?`~Fy;0E�4^7@	@0~?�2�pyJ�����3�����W�	|y�?��쮌Mc��6�p��-\nF�\\���K�����q�?*�x�8�}?�9?)ڛ�8�9Iy��$N�K]X�_�9������Dn��[=��5�T��q�C���wo�?v-��Q�\Zf�XiYْ�5l�{\ro��\r+_�S[M��� )y�Onf�c7z~��G��&JM�xI��8a��pU����q�?�@�FK�&L������Y�N���0��`������ObAۣ��&�gZ楸gMw��R�]�r=Ϻ%nuY�c�~r��Ld=I\\\'j��K�����˓-MxEr7����[��ňP����#|.�\"K�:�v���_*��<m���sO����F�_z�L�������\0ϳ�ޡ�Mե\r%�e=���{9����B/m����|�)��r���\Z\n.�d�ʚ��aP�H��j�K\'ۧ�%�\n^�T��?׳��[)e%�*�3����z$��h��\"6��mG��������f�	\\cGU�O�\\�Y�J��?_����]oL��\Zn9�oTV��:�|�$f��BN���|C�+�P��S�L��\\`^8�q�V>��N��T+V��gc{��3��^��7?�+��G��?�°3�p�i�3�Y�h�5_S�2���c�Q�@k��;F|$ع���[-qu�|B_�5��\"�Ut:j/��[�BZG���?z>nY�?d?*�5�\n�I���@�?LZd!���-Td��-�7�Y�}�\r�b��H�}v���\\�$��v�S����N![��iЉ�ࢪ�.}6��I���z��7��ES�����c=�#Zx���8����.Y��#�d�J�Uy�@-Y�%C��WD�ĺ �\nܻY\n��V9�,�?�&�3p�ؙ-��	q�uY?��C���0s#+��j7?�D\'4�Nu����z��BL��0���Oo�\nN�Huk�6�=h�jI� ��z���<���V?�v��\0ܪ}B@=*X�Z���R�\"�����:��Vi�-#��� k�]8�)����r�`�C��?�zT�冴�D�?*���V��+�F�7��v5A���d%����Z?#}y�c��`��|�<?8��f.o�h}�nM��zg��N��<{�.�6\0ϼό??�v��l�?K�??�Ƴd3�N{��uX����%���A�QW��@���?���šdh�����\r��qi�FL�aϷ⥒:S8�Q�*��?푷�k�O)ˇ�8��D�c_��C����\Zz(��y.+��S�?�gǇG�?ӈ4d=��(�/��ZG�����1��i\0��\'�<��0������M�E�c��?��8��H\0v��~�޿?�d��\"����I�����#�\"?b=�-�g�jO�d\Zc�[ķ����4��)\Z�O�v:\nAg�� �Q0�SK�CM�?��z�Hn�W!0�V�\r?B�����;�o>�0�*g����J@��*6.E:H�]�g�Q���l�8Xa	�R�9�x<���?����<�Lu�H����a�\"`��q�>g��g�%�\0��>L��A֎�r�š0�0���0�|RC�??22Zl\'+x��^�)�8$+��v�K��P>�Us(�\r�V�?��i�NH�E�\'�q<\Zވ-Z��2v�9��Wb��5���o��Y{�7`�賷|��d��3�xe�CI\06�\'�>�������O\n��3�b\'O��8ȿ{�s�܊����X��{,�����-3�3��\Z3cļ�g?���F�0JE�4�CZЖ?��&T7(L�(B�\\���:���i���*],��+�Q$�_�F��]���|[�+��\0Ut/�Ė#{cU�P���8,?�@��r\nc%���\n9_�\"�ir8z\"L�#�َ%�x%�зhä�:�\"��%|�8��xJJ\r�Q�>�Oc�$�.��Q�$�K�g���;�5�\0���	��ôŵG��/�[���zŭ^��W�?q�x��!�>�-�p)�<��誆�b����?0=u�K\rwz��Sx_r�ⱽ?շ��9F�g^0���q����-��8ȪH���O8�?rh{[ت`ݘ��L�Մ�%�5���GH�YqM�w��,~��&�YO�K\r�al���te1�$�̒Q�P�����$+�/�,�\Zk�7\"���Zr��<h�u�M?���|����#�l�uh5�C����Mx��*�3��a�\Z(ꙉ�,�+,�7�c����)�i�҂�U7;i�+e1)�ʴ��o�<�=Z����Д�w�?��*M�.�D$���?]��Y$�8�.�Fhϼ0���uMYQ&����=�����ٹhD���Hy�s�a$*���D�ti�%4q��O�?_��2TȆ��r�@<�����M�!�\rR|P#z���0)�AäSB�������{p�?��a?=H���\'B���\0#�Yz�Opz\0����t,����4GO\'���Di@\Z�E�\'�V._�H���M.�I����}ɉ�~����k�5v�8\0bZ0(����8�Y�.?��`VJ�����?�G(�p�c��)�3?S��q\n*?�8�H�\n�8�`����	�L�����T:Ժ~w\\��6ڋ�C��4��B^�S�p eu�\')�~BÅ\'mPEю���k�T��Pf�%��?d���w�?\r.���Uy�l& y��X+%UſJm<���W�,48�em%��^@��5+^Q�I�T�H2���)�Wi����h�0G��Cy}j��Y\nz�M<���樕��1sk��9#�,��ʩ8SZ�8�E:�E�]�i?9?pI@J#�E\r\0��9�Z?�a�R�Q��ZY=ո�e�SK*��Y	��*+��Y���.�|�xzؖ�{������BA�3}-�?oS�T�~Z\'y�k)?\n�]?S.ΤƉ�VU8��\\��	?�W�D��j�1��Q6q��=?-�ܮ?6�����UM�Dо\0�51�܉�j��2k?��ds�����o���5�*nS�9��|?��O(�XjN�\nox(�|��gQY?)mH�M�yq#|*�@�I�(���\n�^��װ?����s�z��4�֪Y���o��*�AøF�%�h�\"�?GXS�I����~�dN��c�?�A��W	���⻧�1u����@���3�\r	i��Rq�&H9�?�	X����9��h:��?�fT��Ҟ�����c?���q���8S �F�h[2�q�SnN�H��(%Ҏ�∽��*?�xu2^�KQ�t-�w?KgWnV�?d���p��r^�4f�ی�iXE(5��!8�z���?	�A?�?�UJ�j�#��|�/�{BI*�2�0�R�EYt�3~|�fc��s?\Zj�䎱^��Gq�V�&O�~R�~,�0\\� �\Z\0-�\'����:y�(�?�Q}2Q�	�J����1}�?\r�,a�4kZ<6]����`�?��������xd\Z@�@���CS����JF<K�w�zhc\Z�?��\\��3�9��.�V1�xl7n����?��%���M􀽈�2Ha��ù*)�g\n���~��P_^�%.��0,C�:2��y���?���#s���1#��w��{��YiW����o��;�y�o��gi�?6ޯ��\Z��!=�r.d1��g�!h����H�F�������΀B���(��ȑ�i����+� ��L�^hF��P��X:4�� R���?����8r���vB�\Za�:����\\�l�l�5?��g$E\r�N�.��vܻ�ysM`|W��^��b�>ݶl\0T�4lMM��m�:����gɖ�������p�	c+��x�pv����e\\B;�>}挘$9%�����\Z?��1�p�4;�\'N?�[S�\Z)o����J�\\��2�������2嬂��%2�V�@��+�s\"��V��Z<�#N8k�	g���_e&�X�j�\")::Ҽ���?��y\"��s�\'���#d�:ƕ�?�_`%�w�a\\��(b�ϙ�Mv�!�U$��Y��\\ı)�z|dx�D��w����ow����Y�0�?~���&���ك�}�d[�\r\nGx�L��Z��G�q���^,QWն��h/D�Ʌ�)6`�a�{��v��f��\'/�U/t`6s�?�`��Y#ȥ~q`�/���X��|�wgx�gci��ՄO~4�挵O\\��	m��j����|#�?;i*�c�vw�����SYb�Ȳ��b��.L���`!2�l7��%,+?ֱ�\r!�\r�K1�c�r1�M1��\r|p���_��x�ǿ�g|^{���?^:2�.}K9\\������G�k��Q��1��N?\n�����{uY�c}㼄V���Y$.���t�tO�w�\\l��N\\�2��\\����%??\Zn�g�N�̵��L\'�?x݂�=�\"J�׃���C�<f瞢z/N�L���<�xN�Q�\r� �0�y�{w�O��^����f��^EL� 舙R�]|Oưt�|�b.O<%~�\r\Z��?;���\'�tܱ��5��D[\nT��s�?�v�h �x*����M?�z砿�C�>�N���OS�����3x�K�ĕM�ս÷��\'�~w{tO�ٟ�!;��]0??��ef��5Pt��7�?*�,IT�8���)\'&�$:��I\"�::(�q����kx?�4��TX�?�cM�a&�?\"��Ҩ��0��v��dǀ�\Z|�x�M��C��q2�_����N���^?�hS�&�͉�,&�Z*r��y2��HP�F��cNϗ<?����ۛ��B,��X�i^M�5�k?�+J���\"�} S�4?v��DI?��i��yP�Ro��P֭�ڰ����%�?P\n�� ���ͬ�`ޱ���#��.Q�?A\";S��H0M~eK��`����˯[v+��	0{9�;<��7���S��ɦ`�`���?Ƀ�̳��ZA���\r�����┰��\\���	0��!u��y�e��f���&m���J�k$�д��i���E��P?wK)�ZZiAV���T��dґJ�[-x,��/@,�͈@Y��4:�y�?s��v\r�83@����?�L(��o��Ĩ�ʧ[\r\" I��?�w;�v��a�M]\'d��%&�����yu]��Ƣ��D���QZ�k��?���:e��{�E�\"�//b���x�.\\�\0?Eqb�iu�pj���p�j\ngXoFoD9h[������_���1�<z{0T>x��Cg���-s�l��Y�pi/hxp��Ew�}yq0fֳ[��d��g�a������>��Ntv�\"/��Xv�Ut-!�L���$3?�D3If&03�I��C���]��z�dW<�C�|��SY�*����xº�������beWW<Py���������	M�\r�]�����_��\0�拄|����س?Wu7�P��Y�3j�oG�<[a�!B����.�h�?�G��)��VP�)ǀ]c(2(�l4L�5r1�[	~�E3�����\rЂ0ૠ1���-8��&ң3d�w�s�S��d� eD��t9#Rp$�uKD��r������O\'YC�c�����A�bWŎ�=\"��;B��A�?�pE��cG���rG�^���?�RA��GzWϠ��0@��%��?�-YE?���1]�=�H�o5�V+[���q�L,?562�s�خѱQ���ɾd?O�n:8���Bk+0\0�Z�6S�yD��[����tY�t�D$�2t�������瓰Ŷ�\'�J�{H��B��\\ X!T��j�\\�3��Ty��nZ.�^�-����\Z�fG��g	��?a�ݙ��C!C� ��94-��q4D[�t���#A\'�[�d\0���Ә��?��?��9�ת2�s�\nK�(��m�)O�����1�	$L��C�p|�mt�Į��pz{(�29�C�T�K�c[�w�HTud9>�����B���	M���E�F��\"\Z�\0x@?a�:�dt��Ka�C�?+�+T��XȮ�t����s�SyR��anI��2N�� ��ͱ�5� �����]�u+Y\"\'*�L(^D��a����3�LL?�Mmn�d�)=5�)=j�߶ks�1@1��+=1�j�l�N?6/���47���O�����E�3�z�����u�Zzw�/�2��:�~��-k~�C}K�??8Wd~���o��۰��?t�m\\fwѳ�9��\'�Bd�BFUz\n)��9?5)��0�&H�k���r�.��A-\r>&x�2<�Vqr��C+������k�������\ZQ�P������@6�rJ�`3y�*�\"_��j��9d\n\nՀ���`�?�32��ҩxs��L��!b�����#�I�jB�M?�\n�OP�vn6xc/$�[��}��#�V�R5Yǳ����PQ��\"��8��No�:v��??�3g���Y��`[����HFIt\'Bd�hB��Z�O\"S�iW*��JpT@�,�\0��Z�\'NA�\\��kmPp�0�A#J]fF+�;�?�}=I��,V�z�n��=xjw��?v����\Z4�m���9��\0q;�?�%�?ǊgW��SlB�84�j����ZM-(:��&N���9?�I�&�#��$|�IxZ�4/��w��^I��A	��҈�B<�\'\'��d���\\�z$A�>\"���L��0�?R��ˆ�:sàQS���Wū��f.$j��~i���z�)�s��Ԇ�a��p�蒚T�Q��?*�uN`�\n�lo�r������p%=:)%�r� L�ed�={����g\Z�ZT9eșU4�0-�u�9�at+��̺�%�ۼ��2���O6e5�K\0Ҵ��{��ˀ��{�HG\n\"�Lӭ]O(�q�!?U�&s?g:�5Z\0/��\Z��1���pzl4N�	,\"��j2���zHcD�6bt-�\0eq�]]�\0�a����OX�\'<�	\0��\n�U�ªBaU���PXU(;��J�\Z���F?���\'�:�U?��[�ֿZ��P9��u��e�!r¶uzh�Ы(�D�?r�1s����1#GV��|\ZU�?$:��U`�у1�5��B����d�ᡅkD)�\n�Ctm�8��(�k3a���4,8����ц3\Z�	3�`2>?2SrJ�ݹ��?�9<=��L=�RQхW�g�>L�=D֢���i-��~�d��5���±�sGBr?�&�M0ı��\rE|�l��!Y=2�*e�bQdb1��ʜ�MT��\'wm�6X<\")2�!\';�]��f�t?�Uʥ-��-?��3H\r/��+?-X��R�sGE���>�Z�a|2�E�n߻��\ZΌB���}��(���\\�^2?�~U�Q�\'�?��L=+?d�F����Z��%�[�]��\r�Ա���\r���\'�F�Z��������¸��>��Ǳ?B�7ǆ@���Y�L^쉈}J�i?�/Z-�?۞Ũs�.;0��sF��	�}�?��,e��\n��@���i�%TD?�<�ǲ@<V�T?R�Ȅ�c��e��EA�BŶ��@CK��B&$0X����y�)hF�+����&�!�Z?D��E$%2�ԅ�-��.a�Zٳ	T�&B�˙L2y�Evذ�1�� g�;*�,KD*��[&?b�&{��ls+K?�Ar<X��(9��L�-?�Z@�H�c�0uF�ui)᧗L �>\0��a����\'X�r��]R��*V��*V9�I\'[���O��8f?�a�i�h�[M�Xe��cD,���3�W߳��(oQ��͎�^,L��DR?���|f�l>ei�&Zx�Q��nHƅ+H�~��p��$^S*�?)�,_���(�@LM�B�MQ���3\Z�?ŭf�,�}\0Y��U�d4�9Y?�P����%H	���2D\r�`���ҵU��ԣk�WI[i��l�,65z~l�5�đ2�7DKf�!a�B�`?�.��JDc�?\nnOb#?���^���B-Ѹ�!�? S|��?�ɋ��c\n�d���y��E�!z�q�������4&�w|J]̋�^(�)ùz�Wi�t?�LM�Y��_�.\r�6�zt�8���^�= ���9��f\'f��<`�u#¹ʴ\0\Z�\\9�#���z~WO�U��	�H���s�7�w��/��?�x��}��?l?�S�e|Vkm��?\06�`O�ˬ_�I�.���w\0\r��3Y\'�X��L���E?\'Mz����%\n��V,$�hA�[O��ERyL#h�*�k�����[���/�?�Gk�yf�R��`�&?�2�\n�*�Q%�g�1`Մ�=tJ��۠٘|Ћ�\'O��4!:?��.ϒ�X��\nNE�k�b��LD������Β�=EW�1?�z�\"�x2ӧ��\0�GS�P��z�l�j��\Z��?��E����rD�G�.���kdD���x,RtUP�]=��q-?2Q,�Ů���a�w?g��f���!?=lEP!le�A�Q�6TJD����������\"�Q�\nl�B	r�o��q)E�*̯2�Ey�9flҗ+˶Y�jT=@������}�X�×��yw�ٜ�^+��6,&*�Øex??-4j/�e�g®m����_�%��¶��}�q��4ّ�1*��h\"?4d3�i?sb)\'?��\r9���Ɔ��dI��b7� $)��\n3B\'n��ޮhe���gg��?P|��w1�dg�4g]�]GS��y��?��+i���x0���bk�I?ev��l���\\��)F�tJXӤ���&`_,>��&W�j	�`J�hl���2&[갫D)gkbVź�mSH2l\"~��G�	�LK���i���R4?�BŌ����=欴���Ո�}Ea�e�`d�����6Z!�\r(ɣ��Y?3\'Ƕ	^B2{tyW��u��`���h8oy�gg?D\Zt	;_q�֦��\r�b�4�z�dA@q˥\rh�E�˴�\'㠔�KE��m�T��)�\"�V��Z�V&o��h��V��:�K^�\"�5ƻ������P�˶U�ky^�Î-���Mף��bə�h{�c�l�8XZآy�-m��[��]��\'g��?�q�ډ�l&��5s)���ۥ!/u�,�]r6g���1Z���]u_�3�4z{�<�D<>r�xy�?�Nñ�ߕ7�	s�[��L\Z�ƽ�5T��9���V/��Ep3�:_&bQ?_Ց�??�j��:��>�!I��E�Ld�\n�.�>ax($2E���S&z��i���B��3bC��\nR�(W�r���������#�<jb�c�&��N����}h����	/��o���ܧ��g����T��\\�~�k��-N�$y�R�V��@��lE-\r�\"p!UtlUw�PV����-�$_qJs���\n2Bm���h��@�6��MډƇY��MH1��xWG�B�r�G�?�ld�$�>c`�,�Q�Y?�`1�%\n����k�\"D�[%��j��:^D����M�5RO���$#�`AN��h�2\Z�e.e^�@�j>����n�x�%mm$���7��o�ἓE~	�s�p��앤W3?��!�-�xt��\r�}X|M�G���?�	+p2pl@4��\nRM�}{�{uBe<�b_2���fA��VS8�\">^�ch�����[2jR����\r�\\�5��:����G�3J6;d\"��L5J�R�12����X?$x�lhu�oxZ��)7���g��7\"�AK0�?bi\"�[�*��C?Pa�leՃ&�%&���0���Y?3�l`|z�8+F�i�Ӛ���x�HI9(��?F�E�3��h-a4�J�.b�e)J,Y�qN,b`\'�Q��x��?i���y����bQi|����#��R�\n�R�)��&n���E+F�7�\Z�w���,`@�\n!����%�R=�z?J�(�JL�]���?T�N��4T�+Gf����:?�M�k�[0ך}	S���O�.w�a?xL*B/�X;����3����)��n��rA�\\/��?����A%�e�R?vZ�Y��q���*?\n�?11�8��\\\\�{�<�A����$�j��Ѹ�zNV�XQ������v�~����(�]1̕�y���gr:劦��pH�0C���Љ�x��뇭J-!����b�hw�И,����+�Aŉ���b�\ZE5M�h��em*�))�4a����*��f�a�{#�}y�x#��M2�7<���M�J;dr�A�7�/��Da1��g�����z6�\'�A	��Xm!��NIl�(?P?�Wń��kR!+D%��v�9�.�w\Ze#b\nݹ2�xl��Z��_�ZV��U�E�Z\0� �k��.�R��Z$nP�@�3U_�X��NUg?�2��賔��?��k�\"B�h	���]���<v�0�F��5:�3�Q�4\"2�*	(�2��3�C!V�\ZJ�Y��e��d8��^�&�v�؞w�.c`�����n��F�����,l�E?\r��I�m|�g�_��+�^ �%w5R��]F�8?�A�q,G��M�yw�j�??d�H�$\Z��w`����V�,xp�\0��EYZC�@��$�+�����.��l̦;9Ä���j?�l�l������5�?�H�-8Ҵ��e����?E�ADס	�q�Ga����-��l�XP��J!ce��6{��*\r�?�eh\'����	�q|�+�y�W�:Nl��.(��t�A�;��-��C0˩Y�B�.�D��J�$X��;I��\"\0��\rAN�$\nn6?��š�d9EtU����N�I��$/�%��?+zLF��/�:��o\nV��̓[?�.��wޭC!�rz�k�\r��SL�1��&s��VY�#��F!@u��bw�F�E��2D3TR����U2ό���68��F��<8�sxۘ�Z	\"K�()����D9��&�������\nd�a���5�*`�b\nM SF����h�\0_Is�T��*X�3s��<�Zd��h�k1L0��]d#�8�5N/�n?S,ﴼ9��?��A���mb�eK��ɞNW�T�h\r�T��Q��і\"?}��lK!}K�߳��\'�b�0��&R��Ȭ!��!�c�Ī?��С�?M��|�,��:�VR�\0��[�u��b����j??�:9hd������%���1x�g��!�R�)!�<�֢z\\D�>ءl��>�䀉�v&0�ȹ��Yr�\Z����e�����n��6��H���\0?\"k���Ķ�2.�0L�tĮ�B7 -$U?��1��mŠa�Z].�?�l2�`��\n�$��� J��p�hQJ&�.T�yB�#$u�,\Z��?y�ɴn?Ɵc܅��x\\o<l��ҳ�=�6AF�#��&�r\n�Xb�g��&�1�N�iHU2��[�j�)SVa*�ah�i`lEv�B�hT�l!9Ҏ9oϘ3w��\"a��?�\ri�!\0_�8z�xkg�l[�@n�E\r�ŨN�@<��`����\"~�X���̀��ѫ�i98!��C��^m��?7Ǆ��ay��71�~P4m@��[��za�xDtB�i>��wH��������:�kda\\����!H��uT1��� ����`�� umٯ,��a5�/I����?2���ȭ����+LdH����\\�!����S�_�1��>�~�����U�\0ٷe�)Dnڥ�?�p;:�\r	�T���4��+â�A?y�?P�sԳ��hh�H�7n���?�/V�IaF�(k�F8�)����<���J�q%�����L�N�J�o�n?��2#��ό�Ҕ3\'�%B�j���փ*z��m��\0�6����ATq����LLԴ;ei�cFv3XBP3��Q?��m��\n�݋4B��\n�,��D�h�?��w�N�6�c]�,I��\Z�7@Rܕ4�{Yܲ`FMu&M�?DTB\0�~\r�R����>�v��Ȫ?tfO2�� �FYr��?e�(p��/-��z(�=Y��y�#A(տA������5?�RA��o�ɬU�2�C��?n��[�_�tyq�e�];L<�&gI����n\r>\"S\r\'RW���(5O�v�hzi�A�<�q=�$�����L9�z��?�T�\'�z��0d���oW��E����v\rh�A��Zb�9+�$�\rn�r�+�{vav?>b<���69�]?�@?:�B�?�Ì�1������\'����E��������e�%CFŴ!�cb�!U)��Q�h9��C���9W)?@�Os��5,�>x�\r��r������\r\\=����w��D�[��\ry�JA�:5�@b\"Y]������a�qO#!���Ҟ���%\\�:O\\u�`iB��kڒ�É�z�?#����Ҏ$��]ʱ�\0�bB�EJ��2,Y����:#Q�!��??^?��dJ�(�n��Q�s�z�6��yC5$�R!k�S�*P7\"`]�-��=-=�\r�D\"�A�d��*@�@�,��-?6�n��E_�?jK��)�\rc+�E�P����gL�I�P˹����qL�,��pd�U6�n!g�p/�)?X.�?���y�\r��^��ft$��qK�Db��ջ�\"��\\�pl-i�H��Jc�I\r�F��P�f���}]��E\'�	�\\���0nTP����Y�|�4��)Y�`��]+���,]�����-�Q���E�?�o��B?���L.��a\"�(0>�R�?y�c/ֿ��}����+.��l���I)Ӱҋ˓ހ�x��\ns�9��?U�y)T)����˦������[���\r���H7��F�A����\n�m��0(<�qs4�hH	c��@�,W+v�ܱK�ž��Ou�� `�\"T���B\04Ԉr�4�q��lY�`�����⧆\'�r?�hE�\0%yA�ȾO�O��|�g�4�8E`bm%ٗH�w4Ry����6^���´�c�G���	�����Fe�G��7[��~�lÀ��1J�,/ٴY*{����Զ�~��SE��n˪Ӱ-+C�0=�Lx;\re0/��Z.��e��V��&�\"{~�`X\"�]��w�~`GL�X��T�V�C+q<F�x݅ˊ��2\Z��v��y�hh��&��/�^������Q�J7N�Z�4�(�@,��h�\03I�Rs:&� �d�<`*���gW�n��,�<ˠkU2PS+�-u(�-��z^I�R1V!ȋ�\'1��1C*�����%�����a���^R��Kj�&�81��)|�7�/ԟb�Ĉ�l�qћ���?�y��Pt0f���x��9c!���I�A\0�e�R-w�nW���-��B��l�r�q��Ni����v֞�S���0�\ZS�_�ڜ�?tv����.��:�P6a�5�Z���4��\"]nqM���>d�Ǝ�xtG����.���\\l�p��sF�|�P�Z���t��K�Ȣ�_?��N���(r�*��!�]�;h�%���y֛3�Ʒ�׫���F(>4Bj��6?�%I��aT�W?��zߴ��0��Q��{����	f�jZg��rc���Q�t�j�� �r?�<�#�d\\B��uS0�a�q��~��`�]�W,rC�M�TN��dX�f�AM�\'N�K\\��� �Na���Q�S��fH�	}Q&s��MH��cE��*:�ܩx�\"\'QB�/_H�EB��Z�?�M�gV���3�8�����_�B�;1E�P4�MiT����Ц���0ʪ��ϲ���T��i��<����R�?hP@�ӎ�ޞ�7�~Ek�T�m4O�ܚ�N���h(�e�=����,��2(ԒzA�#za�Ҟ���z.�@���?JC�!mG�#�Alߋ�{+�x��`C#\\i��� �$A�ĺ\0?��陞˞ٚ�_����U46}ES�?��9?�v��E�E�6C͞�E�U������@�N�BT��R������-Wg\nN�P3;���eak7o���7wO�`r�Ō�d���\n�h�0;�]�]�?�US�\n�;dg�D�@?���S4�������:� �>^r�(���7\Z��������A�y=����6)�l�}�hW����y�Q�U��������I�R`��0�n�u(?w�0�-��u\Z��O�[5M���]Z��lV��x�\'�G`_�;P>4�2?_���^�Vuh2bF��k����VV��Ɩ ��|\"dn	o82�ϰqx?6��z��¦�j|����V�\0)~�Ѭ444�:㕡B�z�p��.�?�3�0�_�\niA�	Y(n9��p%���yt1����-��כ�f���Q\\����7�G���ˡ��˱��{1��y��*�񕣟7���u5��b��c+.U?�@��U��qU���g�����K�U��j���Ț�%Ue���P۴�E]�Wnnw�X�i��n��-�̾�bD�t	UˑU˱U����oxU<��&���41C�w�wQ�T������QO�T%�\0�=hR!\n��V��������)��m\0Q0��9v��\rk�kT�?SZ��j?��1���S����*u�Xl�.���n�9���?���EW�j�cA���OL�0�O/�M�4c*�]bG�+�����y��\ru�{74��5]Wak�y�tzk]\rxҼ����G]!~K�&��\'Q����KD?H�Ө\"M-��\"�J�\n4���4vqh1��,�s�-&��R&�B��l��21�?��w�2֨�\\��7yz��;�E?��K�df͊����l��3ט�����>���7��z�o4�?�����TOO�4{ק6�_c���0��@ķ*��F,fl��}������2�j��d�ba�=*83���d�h���ר\"��u�JNCè>���F�o�KTӨK��cj���x��\"B�C��#�`����7\Z�Yi�h-3����tȦ��O����i	0�j:�_b-B���5���>?�.y?(/G�9\n�P��?_�J.C9^*�ڵ��p�q?�D.�Z�㽷��6	2?4�ɬ�??a��?�q��џ�-�+��ٺۃFL��ڕ��-ב���fΛ�sK�]��b/8~G/�zl�\"��?��=����8NqJ1#/)���N3��Ցт-`����y-���vA3zկ�ʇ^m�WF�^�؂_��� �f����IC5ީمS�0Ƅ�����?�:p�BZ�\0?b��MK?�v��Z-���2u@��qW��ׄ�m�i�]Ԟ����b���h�?�%XL�M�%�\'�f&����o,��V���?E�2�O`���\Z��==������:����]��O�_S�?0?O�6��!��������=���-�z�9�7��O��$ޤҢ��Җ\rb?ijT`h�S+��=\0��sK�I��B&;�1`�cn�l���9h:2d2?��*P��#�Vg�Y�]�dO�ƾ���3R�?��cn��E9 .4���?�u��9C6�{��[�⦠FW}s�L���x��9]P��=hE�������)�p0��8��@�A���v^8(�Q=$x�sqH�RM aM�V9l?��C��z��y����B$�A�W��F,�A�B��L�u�hԪHhq��Q�S�&*�?�\n��8}4��z��l�@��?շ��#���ƾU��D��?��r�E�0q�Y	��VX��,_���-�K����ֳ��2���\Z�����:2�sd�)�D�?x���6����q�Ad�?}���*;vM�9�f!kNWK�f_�7���d�6Yj���Zн��AC�%�f�ߙ4\r9��P�g@7�(�h��\\��%A�2�P#\nC�20�F�,�+�����VE_�R�X\Z��M�� ��l}�l�?D74��\\�4c>����Rai�ۖ�-�bAx�%(E������`j����M.�$�?6�,2��w\n�QWJ�yN�;+vܣ��\"tr`̞4F���6��k��\Z�>�g����-�>��&�!�X|�|���;��e��0&��?�Di�IN�֌{���M�4�Aw>i�E\r}��Φ1�5�Z�G[�����\'ǴR��V��v�1����ٛ\\�W(.����ӈ�}F�0��a�5�I��#vk�0?M��3�D?\r��\'v�;���ء��0�ܽm���}̜�\Z�2\'��������4,贋?�J?�YX�?�\\\rg\0���t��z���S,L\'n�	eN�SrɄi;�?C����U�eͮ�mW��+6�.ڴ%����\n|W۰}a���z{5�cXu`��3�s�U@�4�Ź�?ߟ�\Z��\0�ʭ�5�R��,8`�D�?��b?y���\n���.��a?��P.�Υ)���7�ۄ?=�z�7��2�@FH����\ZOR�s|��h�w�Ӣ���HL-�L����C�L�J�0�������h���\Z,�����G�Fǧ`�qt�U��-d�n������|?��W� _��Yz}�U`<@	�1��L��\n(���h�>�݈�_+�HgC��ga$|�;;��N�<\0{z2�@e\"̂P���.x�V��w#V:T��Ok	�C#\\�PTc�co�x ���K���\"/.�a�f�n	��?<W謲!�jE�\n�#:��u����ܲ@�jho$dѶ��c8��v��@\0Z>pfDvh�Ȍ	���0�MZ��?BUƩ��;��$\0�tzx�<���]76?���l[��?��؇�1\\rK]�ˬw\"_j�[�w���8%��3GPU�B�)�n�i���+{Ʀ��\'vm&?�0FF6��C2z?�K:4T�	{��,|?�o�Ɗ��֘���65�s\Z��\0ʟX\"=6?��~��O1��\n�;+�����t�\0j�2�F$`�\Z��qis٬]t�	4�姳��B4�t@A�K:���߆fd�\0×�ź<~(��5���?�jm����jAg?���\"�R1�Rq����U?�k�b���\'w���x_7����U\\m���db��dg�vB<��u��Ӫ�#��L���d�Lގ�(^��&����*��[�squ����j�]�iV�6��5��-V�oV^\Z#�?@���N/c>����[�?�8��66����?���Gb� �ؒz\r��fCJ�1�b�\n?*ٜ��D-�|AkE?b�J��R�?�B���6\'Pˀ��\"��q��wL�\n�.��\Z�_R��A�ZU\Z�)r%�9/$|?]G�v��E�\"��RıɈf՘f#F������ke�?�F4��l�.�2RM��5h�\n6?Ĳ��q\\���o�+i�����xO���|�}�/(��7?C�ц��o���ׂl��+�?RVq	������Y�C|��)�՘�?\\=�@H��ɼ��$���\0ok�k�\0֬�,=���00����i����ҭyĲ.mM���5XT����?^Y���QL��bd@�.\rȵZ��\"�w?d/4:��i=T΅~c���O�?u�C�{l�0�z66��������޾��k��c3������Ox��p�]8����ÿ��){<},b��~��������O��œ��=�xb�g?o?��+�_�?�~�~�s����1�|�����;��/?v��o_��׌?����7����������k���������{�o����/<�wܖyk��uCgm9������Z�����NK�����{�	�}�Uz�y���Scq½]q��������?\ZϿ�_.��.����_��_<0�}����wm9}����W��%�u͆��n߿?�r�����5g��9�?SW��>���O�����?o���?�ǣ����������}��>����.�?�����꫎���G�����?�?w?���^���o���C��t��S6~��~����?9��G�94���l⇉C7���ֻ~���<|�{��m?�����w?��,u��#���Pf�9m�~���]r��uɟ]��?𥙗���@������=���GO�Y���\'�z�����l.�����^��x���|v��7��?���}���n���_<:R��]�����|���~�-_��쫾����?��GO��w\\w��go�:���]��}�yg���ֽ�Λ>5t�����]\\����������?\Zi�r��K^8�����ɱk�9�����7]��?�����{�t&�:���͟��?�⺭{N����{��u��Oد���|��/^���g���س����������}�̿e6y��|������ߌ}�����������_2���v������?�v?u�Ͼ-sY⑵��=o������_4�?�<�\r7^��CW�z�����k߇d�RG�)��?%��;F���?�����>8�n{�3NjKf��|�{蔓/�Ω?��w�_�7�?���ͅ훾�7�������}���m�í�/?�ܗ��Ʊ�z��;����O���]�]}�7?շgϞ{~u�k�O^��W|���_~�7geN?{�o��?ܗ��CWV_w��?q�s�[O>뤉�?x?������������?������y�7|�E�����w�����ͯ?s楿8����.���\'���Ͼ漛ח����+Z��v_��������7��C7?��z����}�u��13��\'���?�\\���s^������b�=�k���9߾��3.���������oyƟ���#C�iY�~��_��kNu��ݹ��U�~��M�������u�w��?�5_y�+������wvv>��w>��6.�a�{���k����=�o�\r�|���ċj�������n�Pb�?/z��g>tk��w����.^w�\r_9��m_���Nv�����X�c�D��~�?�Ov^����⊋�W����m����\'~��~tc��s�߽mS�k�<�?=���������7r��_~�����?O���\'�������7{�o���}�������{��O}�^����3ūs��z�^��e�W��w�W���;7�����~u�)����v������˨8��o�?\0�	\Z @�d?w��@\\t`pwH ܂���=8� 30̜|����ȹ�:/�������kvwuU�ڻ��t��.�\'f��X<��)�8x��>�\'oOHJ-�������D�Yg1`��\'14c���o&�NZ�h5�\":tVW_|�S<t��Al�ٕ�#�$�[�݈�[���}c�\ZG;�R`m����w��?��aW�7,����vF�˛lFF̈́U��m�B_��?	O�YH����?J�]�����\Z0/RI���j���f�	LM	V�?	�D3{G�mmŵ�0\n�i�߿|Fg�� �j?I�q����?�o%j3�Az?5~�Ť��F��OX��6��b\"�E�C�ȶ�[���:^�F��������F{P��3{ݡK��\rjk�e�sp՜൹E��J4�$��}b�0��{KY��M3G۶%�Ab<;$����B��Y\'\r\rNG5��t1�o�i/�!���ne�e�(��X�80�D�Y?z?��dD����јա���͇?YOn�>�n��6^ ϹT� �R�v]�bU�:�S��[�ʥ�a��?��¡E׵�\\�$�=5z,��m��q�S2��#k,����\ZT�l����KkY�\r�\0�8h���黥X�[7���:��R�E��M���V���,�;����������5�������?��#.%����;ʿ]?�-?U`�\0�\0\0N���\0\0n<\0��\0��\"=u\0�R�/M\0��\0\0��\"�Ͽ�_V���?�Q?\0@H\0�/\0��\0�D�_y\0�y�_�\0���/�;\0��[x\0��\0$_\0ƿm�?�]�ߚ\0p��[\0o?��\'\0\\n���\0�{�_S�aa�c�$�/��H��R��C�/4����@\Z\0���?�� ����\0��\Z@�����{�I\r��\0� x�/??f�Y��п<�(�7n\n\0V\0@\0��W����O,���96�?�_v@\0 ��o�\0�����zl�^X�!���.��/�F\0��?&����_t�r\0�\0��v]�\0�\0�1\0�?]���k�?�4��|`�?�����L\0?����Oi������\r�W\0���e?� ���o|�������X\0b��@\0I\0�����\0\\/0�����\0>>���\0���=�����4����;\0��/��g=�l����m��w�#ۡ������� �(B�\0L����?�����C�.���o&t�\0l�c�g7a��\\D����a\'�+(�\0p_\"p\0����0�8���\0� ��/�[i�����i�>��R\0��\0��\0⿣M:��D;�1�>!�����G?��&�M�����o?��p������`\'?�$����d(7���Kz�M(ҧ\n�w�6�M��؟��{?�������^��z�}R�MzAϽ����ݸ�#VjA��\'�>ᗧj/��po�w�����I�\\��Jo�T��M:�j?[�������nN�o����� :Y2rCf��wG(!4�	~6�xu�����`����$Q\nFZ���^e/ѕ��*�_(`0�#��xne>{��߼S)�q��2��?��b0�l�>��	D�{��	���s�,�\0�n@f M�(�M�𹡹g��9��yh;\n�i_�Dd�&S�L!\n(�0U ����xu�=�v<����R�b쒗q=�R�?I�?pU��,?J��g��S!��\\?6�򾤣w���=\r�?}c�q��`ڶ����$FT�4xq���0?��b�#o\"{�;V�=�V�Uugı�W�E��������Z�Z�,�ӋU96<��_��T�Y�.f�ܲ&���$\\wN,?\n�?��[r��������^e{&��\\��%�,Ч�=��_��,�=\\�j��$*�4�\"�\"�h\Z��\n��49=@�l�.`��=`0��;�K�.��[I\"[j|?O	�#��pK�\\���\\p�H3����Ի��hi@ۀ���)1�HJ�,�+�[�^_�.���%��v1��-���=�y`^�n;:��8���R?��(�]0= )o|1�����Ċ����Pг���Ӟ��P�:GY� �EqJ�\'����0��a�p9��?���k�ݟo���� ��&�����\n1�[�0��^~N�	�]A��w��QxE�G�=g$�xJ.&���cH�?se���(�<��͟\\!� ��8�o/-\\����$���BxX{����\r�b�$���*�Y��� ���~�=Ox�>�e�9g�R�ɧ�VA4��eO��ܛ�S�D}\\^Z� �rq-�Y���6�M~b֦��@�L�46��nƭ���d��?y���7�if\Z�}V�7 ��<K�婺�Ͱ��. �U����\'�&|ߌ{\\�4@�X�C�\Z�jE�p�y�\\c�������\n�b�����\nNolA��:�)Rp}�cIg^��g�?$��_M2�Mm\\��`�������M�[��,�:eMI���L/�õb�Q�V��}Q�S��`������Q�)�ۛ���0&_�!%pH�����p��mABC0*ce/����0�?�*�n�� ��3{4���|ý��\\��2^\0;�X�\0��F���`P�=��P<��2�.p���:�??l;5�I�!1��*����3���k/�I�n�]�t�l�pʡ&��1+�\'<a?�Ay�Zq���m/L���-!�YQ�ALhM�Z]l������ݵ�}�Q6z��/K��o?�E�2���O��r1c�?���+��F`��sql�@�A����_]=^�)��3���2\"�G�u��\0�� ??�C��Yʽ�Q����ܘB:���K�e��*����}B8}��:͹�}��!���gۨ$O.�zxg���C1老��f\"	�\08z9��]�8��9��j��R��q�(p�і��<�sR��G��)]�|?z��� )��Մo��Qqk���c��4?��� �S�?�J�JF?Y@��j��a��v�=z�\0����c4W�J�k^Sw1@xwJ)`oW{��A�w�Ԇ����7?|x�y�|o��>�%s�����X�~c\Zr�S\0\0�x��}%�9A�RÛ1@I^NH��w�M�wOhj�??\0R+j{�l��t�/���׊p���{S��C?����$GI�g+�v�ʓm�t�9�\ZT�w�d�?�{��1�2Q�\"�R{~e�H%\0�ztQ��p\"�Y�|�۲\0���e	O>E)$�����։w	������CXV��D?�}6�5�\\���i�?5Dv�7K]����;��q\n8?��\0���tAf��ˋE�l��Bs�R��P���q��f�?��)�S�g��B�\r���#\"\r�#�ZEȰ��^��]�E��<?Y�y\\�����3��蛳�+S����E?�~\r��� �s[I]�5E�YB2��M�:���p/�|#���M/��*d�ְ�ru?����w>�\'�B�E�5V���ay0�_�|;�_�Ʀ�` ��~�i\Zxb?��C>X9�\n��d�?u��\\E>�Cq�?c��i��AZ�	��w?:G>I�?IY�xc+�+6�?a΀�vIKA������H�s�qǬ�̫�m��R����	�}-	f~m�?󪺑� ��>�%>)�j�����{���z$�ot?\\*?��!����q|��;?Q���^���_�*B+J��%>w�J��r>�����O\n���H�J��,�z�[H�X��T�	Qk\'�?v�oo?�bL.�2G2US��$�_��`����m���H\n�	��g2V�X�#��\"�?��m>�%YT�ɖ�d?�����B��أ��1���u��Mz�Uy?!��\ZD|�xj%|�$�IfB�m�`��	!�l��,5����B�i+��L	!I��1�8�w��풻���0c<�?��!$��VKH��� �*��C?Ьw5�(�]=c�~?%��c�ǀc���\n�rH.BϾi��f���pNR��<t�	����]�ȼ����ϻ�q�uR�.��Ύ�8��\"����\ng4\"�|9!h�,?-�����ä�\'�S	���M\"*H\"���9U�].?���@sc\'2��W+�\nLc�^��z���b�>���?�w��_������^\rO�z!��G�?ẻ��>?�L,���A�?�X���O�w���{\'��\n��K�Ʉ��5??��|������&���̂<��O1��-F��bpk?���?ՉSh�i��Gv��A,��f��1�Oҫd�������}�/���?o0U��;˚�+�\Z�\Z� �پ��?m��6m}��IdL��7	\r%�F|;��b�z�^��l�\n�&vB?#5���?�%\\�;�<沈3N�/ը,/z�hm��s�JI�1&�=�;�)�?/ȞF���&\n\0L\Z���~Y�aI�5�K�w/d��\'\nܙ�77�h�H6x]?�V��uA:\"o?�<�e9_Yo��%L�<l+��=�z	9�t���?d.%��OC��va)�,��m8Ld��g�X��:(o�o�\0��l�E��m��?:px����?�c(�l��t;\"B��\"��]�\r�f�ä?~�.l��g�MS�M��t�{�{&�G(�4���p��A��\\Ԍu&Ǭ�f�m�U6ޓ	?7]F�7�P*1ia��}�nW�oǙ���/�$?������ O	�R�*��;HD��2Lh��x\r��㊮{o?�i�PAQ�V��\'�b��%�����U���\'��>Gp�}��0�V=ΤfQ��?P.?�4ޭ�ݧG;A�&��\n�R���$G�?Ĺ)����r>~\"Z�����Y���@K���?��Ŗk�՞���I�����w�IboZ8Ua!)I�&�IbfA�=��=���d�>\"��>-!�9{<���s�y�h1ҙt������׹}�	C?�b�%>�N�u$����{囨j�b]�=�/�F;��yO�c�1{����쪩��>?:n����bМ��U�\\�B��!�v���JU.Ŋ�b8�3��ּZ�ԉ#�b�D�\nO��7S��H�tJ�h�0�?���^̦�P���v#�m�u?�Ӭ�=��I����<�|��&@)Ԓ�N���5�\\џ���9����@Cϖ?��ϱ���7��S|[����[?x���=H7�1��p�����Y�Z�4?�U�V���Χ�Ǹ�{�O�n�$}�<�0d0-�6����U�8L��x�Di�zѕc����\\3y�T���z|\Z���A/a2����F�V�Q	�K�������OL#�;��\0���^E<�t�X�?�+�_���]�?`f�GOcY�`R��)%m����f���[^����ט�W���6���J ?\"�M���\r���\r�\\\Z�N��A(e;��J������˴�%�K8[�J�(�!l�(M�\"vh䥎d}\0$|������(�`�Y��Ou�Ȝ�7����F�M>�x\Z�Rq�������?/V���o�5���@�|N>o���?x�?�5�ƹ�L��\n�j9#=A����]5}c^?Q#���3}X���s|fI�w\n�82�!?J�S��/X���N?M,!&�=�?jA\"bF�n�����y(\"\'��.Aq;�j��?��c�mKݬ#��).(.I8��\"�\\d��ag#E������#}��@&���h��Gt��N*����_\"q�ԕB�E�2�?}<�*�[�몆���Z/}��3⻼�U�W��pը؟A��i��d���C�1ϕl��%�~�*�6�W�U��X�N	׋77��jx���t�r���Y��CZ��+�3�u�H�?U�J\'��:YB|�����J�]�����N�������]�e��9���?q�c\\�R߼.�����-8�٬���=���I���{G�D��[�?��@Yܗ�\n�D�ZGIF�j~ԱJ>X�.?pM֠���{Ӵ��,1�h��ߕ�{;]8jq0eg9_l:��yM��	��\\MC�.?0wIH�=o8��LAW��^�p� ?ª]\'h��%��A]��Xvܛ����X�r_����3�?{��B��o�>N��(xp��ŞW��H�\"�ϴI��d-�ϿXD}��:\\��Y��sQ罰�}32x�j��?��:e�Z.�?z�)f����u�\nKO^0��gc��}\"�\0=v�KԿ	���?�Wq<���t��aƭ�a�i�PiA��A������/���H�x�_�޾_hǻ?�[���CY���?��L(�{�+���6�^d��bFx�vڲ�s�0u��~��X����7;��#����wx�D��yno�V��VN��~�G��$��\"��?�Pl�5�6�>5 �݅pz��r~����e��*Ɯ\n�J�й�R��~jP\\\03��<���4���`�?ȻG˟��!/�m5n��c�*��n�O[HE&/�na�X����j�?&�=��o]�A���w�G�7���5�FJ�k`�S��y�n\0xz� ,����r��p-}��vx���2�!�(�z?9�a�����7=8̲N$<tr���m]v^x�\r�&簋c\0_�y��r�@�d0U��\'R?��o]�2�e�o�?R 7�c�!\Z���f���`\"6�{��eg\n�K�Aš���(�朡�j)�?;1��~V�8�?w ��S�s�P��߻�$����\re�U��v��j�ev�\0�\\��Lzϕ�`oL�)&R?!	�r�S6��Uh=�X^~�#W����\'\'��;|��Gj�7]��xf;PQ@<�+�P��p�����X��BF�Fٜ3�?1�x��ԃ�^�\"�ϧ2w2hS�G�#��,މf�n{�`�g �����{8�H\"������B�?�X��s&v�!��� ,�����Z���\Z����~֌]<�)5��Z>?�Am&J-��~T�;o�^,$�#�h��?����ԥ\'���ͻ���9��B��\'R�qB�4�eȒ�WS2�w��~��p��%�E*?	4L6ў���[���Ie�m��z�?��N����;� @���(}��9=\\SH���NX�a�O���8ʺ��\0�%l�Wq�C�\Z�{����N�鶌ozo������?xJ��b@v�o���1{i6I�kc�\n+�A��~��b-����k�U�?�?hx�a�G���?ʅ	\'<ױ�3(^���\"9�c�dꎃ��~��}���f>T��@ґkf���n5��pF ����3�\"�|9�B�%�{�w�.U?��#�PS`� ��t��<����s`��ʟ�2\Z5�a�e�W\r���.����4�!��X0�Y��Q^�\'�y�>k�\r�L*^#�O6X�*�J�]�@������I�w1_щ����c�OˀL;0$M��}�D+�	�a�ecotr�MS5�e4,,?��[��\"(�ԯ|���k�C_����P��?�R�@ģ�Vʿş(9��uv>ی蘶�ēg�\nb[�Y�I�T<]k�[�)�D�[��*�숂D�Iy��X��e�Tmsޔ\\K w\r���\"J�K�:9?��aN�<���U���S��[4j��x�鱨�P\r�ag���A\Zy�G��?\\iF�/�|+�;��(��I9�a�Ψ��2��on���M��BmG�q�B�0���?iۻ���6�?�䇗����weu�w�#�Kf���+�4�1\\�(�O�q�O\\���z�o���y��_e��R��F3?1���;��������[6? �?�����(�n��&�����\0�=b\0݌+󛻊=��z��\\DW�Z��a~?�*�8F��1K�V�S�*�n��?}|ʮ�L@\ru�?p����\"&��n3��:�tb����٢�\nWE�>�I��֙\0P��A�}f���L+f�\"^��ŉ���_@��~߫t��<���k1���իU9��N\n[<?���\'TU\">�l?	|X�\"X�n�0L�\r|�l?��2����5�Q��y_��@+�_wl��l-?k-՜^�$ك�+�Xx�ؽ�����=���8���o����}JY��z`��ߑ�X�7S\"�-� f������z��(�x��Q�53�Kc�!&-��:Q2��U�5:x�������?��?d�?jQ�\Zա�:��!\0��\0~?+ \r��L}�������y������Z����ҳ���9��vB��?��BZ�?<י�k�\"�Ky�����l��c��o��=G��(���X�	�u��A�?��\Z�q7���熡�-2��A\\�·mG�U�5��1>�R�_�ͷ�t<@V?k嫩S�+�A[1�D�:S��:?��aU���]�K�W5�x��CASx����?�(�!?p�����Z9GK�?\0G���f���D_߇h�>z<l`�V{69��NEJͅ���$�˸yR\0?�?18�_�-�#^�nF}���[#������#L���~{1귚�`ֽ2��-q���;ʿ�T/��m��J��F��I�4�ۄ�q��N����v��]~�d)I�t�%���Y#�t<�b�������}g��/\Z6�?��|�v\ny����>e/�$�F(mZE�{�:j7�~����3��ϢO�X�öp0�%\0g,?����xO)\"M\\ �?�Ų�g��&\\��Y���?M:\r�I��=C������ّ��x�G�Z��<�����z�>�!\"跸�$����n{��m�>�ܴ��lm3��es������n�?�+?�yP�!�:q�??���Ў�9X���w�hRe�+������_�����{z�d�ZY̻��,~ޢ�����I�*����l�SLǖO�/>Ü7�������ا?|�bPY�cԠ+d��Z?��Q�.�\Z����$\n?�!�ͺ@�~�\0$���x�o�T�?��+�N��>-�&_x�\0�Y����T6o�6Bk�����a��3:C2�?��`Ƨ�#�O![l���X���J.��8�u�֡��]�H��� K#��b줜9���n�x�[��c������n\r*�3��?��NNw�?�Mk����PؽKI���>�-ĥ�R��?�38��Bjc?�4���\\��ٖ����Z�]NS�?���.�����;�.�(b��Q�[�IH��e�~�.խ2ȼ@�騟Q7޹��	���\r�Z^2Z�����ʶ�@��m�xH�HI��c����Cq���Wg����fdͣw7\"��}4R7y1?��@�د!_�Q�\n;i�=��C�G-¼<��%��[�6x�A&:�ר�(d�?�}_p��R�LT`,��u�T�ſ�W\n(�\"�?�Z�(p]����?Ī�	m�so�?$޾?f��?}d�~eR�,~�l�&�ru��I\0��8H��۹j§��h�{֛wa�+�	�*��zŖ�1 !���C��&r2�?b?�<�@��a��\0�������*���gh�\r��_�$�L{ƴ�4(?MK	&dG�~	K�\r-~�)z��*r�?*Sc�1�N��C��%E8�oI50�1x/5��w�UbH��]\Z�ǳ�9>z�/�؃i7~v��v��d��?�S����k�U��R�#�ע(^%�=Jb�}�X@�r={T��\Z�g��z.����d%�CX!бBu��68��\0V,p��]ާU����u�;�d!��b|�?���~�0�!b����\Z���ی�%�G3��qWR<d��\"���=uL�\"��)=�1ơ5�g��G�KN#[�t���[��m�D%8�=4�C ���wﰽC,[ڱD�?����-�6�k��=�L�WѼΜ�[�ƿ��P�)��ȃ\njw����Ga����-rȥE����?����>�Î��q���ل�ڕ_����\r�\0�dH�w�Q��S�0kwm�Oݬ��S���fR���EeGD�� �-��j?M��L �|�}Spl]h��,P8����pD^�|���H~$܇d P���J\\� ��@Bf�k_���g5��Ԝۇ�Qt�?�h������~w91�=μ�,?��h�?V@����+\'�������fC��^�����<M���XP�k?l�yr�!��蘽����:_x�c�)ް_V!��w�?Ė倊(h��\Zż�#˱�:ZF;�ޢ$f�Zb�b2$�9N�`g^?KGNκ\ry�\n0��Y��{�1�f��UR`�$x�N��;JV~�=��ۋ��l�?�d�^�}ڼsƒK\0�~4�U�?:{o��\r,�u��h���4��l��QU������?;a2���N�hc?��0l.>�P#??�A��>�U2׽a[}�ud�+�6�O�?�½\0�ϯ���m��{�!�\rS�u�H�@v\0i�ts&벦M��$r�?�P8��J�m� -��0�X߄|�;?�j��b���A�DwZ��ou�in����l4�\'+\r�8�Fk>ӲG�cNQ�Rn�7��b��}M�~�6˥gC�c�н�A�b^V�mT�2Y��7p�$�b2�s��Ė�5����ԕ������l�����+�?�b½����X?�W>��Mk�M��?��g���y�԰?4�ͷ�,��iz>�r<z�e?���eb����JQ����Bȃ��V�\"�B5Q���c�w$�%1��t��W?E�zl������1\n�8UW+��֡?��e����+���\'z���0�\\�5Ϟ㋳�@�RF<�r[�V�t����$a)2b&2j-((�uq ��S�H5@�7����S�+[�h��6�\"�t=2˶E�k��g�� ��?N�x�?mN���Ű���t�����W?a^��H�;x\\ȗS~\'g3������\0/��ٕa��C�[��<�g��N�JH��5~A?a_�Ak�W�^�\"����F�K.��$�=],\nQ`*�51G95�J��=p��\nΓ�ϻ���S,>�ׄ���Y���vp\0�b8�����#���wT!0��nԊ��<��>A����D�C�k������`t߭L���~~��n�\\�̈8m!�fp���=nRS���1��NW���Sm���\'#wz��_��:�|ůt��V)k��?o��;J�����|��W�k��J��/��	CY���w�����Z�\'�]?chn=n<?��.��ox�ܻ�� }R&^9ߒҜe�j\nGc��\r��A?YG������?m����Tvm�[g|�\"��!N鯙��c�~����up�\"�hf?��{�,�k�`y�U���g� E����{tz>`r�l��R��\0���Òs�%M{�]?��~�h������?\r�$�a6}��g�}:\Z�!#F��.����Y}�e`��0�s�?f��sb�°k趎�#�\\3��뀩\0��p��qk{V����\0�j�+z��߱���r3մ�z��f�zh[5��|��5�|�\Z*3�Ғ?���G�O���7���0���rp���5�Ǡ��)#߰8\"�	��?Ӕ(?CA���#�0�G?զ�f���k�%B�[Qˋ�?�\'�\0�����$i3\\�f@�䡋Q}\ZKS������9S?�8\0�Rp��AqV��b�)4������?.s+셴����5��K����\\xbI5�E���l��|���\0�)\06��+�\Z�ֿq�cwY?�����eC<,��ռT��9�K��+���I����;!����4�ߵb�� �<\"s3f?\Z?�&H٥c�.����yNq�$�@f+��!=F5;�o{��H7/z0\0�0N\'eY05�qՕ\0o�B?��`��FŞU@>��-b��I�!�1AX�L���u�p#�f7.��Ŏ?����6�6�W�u?����	���ʃ��\rN������)&�\n���X�M���N�-��x�0��\"?Pq���Ń�^��[�n�6\r!tp�R���-\n?����[f��@��	�2%�;���+��M4�4ffӴ?FE�?�QJ���#f�<<\0)�?5��{��y��,�>�*ӊY��\Z}S����͇(`�U�\Z�\"��	-V�E�;�\r圵�Ե�g?��S�L�}2�8޺*�T�n�u�/,��>����h�R��P~��-z��㣤L*��?�A/D=����G��e��	9=TY�\\ǹ��J��_�[H[�H��J?C�-LK�7|FrG)�����~�ˊ\rgö�����\'�ƌ�����>���\r���{�o�B�?���\n��p�)<�湵�r����p����8x?I��RO�~���J��bs��f?4F�Ρg�9������P��þ&��\Z}��D\r��`���	��<o�l�`���}\\ �Q�	��#�ݖo͂�2��I�SC�-�q\n\'fM`��U�^��{�v���{�g\'5��?sm�*\nM욺?u��Sٴ�*=���A�gx̮!�w�5G=����?��h��%TVT?�$��;H��������\\���[����3D#���7\"19+{�H�g�����\0�9�3�%�b\"~�?�D$�N�_�m\\�zNMaO_�ģ��`���y���u���\"_�4ŗ?fc�r�?<�B�M�;F��9�ҙ^a�\r�l�E�@7J\n��%��Ķ�(�ۄPZ˓��[��_���`�����04��=��?��RDʣ���c����D%��� �p�\n?#_�x�G���?�c�-��Ġ��6���7?�\'3��lm�U�b\\f�\rFC��c�R�o�~��(�!�<}݈�Us?�w�}�?��.��,�a�S8+4҄��F�J�}E1����i�z?���Z����Zj�?�S�ѭ�ŤKm4p��K��W���o?��h-r?i��`II���8�Y��|��\\�R�c�\"��Z7����x9T���u�*9��``\Z?����|�U�Ζz����bʖ&�Y�l+CLb�_�}�ϻ�q�4�1N�UiIta�����eS�;�.�Mw�3�2��!�Nx�B�A��i扇u �(��$��-%�������p\'y����_T8���55�WK�}_?��6{��Iƅ�䥮?�?!W>���#��k5\\����Ǽ�L���oyQś�y��g�����ʉ�!&aXd�-��?�b7�O��x$Ϻ��m\"P �?�X�*�D*���J��{՛�\0\\m?uB��6��l͂=�JR�@�n\r6�n�x`�p^vuFD_I!*J?u 9��|��-��k�^��g�?0�v�T��2m�/U��*�\0���E�VΛnw{?�����$�����?�Jkm�^ S:o�x�e��a���Hq��/���L�?�d��m���?��a�?q,h��W)�Q�m�W�P�� x�Xh�k1�����J(j2<`.n�/{t��L�Y2|�~	#��]]+�/E���|�]O`;��E?LZ���+����R؜{���[��?d��MօpF	��	L������<�c,�?2{=��%\"u�q~�K~����Ha3a�ؕ�%i���s�M�{��b�\n\n�z\0��P�?c� �^��_9�ġm!%��A*���Bf�s#�\rȷ#n��\0���ɛٮ?�1�1W��U?��I��6�Nb9;:!8$���M��*S0���C|?5��,L�sd�	:����0��<��PgHKt⠔\'_x�{Z2	e��MT���s��_�|�.3u�6�?{a�r��J�;���|��Z�Go�^�#ΊZb��1G�m~7=b����[n�$��8�;���B�em�c���?g�%��_m~\n��z?�לg�j\"�{�n�6�X1jA��-Vݼ����5k�]�}׶1S\Z���i�dܗi���)V|�PJ���V�_c���x8R?-��P�:��=��v���衵sz-_����?_�I~�_v���\\3u� �e`懊f�fĚ�F<��<�,{���\"�����ݦ*��s*BcsR����r���\\~�-�R|���Y�?��\nNA+YN�	p�w��=�ȶ?������?K����W���\\?���.z�#��7�>1�A���u~4?��dP�2.�3ӟh�.T]$�\n6P�Q;�+���w���!�?�J�\rxcq%����|���.@\0���ܼ̥�җ���Ol��h� ��C7�yZ�G��w>Bsp�ح}�E��I�#YӮW\'3\n� #f\r�����)s��d\'B�=?wɦA�O>�\"��Y�u��.����?��3ɷ_�����[2u��U2輺{,�t�E��~Ԟ?��Z?�(C��.���s`«��.���i���i�\0l\r�1}fZ�9뷴5�o/�la��\Z�pO\\��F�\Z�y�} 8��q��>=?��w5�/��P��bW�?;:�|,��c�%��*,�`?S{֠�^D�as�b?�-4�_� �h�Ƞ�N���+��;�_�?����C���}WZ�<�>���\">*�?G)����!�^�1)��#�2��uLچ�7�x�f����Bx�bv��mv���H�C����q�HܷA��/B?h��	*�?r&��X���?��ke6ZO�[M�|<���Z��-���?r��)����ef��;�q�7#�b�a\"���?�P\r5�s?��3�Xc��Mz?V����D1W�eN��\\�`����lJ��d�ֳ�?໨�yǗS��E����:���#kW�\'\r(~�O��=p�Q�=���\rc�O?&˛�Q竟9���|��q~1MNjP�]}T߅�i*wsg� �������[^?�?�����������L����7E�p��;�_�@����?.�Nj8���_�T?�*Jg/t�._�{�!�kz�_���]\'$��~&�멀뉰R+L��j�B�k��ra_r\\m�����g��R\"��!2{��^c��������&@at�?Lp�Nl&Y�ux���A_���L�$�ߜ���E�17\ZUH��4Eаz\r�{�����W]�E�&H&�q��I*?Jw�=yt�[6F`��D��	m#�������B�6�ƥnJ��.Y�J0��X]�]���_Ã�\n�|!a�|$^�l%M\'�JY�Z�V��Y��k��z�3�Y(ջ�Ȯ��7�f�^�.����n�F�0>�����H��?_;U�����gZ��*��+�燇����;���ɯrJ���b����ޥ?����~�l�Y�֬,(�|Y�Q����ק�*�!��)>��&[Б�S?���k��@|?�~{���jB�46�	�-t�r_D��?,1d�\'��[�[�x>kw;�w���s?>M	p�<��\'����3��]�Y:\rV��?�THQ�]�x`D5�f��,��o���4�B�WG�@k��h\\�Û��R,E��[�YMTYN?�\Z���~�r��O�|m����PvB\r��W��=a��bⱓ{�#<�۞�U!\r1�=4:9t�)�����zH�*0(/2�z������XJ��پ�6?ij�CS�`�ؖ���q��kK/�1�*po��b?`�lu���#(8�+�FbI�B�W�\n?�� Β��W���?.�\\pTm���B�[8�b������;\"<�]q�O�~��؅��I\"���Y�%{�Sf\\1��n{�I�.V�f($K�\n��}�;?���?�~-�;̋`��\\�]���� \'�` lf�^�4DZQ�E/�D���7M?����?�ʵh�����cAF�a�/s=��]\'�˃�WS���{�G\r#0���*Pq�tO�\n\\�+΋�m;��;���|�P��m|װ��],��Vp.|V��\n\'9�=��/����?��x���!\\�;0��+���c� ΢7wcR�<�e�=��� TE+K�%@$��¼C��NY,�I�-�\"P{���j����$DW��-��mLÎ����Hcib�YQݕ^��?m�.\r�}�@v�Q梳��HV߭��Z}��c��S2�z+�<!$�=X���,_�P�9�)��U;����/BN�rM�?\\�_Z�,`\\L)H+ީ(\r�|�����//��?@�0S�����V_�9җ%-��ŻC�C���32���BO<������hpTw�z:4ZwK�������@�d�?�o�|\Z����;�M�ۮ�eZH\'y��|�G��k�����ho<<�\"�+l��#_�?���\r����vP���z(9�����|R�[[(B�-Y��1��?4>]\'MG���ޔ?�����i��߾�]�#R�潅�ܱ�c`?c����\rF��\'t��-yy�|�V%|B�[Rj(5`pa{�8l���Q�*�zE��Xl)��̆|�?=����}Qh�éy�U��b��Pwr�\\�9�����v�	��Uf��X�:��!)��������`HC�<69�\"�\0����lGi\0�}��ɘ�چM��z���(������i)9�2^�Q7?Ph �)�`�V��@����^\Z�{=�z\'0Rز?#�>�)L�H\n�K8G�2F,�u�2�U�qax?���mn]VKbxl�1-֢?�M�x�{K�g[\rt.T����3�*V�\n��8|�߮52Ә�:]����e�5GͧsU���5t6h�����b�I���j�ᦿ��nA��ws�����+��?���a- ӽ�\'�z�\\g?����瓜5���<��d�JU�_��k	�Gu�V��D�9�{�o	���3t1փ��c^\'5��\'-I�,��������g4ùE6C��nn��\"�ϻ�:[y}+�t����p:��3D2�b�%l���\Z������>�,,�_�� Yy7˘�g���s��)�E	��ĮV��w�8#�,up7!�f�?��V\'U���z���/vu����2<sw`�ܱS�U�����ݲ?�ʥM�{x�,��������/�M4\'l#T�z� 3$�?�e�4Q*�N�����)�Z\"qC���yy}��,6D\'��9�;�?:��F\\9�0A�6È>[�׌?�/���Y�]��w�5�t��,���ς�e롞N�_y�`���\":k?=Yy���\ZnU\\�ۃgt M+�wY?�����.�ǽ�T�?o�2:�`��y\'�)�G��?��o�#F���^%�J{�f2wٯw��\n�Z���-���\ny\n�Ꚉ�9��h��>,!�K�^h�[�Ne5�*�\'�*I+x�X�wj�F_��ѭ�$?;jۅ,��<��{ˠ.�-�X1\"�xL˩T[��Y�Gi��l(ɾ/c?���@Ss�Q\n�y�\'�I��z����*!3~?pD\'ԧ���(�g\r��X�3�Њ��˵kIν����Gr��q����M��?�w�����+\"c5�\Z>��Va��X�8���?�v�?����M�A#�liB��(�^4h��Z�^���r����gC�I� ����-��Ʈi�=����L�����`4�0��pL���� �άkQj�κ��.����d)��\"��}Ϛ�8�����RYd!(�R���\"7æ���cjc��:,(5����w����0}��B9)�\n?�f���aě4��f���^��m�i�Ӥp9���u�W�{���m󵵱����G��\rO6����&T��$n���\0?F��Z\0ӭ�m�U?�li���x)e�uTH�٤��f3X�ƽ\\?���\0���!�4����* c\nkU?�?� �?�H쵛��p�{l kEW�b�:|�D!J �3 t�?�rbu���N�m��&r3@��z,�?�H��RL`@�����^�$֒[�����&V�\n��1��|}�tb�ݴt�?6��b�̧0t�����K�?7���?Q?�6�t��]��֔~����?\0=�8�O(�����7���4?rV�h�mܿ�z��^����LB����w��E�::;�:�J�NWm?*���E1���.��v�¿?�G�t�@��\"נ���I\n�n$^L\ZM�ھ\'����V�rS�?���!Y(0{(�?ݯ?Jj��2	�a�	��Jz�kp;zA�$vć� �u\n��~84*���߫��9��&\'VB��K^2���@��\r����X3ea`�\"D��I4���.�����,�uXW�����?��77F�Q?!���\n��2u��D��ב�d����﫪a2�(��f��W�)ޢ���7\r������!Z�/�|D�T�2��5K��jdX��q?���w͊�tk~,��cjOUz��\n�a>��\r�C�?�[���цn?�Y=���\'�1U��K|Б�>�w�?)�Z&��=�Y򑅕0�M}�B(Z\0����{wibkM�N��E����:���҈(�{�۵�� 0ট?`)<42�ưv���q=�Y[X񣫶��c�n����Gh�4�\"j!,��?=#��0��bP�ʆ��uz���}7Ϩ?���U�]�W���5;Y�F|����U�ZHD�>_��=�R\n�ԑ��~��VY���z��?1SFO(��Jo���\"T~l?y�8�(�y��y�)?��x�.s�(�;�p��Cm�a�G���@��:?�;O]&:u��Gj?6�\Z���g��\r����&&¡�`\n��B��@d���t�X��S0Y�`���b\r�����:�����6b?������\0w68z�F��;B?\\�b+�=�_g�_x,�K\'�sb%���S R_;ܖ�?�L�΄e�����z��${Ϸ��U��\n��;�O�m�\r�b����\"j������l�H]�T�N`��ay��|}`�Bd�ù]��>��՟A��}����JkS��p^��*�\\x/�X�\\�Q��GJ8�[�9M?�F#oEw�#&��$?�[��)r�����!�~ǧ쭱2jf�?�\r�~�r>�P�2h�A�x�S�h0�Y\'?g��y��+yԚs�\ngZ���;Ox^6��u��I�e�����3�5@�)n��),��)�S--8W�U8Je�s	w?�dz@*�{�MU9;7v1���7�A�$%D��p����\n�1�0��8�k�?��<��׳���2�������G�J��?�L2>�_�Q�����b�/��72�-ךt7���9\0�lpW�	�5��6#D���N�7樵�iʸÓ&�H�GGNA�$a;(n܅��d`�0F�]$�e��)_�v�???�C&|9h�\'�=�Q3z�֓!���wg���!d���$e��1�.ԠA�h\r�\"��_fW��m��w��z�/�Kz\r�۷�2/�Ұ�6��D4�F��dG|Q�U?ɗ�q��\0�l:>\\I�1�V%Eȫ�NK1]h����U��o�˼��EC�=Lٸ�ߪ�-$�~4g�	�	�{~�o��	?=_�������3���D�n�0�P��m��٩4Ϲz��q3��\Z���A�?e=\\S��\\x���,�e��5��}�z@7��#�����I�7��&^�_Ƞ6����v��g�0?�툕7�	�/�+?bT�Ҡ�<�DV���fB��w\r�+��q���@O�੤5,S�ort��?��mn0�\"������9u֕�V�\'�\"?kC��)W_�ܛ�L\'�W���ò?I�*�+���ŵ���v$]&����\r�C@KnPn6��A�S��S��x^����S&��?�X{5�Q��I��ζ��\"��DØ��j�?�k:��������~���hI�gϾO�ϗ�;�����g�]\"&�.��	\\[���ѯW-�t�����C��H?s��hg.&�9?J�?�|G|I���s�#���3 j�����-pk��%�h\\��T��b_ti�\'��?����?8Kd��3������.8pc��Z��w�����+h�?�\r��9ף��S�3c鹠�$�?l��9S�\"���>)�+�RKH�x��kZ{Y�h?K�ג��)l����*[I߉�\rנ�A`�\"Q��G�&�E6�\"wl�\0�[��y(�M��ňw`�m�S�X?��>�s��h�\r]r\"#?�S�q��j-15d-�Q��������.Z�ŇZ���c��祎Md8�=s>���F�Q��_z	B�k�/W�i�&i����eG�B?�~�	\"� �l=\Z�\"�JEb $LxdX��?�IM5���L�?������__?���R�ǿh�v���C7@ʵ���G.dc?\r�,�~?��������\0R���ych��;�I@-/��J�T/�����GoJ���i�V�?���$�v�+$S&A��W�bG�m��V!nt]����\'�Aj}�)o�-N?v�m#j�/d �/�?jgk�6�!a��;����T����W�D,?���,�v��N�M���b���K?K��P�r�T*����\r�1�8�N!.�0[�	X�^�)�t���@\Z(������$����??3�E�G�/ٗ���ʤY�ѥ	����\Z��BGa�1z�wk��g?��g���=��.7壧�Be���ue�2�uGQk�8�0�YV8��}��M�������i�gL0��u��L&��w18v������O<Mߓ�	�i�T��Y�O�S�F���5*��1PN�]}@��y�f�^�7z���;E�0hV=l�`q�-�P�\\����|e-\n�?�\"���`�b��BhsG���)���=_�?j�N������X��1\Z\'�D������4��%��.�?��?=o��B�.�@���!V�l��uJjdI���6����R,kM�\Z?��F����>���I&-���Z?��\'�2:�SZ�!����K<�C�?�E%e?�;>����p�dgw�����Z[p~����Z���:�Q��\0j\0�\'���^D���G[�h��q�h�\\U��;-�m�߬mZt����\ZQ�����2�%���m	���\ZcQv?5\'?\\�ku�}xIL��i\n�B#u�������ƑD��6P�Y}���7|�?H����|ɓ(�ɷ���N?>R�?���h��z_{�ͪ���ѯ�-�-�4f�U�GN�R�/�\n�|�����Gm�Z)��?�	p����u\"�3��\"��X�~?h��A\'&�?W��;e�-\n��Epoi�2d�o=-�RJ��&c{��©��K�b�]̻�4���?*G뒻~Ζ?�?>�7�@4\'޸�?����\0���59�H�Op����9�pY�H>�=_����;PFw}SW|NWOm>V��{Rk�p�S�L��Y��>Db�Y<\\�\"�F�w��;�mG��WC��b�$�vk�6?[������Kp,��\n|P��Ľ��\"?��� �v�?��;�^�zKŲHH߂c�	�$�a}�E.���A���X)�H\"}?xѼ�g��iv�UL����?�	-�O\\�>w���!8�\"�M/Gy��i�K\nD-)�\Z�I?$(��BD?/Qg臬7�N���,��F�+�a�q���ӆo�?ub�4Z�?�iu�\Z�Q����O�����+�$�/�������1lA�N���9��~`R�F��y�̽�!(��e��;��ٲ?/X�>�I�J���J(U����a�X���+�d��W/<6�a9���+h^,�L�z�ڵ�b��$m�n.���<�G��0����[���}%���\Zn��~A��)��5,R�H=��1�����E�^�I�,<�N������@�#�6�e5���4����I�l�ԙ�Qr?��{�껨��k�VZM�ev�T�ٺ>҅��K�\0�V}�-1l.���s`}�����o�\r�ɜ3�v����mG�|���x6\nռC�?�r(?y�~��yٌ�He�����n%ު��$� b���@UK�YW�C����%�g���?TG��.�Nr5b?�����!��M�C?c\'B�v?V\'�	���Z��Qψ��ޭ{\rR]ǣL�\r\n��B����\".�{OпԎ@d��[p�E3��F���uu#<�z-�uBlg��#���I\nt�%�<&cuuoY��C�/.Z?험���\Z$��MA�]�@�\Z���5q���U���X�A�� ]��0��{�\ZgȠ����o?R9�?�9b��MC��xc�~���q\Z�j�جET?�Cx;6���w�BkF5��02�����i��j_w\r)�}�)x#<򡸃غ��[�n���7����#��b�V�\n������C�Q��f2QR�Ůɳ_l]��W������Kl��OTC�F^����g-7GT͂Ș�[�n�m)N���6q�B\Z�COY�k?��Kʀ����tru�?��S.�+;�����\\2K+�?tȷCkQ�߀�8߅�	��T|��)��D�f\0�	mO�{M�2�S���=G��p��?�v���%����o�?��@}��ڪe���51xj3�`���� $��i�E��$��cU���&<�V#��ߨ�?.%awRL�P/�c�\'6d?�D�`�b�a�jS�Y��?�sڼ�J�3�g�)?\r�]K&S��!���z��C������dD���������~��$��X\r}sp�q!�n��[4�\\`D�V?�l���U�C�^_Q�d�-��Yl��1�̰���튪F]���ۨ\0�A-\\w�5fS�r$�h��\"?��Y��}�h�3�5�s�+A\nSv�6?�-4Rq���B��${�t��.��_�Y���������{��7�ѵ$�ZnP?���s:ɥ��_����`���@H�g�\Z�9��_�	��� �5�Wg�N�^����0�dCx�k�f�C�5��-S�FoM�ǌ��i!�r���e�<ܥa)�\rX+�`�z�ɻ�???�Ʌ	i!�U���?�R���I��6n�t�4�cLЅ��$���r~��T��c���8����*�^k:��:�Ɖ�		�S�v�E�����/gl�/\r����퀚\nM�<�W&bFRgȃ�_\"?�x���������Ӱmk0�w3+�;U~�@Jk�D�������ts�$Z�޸\r������Elkc��ڕS��=d@;�1?�5eE%㱥il3D���r��Q;/�4?�Z?�>|�\\��j�y2?!���NFw��j��SO]���U|�q8��?��w�v���c+&�4Cs1f��菉\ZU?�_B��@�t�Tf�\"\'޸�c�|�Ɋ�/\0j����P��0{++�}�)\n�*_!�\r���l>N;υ�L��}�?P�Q<	�o���W�*��=\r�ȅ�^�ʼD1�NF�z��v�.H�T�֨5�r�p�6>��^Ǧ��C�jn�*bi=���C��B^슆u5�?�UvUe=\Za����g�/�1�<b�ڃŞK�\0e�7�#��M�A�0�3��������L�T���bs�Ls7��%�c9Ӡ�|�i����,���T�( ��K��}G1-6�k�\'�bi`ڴb��=Ѯ�b���8U�Dr�8��g�/_��*N���B+�O\Z3z\\\r�P�\'�0)?P\n�>\'�7E�v���Im��R���\r�\Zy��?��I�.�N͆��?�tP\n�?Є�{��29j�Fw}�D�S����օxY�&]7���C`��IL��i]�R3���C�(�A�U�D���1�M�ԗڳ~���ޯy�@���:^-S����������L!�?��~�tN>�!�ކ��5p�O>���T�� ���ȭ�?kqR����/�?��aQg�f֩��{d�\r�$Z $xHi&��\nK��q��Fd�hڹ�M=B;?����A�JI��E�������1H=�?�$I󱀖��$����0���ۓc�vC�O��_?Ի[R��Hq\0l�:���DV���Nd{[��[Pbo0��,���2��qo5\"�:����VN�?�>L�&&�C�\\e����X��r����gS+EԬ( ��Gg��e3�Wv(\n��)���?=��e�o�m���Oq��Ӱ�{9	����C�k�w��̾3���u�2��j5A?��?�_|�闛���͂b��t	:�\n�&� D\rCK�?3hֹyP�_w~B�S��Y�L��\Z�C�0�~��?{�t�џ��\r��4��Yd�%��.�K�?������R+Z��+�iW�#4\0�\ZL�y}Uߢ��/p�g�2!Ȳ��?>�?��Ogu�?�w��`�L�WH\'\n/Vh�zd�(dW���j�I���U\\���+r��;Ǿ_���m\Z�7%��6���m=���v����h�/r�4��j$��:qh���=o;?��[�N4�^������=�Y��N�?�sVD�xTO?�Jd���1p����?���0�2�>��b\\������9�\n�/�5%�Ę��w�g\Z�o\"�v���6H\Z�A�l���~�e8M�T��E��<Y2�P.�%;nvc�w�~�(�����:8�nϑ����UQ�{E@�D|��?���y�(�66�\0!+���yԒ�e�����]���\'�(�&Yj�����A���ԡ�_��^\"�a5��`f��g;�g@��fa؜��r��#)�|jу�w-��e�\\vb%�N����dElb)?��2CM�aU���~($��k�[�?c��G?>�|s�ńY A���႞�ߦj��:�㠯>Ք������x��s\"<��u�G`o�q4\'X��Ĝ\rq��ÜyssŸ���R�(ػb~\rC|+��?�C9��?�5!Q��?��?�ȉ�K����N�hu�]�oPׄ��es�?GD��WT�P�Y�7հ�e�)��(\"������p��?��-�~���_?�A�}�?drdS��!8e�Y������9|/ף��R�+�v8�A��X|:ok3��?��Q\'<��Г������ހ7�]��P�4\'��)B�c�]���aٟ����~���?�7�n_Q&m��V?ԃ+�[�]�?��~��˥Y���/�A,??����?$~�����R#~���x�3�i^P�_8�%�lI͛SN^ԼƠyVŜ�2�ݗ���M���1+�>3f�.;k*��\Zb��?�lw{��o�	#L9]��0\0�1g�\r��XT�B��2e[��1G7?���K�΅?��ϳX-�0Sѡ��|�o�}�?4��������n�daTYݘ�{��W��*?Y�gz�����S��\n-�L�zx9T�gl�3�\Z4U�ȖJ.�q<�5P\Z��qi���E6|-r�~s?}��g�����!���z�*7`�k:�h���͢tާ����C,�T�?k`M:��ѩ��I��\'�}|J�IP�ґ_t��6\n��4),ݫ�S�k�Il�*+>^��z0z��*{��<X�4�K���Ԝ_l��a�Bۜ�Io48��o�[D�����K�2[O�쓽��g�I�?�����:�)���w�/����΂.�ĕ�pSR�\'a���Sǡ�H�N�E��D�l��aQ?�Q#O	i�c��?�+��$	p���tݾ;�J>AC>�/cZ\\�凉<Κ���L��{&q#k<���-���1M~�4yQ�x�W���Ƌ���>��#���n���_\rS��E?�Uʧ�j���E\r6ʣ��?��@�^[ʠ�Ul�u��n��g��=9IsϢ:6��HkH�i�_O����$3�q��g��^!p?T��Ό�����QY��v}D��i��?�ԗ\"����Wo(���?N�\"nڟ�����0?�1�xI�<�mw�gV�7���p~@͙B��%��Qv�5�O��N�(�K�G��Fẏ>iT?�(���ݑ1>\\[ҪȮ����8v�qJ���͌��8��U�?�H>n�e�����a7{O�*���~2����\'\':Ej���?��=T�?0i�W�������|^|���c���z-��#)[!��g�{\Z���BS�mQK�k	��hImϸ~|?�`�X�O_4�Ļ)^n\'�LZ�m�\r0�����:˹4Ѧ�b��MD��5��W+��C�ݙ�?�[1����ٜM�Y����?�^����_�e�m$��0�;�о��b�VU��K�ɂ��b՞Y�C�7|6Ij�U�F;�n)�8t�БŤ0Ht��P�(�L9���?s�R�?\Z.N���:?1�cp|5>\0�@\'@i8���BN]��sK�҅\\l$�ʕn�-9ᱻ�.a�fd���?�7��?j�Xyr��hb��!��G;�\n-��ٓ�L?Fo�l��D��B����i��?V�>\0?I�?�?\nޡ͘�vy5Ct��̪�O/Yz���;�@��olo�o\"Cbn�m+�?N�����2\\��m�ERT��-��<�j�N�\"D5��b�2\\��?��yȆ�Ӽ$Q��}�����3W	14��Ζ�σ�o���	�����HCd.�+ޒ&�h�)�	��?��=:�d�=`?�/7�Bx9fa#PN�74ĭي��4����?�\\ʣ�ߣ?*f^\Z\Z�u�m�?��ILW�t:u�=Ql�a�L�F��qLB��P��q<�?�w�X�Rw3b�)�Ћw8�[�f��?�o(��݊y�2M]cl�_z���Ԍ0�18��p��<�^z\n�,\Z�\\���ߣ���*3\Z�iޖ���V)�`���*�a,3[\Z��}�$P)�k�?\r����\Z{���+L/hK�v�x�KI�;�Y���cK�Z��,�����?���߻\0��~ے���z��a�~~�7����v�}��ixO=r��:cCH�.0�M�vrq������n�����Ģk�S�D�)���\0���G���;uO����v\0����?��D��تf���sL��EYzU;0���M\r&>6Kv��ҽE;��[x	r�C��8v!,2�p�0Ꚏdˡ�8�~?��Gi�THXP��?�iǄ��w4,�ɛ�F�?���?&q�r��4\0 ?�6g�Ɨ=��=x�_�%�0C\'�X[�䤻�x�!��sa-d�2�+?~O�?s�1��F�=g��M����T�M��N����	�>����uM��ǹ�_�Y�ʶ,N�N��\'4������?\r����\n�T���9Z�U��i�\Z\0m��[��NT>]u8U�%Z�*��ڳ5iUXN���v������]���9�Y=�׎����E:ޞӇ�����q]Iy��0�5�.����]�g\Z��!H��gm\"�?�w�jI��wg��8|����7����pnH5\\5��Wnʚ*�H�S(���?�W>\06�������NRb�W�@�g��\na�~Kc���VYŊ������a�[�����b�ٮ�o/���Eku�R8�!�!�*5��:�Q��Y?�Y�y\'���)To9&�-�?�I�%�Bo�2�H|\\�����=qAK���ZNq��>�.c=��Q?t�+Q��N��?�<�?oHBNR+��bsi�g�;��?�T�]N\n�~9�]��S����D�p^^*�������NR���?u��Z-�ĭsECcW1�w�/�S�+��~��m�| V\n#M���z����fQ�1����{�S@��@�e4�i�U{2࿨/���e�ǘ� E�4�Y,?��:�+)|}9:|g�˿#?��M����`?��\r��c����P����4����?*ϛ����\"za/�^+��^��?_dw��K�n���U�*7	���dh�����J\r[��e�c�7��O�tƆ2P*Ҿ	�%�μ{m�Y��5܃�`��=G!�?����+�������/w��b�L�ۦ#��T�ir������I�D{�B5���<�k�s��E�|��?�����wK58%�<\\ڙ\Zf�t7d`A]�?i�4�?�k�ؠj�:c?���6j���-h���ڹ8�^�@h9�\0Jgƭ���,���󦻬���nS�k�gy��cf��`a4��ץ5���@rKD_iwZ�{�6��mudH&�T�	��|[f��������+?��U�`!�5X�X\0k����rU���1��%�^?l�����%���i\\���2vu��{�x�zyd�3�^��a��}�}�?(�+k��l)lЉ���g�L�K��|������j�yӬ��?pY�AyΖ�i�����\'<z?1&�N���9�4��p��C���M[�-~r��\"��rz4�g9y��+�h68��6��L����!�������i��??��g�/>�y[�Vy6�r�e#GZy����7�Ls���גڽ4�<8�r1F�ZwU��	�)�0��\ng��t����\'#X��>!\"6�WW[\\??�\0���;�\0.4�*r�,9�o�¾OA�\r~���\"H?Pbtq^��{��=���L$���b�?ҭ\\�tEB쵩z3����|Xњ��?u\Zr��7�j�f|m$h�(�Mj~�;��R�}@S��N�2?q�(Ec�\n�ڷnTX/_u�5�m[�Qâ9~�aǑ�~�N\\�x��h?�ĩ��L����*���\"	�Pƿ��`�J�i����#7�YaKspa���5�B��S�´`�\n�Q#��*�i��BK(�i�6N@��u�*wUv���\Z<[��taQ�^NƾR�\\VPn0X��?�A�ä,A�=ٜ�5�lH0��͸k!ö�a�p���^�?Pp���亩@01�H�:��5b�\\��j�\Z�N<J�--2:�n�����\'	�N�/�={���O�l�)��d\'�_�f����bGZ�+����wWfG�\Z�Y�ϳmq�Cb�?���\r\\9p?�ґw��f\r7^x\0?t��b4�ǰ�\'��t���֠��Cq��!��y:���`�s?�}���ߡq�{3n���9]�Qva+��Q<�\rIׄpv�\r|,�s.\Z���Ӵ�P��E\".�����,qyF�D��?��JE̓\'O��2�.`��d��h9٧� �/`��O�8��9��X�}�Y���\n��G+�|K�?�YŇ�s72MW�ڷ���?��j���Tᖬ?�R�B�&\nPYY��?�q*S4�� �%\\G��ϋ��͞��%�V8��l?bq��ꎩ��W!O(�h��ӊ&�@;�bK�\n���CL([��)�$t�%���+�,gP�9��d��*y�����Q8��9�g����m��(����z2:c����?�W��l߷�\Z��W�����p�V�<3��ۢ^�Ӵ��f�[�F?U�?��ã�˅W~&k2?��V����*�x��ŧ�ҟ��\Zg�����%���&���������Y��G����(%&������Q\\JB�����G���?-\0`������N��\n����o�lC���!�?�7o�M�8b^��\Z�\0\0\Z\Z�cc?�S?��&|���Q\r\r;�=5��)\0��o��O�b�W�U�l\"g�����FaZ��>xR��g��?�0\"���\0�+2�R]�����?�`���~�Bl#�2���| �l�`�}��|9Rm�փ���m#�8�o����ާI��I;+lS?�o	Ne溵W>3�)��(�{�0�#�#~V�N�<�zz�|�OT��_/K?ʩ5�����b���4\\Q8;,^\'?S?����	��Lu8�Elf�Ӧ���ZV�_U�_u#�Bz>�inGY���-7���f;���(l�e�Ix{4C4�����9��?ݣ�?0\0g.ћҞ�֚ue�]a#��ՙ���7?-�/�?}ro���\r��O qb9���-�/��ף�0�]�0�iB��Q	�Q����d2k��o}�A)h?Mn:�NH3M4��Q�����h�ʑh�!�}��y��|�6��MP�X0�`�YU5��y��W����ģ/��VꚛX�%l`ȭ����A$��������״��`�-?i�pm>��V)7�W�x��?2�8��?�2�nFn���j��S�Vk\Z��!ZP�ϲ?4k9�3�c��-\'����\'�Y?\"/E��չ�:I����8�>�? �\"hp�W2��6=cs���X5�<U�ok�d3�^��X��iW�?��F�?��½��Jvsw��UT#s{��Cy�R��������?b-��\"YA?Ǭ+�Sw��r}�k�r�z��FZ}?�>N��fr�8�f�?�4O��`nu�V��T���?s�V�����n��L\\e��r���~��_�0Wv�)?c��\nu�4enm�J��v�}�><�!�\\[UC��9���MR߽4�&v&�Ξ,Ȏ2穃4lm/�m-��b��?�%}66�m�_:�D�R��̈́c2�V���w����p3����xU8&,�\0x?cH�HH�1��$�/?��Ehv��A(�D�����`������y��l����n�j	��ʖE�r�/wV�\'�O(�����־]66(��;���_s����\\L`���lPV�{|�!�a�O\\Sk�Q�����e���8��sx��#v��tg?s`it��}?:�l`�pN>Mο�?�c���]4��ɲ�Gfh�lH�$��e�w�l+G]���x���\'KcM�|�����@�\'�d�/xx\'��{Ԛ�z��=������#�~U��_���%�v���c�ڴԒ?����O�{h���O�����4[�K��1q{��\r�˲7�>� Q	�y�}&�O9��9N,��&�7��$N��\\��u��f?�u͔5���z\Z7�g�\Z�?%r��~�SQ(a��k�Y�2�ՒfП�u��g��-_o�st6�m�{T秧�s��p��Tͼs�{B��\rsEK}²�� �OQ=��q�?\n��\'\"j���I<��D\"�ږ�������g\ni����ҼN�B �/=�5�#�\"��v�3�7Cԑ�8���IYH�H�ic��r �䈳�U���y�Q���H7Em���EGa4��ן6\r��w,ͬ�#{���8)�˗��&�s~���%X����%�͜x��?D�,�\"� TҗPδ���\'?��n�V;���y9DR��K����d6�NI��$��o�rlEKgSE�\\.�C՟og�g�$<��	�����b�Dq^�������z���Q_�f�<u&�����O���~�H��s�?�f�ae�9�?���䟢���Y�\n;87�U���i�s�?,�?n�;�k�W�Oƥ�r�Ȇ�%+\"��/՜%�^��<�1��SQtJx��(�~����2N�S��/?C�>��g�T?m��|�p�|��`��A��l��=m��>��\Z�8+�WN{��m3�.�:X�E]!�I�Ik��!���T8O5��+��%�X�Oi~vZ܎YBNߎ�x�h�[k=�?�ZhC���%Q��qv��L�Hh��Q@?��w۲<&:�I��h��� C�V^���/�a?\Z�J���չ��F-�q{J��q�ܜ���ߢ)CX7� �!��ӽ�!?��Y�;�CШ�Mh\r�\r�d+\0B0ު�1W�Cj��Bm������ϭ�$���aE�Y��+D�P���q�½n=ϋ9=�k�*��K��x�\0&S�m�/��!�J!s�6�?����P��o�k׮$�uh�$�!c�<2@P�Fg\'S�5�Qح�R��?��r���}Y�s�T^��,\n%���9�Q\"���0���?����\"�kTs���f�PԳ��?4n6rl�>�f{�{7�O��L�R�r\r2�#�³e�ZU�ƿ$��d>f����?�nã��]<,�?���?��z�.��߷�\'.!�.�J��9�xZ�hl��a\'u���oQ`�$L6�V1��Zv�c#�G�Cb��{#/&���]g-ˢsYH�Y�a�Ì�o���D���%�W2<k�����vp�.��sK(�3\'w2HX���}���/���@��?k۳�v�a�^�~�Z�G>�4ҲT�N�z�e;�ַ�����A�%���pʳ��,i��/�����r��㖓�H�غQ�P�!�>����3,�܅�v\r��#}W��y��tX߇�+��l�	��ӯ�gO)Lf��eGq��K�n�I��7���Z�����D�?�V_A��F���-F~|{�ai\0Ws:-���\n�`05\\�?�v����h�e��������?aLq.�?���\\����~�t�1TQ�k(�ի��Y+�ݾh��0����WΒ��?+D��E�i��\'\'�cs�&���oiς1N�sz��ψ?E�G�/k��������]jϗI4�\'�7ψ\0��?.��4{)ټ�>�3��J�9�-=ւ�A�����g\'��G�\n���j��I�IE�͂��α���1i18\n�-�8�d]]�J�[�K@B�^<�?h�]��a?�ߓ���h;�ݢ���g�1;��D98\0��4C�8�Ћ@BXD�SDH�a��QC?1�pit�Ƅaӌ]y��t|a	���;m�{�V\Z	μ��(�|�\Z�`�Ь�����g�f�h\Zf<�Q�׽�;�����]��Z�]���z0�o?�5��?jqj��\r�#t��/GQl�v�2D��%�(�m!n�E�ыf����{?F?dC����K	�EKk�Z�Z`�4�A�;��fO�c̖r[�X��xb�s)}�?��lB�u����}fl�p�N��|���#G��?�Ҧ�B�\\��E;cB}�p�������7��k���A���&F+a�W������]���{���,���Y\rl��COy��èq)����F���*�m�6�zչA�ί^#�V7߯ètzs��+T�8]*�	��}~	i�ƾ�����f�IUJ��3R���/��M�#�[�K(���XHZ5�A����RX��0W�*\'<��-Q�4��ʆ�L?�7߿�H��j�;qͧ��!vC�)ܣ���?�\\�S����{�^�6W�f_��삲�l��#�$2Z?�~�Իt�?�]OT�Z6#sV�C��!�g�wzkŃ,?�P�K?��\'��?\'��y_�w�L9��kbY��w���p4j���W^�\0~_E�?��cK�>Aݩ9s=��:?���?Ñ�]G[Z:HD�)�K?~*!U�-�#r��Ӝ�������J�?���s��ZW�_�w����G�:�<��92�U\0geC���}�pִK~�S�vbl�SN;�o8��6��d�\\�fI�<��o�:�-w?��,o�Tn�O_�L(�ߛ�K0?f�0:?z�+L)Q�S���2���͸�Er��VZ�^#!᣻�<T�S�W+ˬw�;��jVOa���\"+1�?K�sAk0�^)��~�]�Wy2����n�zX��!�F���Kׯ�CΥ]K���J�\'4��G�?b��?�\r�4Ie<�C�{���Ngݒ�]��k]�W^E{-LInuÿ́��~L��y?f�?w4�,ѓ�ܽ�����Vm�u���f~�,������Ο�)YbqKUy44�Xu�p�kQ2%�WS���\r[� Ў�j�z���7-��h�S��ָ/�\0�#?��5q�_={���5���`*}@��1�����=�JWż0�@!�1��-g����������~��j�o\'�>��F�T����`M.M�\0��( \"Ҥ\Z�^��J���=��Ho@zG������Д\"R����\"��@P�y����~����}?��޻��3��3��{\n0qa�H	�xU?I�I?��j�<��SB2cg�@;)���D�yoӋ����k�:���J>+��9;tN���l`��l�#��s�Uw��x-���?λ\n?ޫ%���\'��M��2G6�N�:\"�V��C��U�M�a^fp˪��t�t�5�o�?�x��J�:k\'5����\Z[ǲt�v�\0�lZ)�^?\0�;�Q��)�+|��,?�Ls�s{��b��Oc�>���~�ӛ�3�S���%�Ƚ-|o�h��ld��P�(����?v-�iIGW2��\Zm\'R�k�}����\\�FZ��_���`٠d�r�1u2�����B�G�#)�Z�+90�k���J?Mo�~Y�peE�_�	�3W�\0g�R�@�С_�\n�u�uڻ�W���({�@�2����C5�O@�o�\"|��-��/��gS��ǡ?R��h{��DS��T��8�h�O鯻��Է�G�{��^�������V�R�n����>�˂��of_U_�r����u/+��?���7�4w����h�hԉ?l/���}鰜\'Xt����,tX�I��?>�դ�|���&y�|��P�f��:|K�R\"Zi��jJ�=t�n�w��K�a��u��\\%�y���~G���a���c�h�w����~��O?m	f��d�?�uLm�<w�2�=:�,Q*^�?�V�.٧y��M�?\n=��D��T]\r/�\'en7Ѷʉp*g�I:���4,�X��~��0�K�7[j]@]�\0&e����\\����\r�����&4����S\\���5���c����k�r�S�%ڑ�um�?��ا���N�R���8��F�x�Z��u�/t�⨚� ���:-,\'�t�Rrjh�?\Z�ߚ-���d��A??�;�|�4+NE|��sǘ��h�X�h��.8_\n�����T��:RT~Y^q�k��V��Ή��x �>�����bz6E���>�r��Kf��ٶ�^�/x<�]X����װ���#E�!�>�[B�V�b�?�u��gD�ғxO�?HλGz�	197!((�o#��ڿ�l?�A���$�\\�}F�(�ʜ��¿��u��=��۵6�r-6?d2{l\"Q���/|��;:}J-z/|���ɂS�Ad1�\'�s�ǫg3�j�n&>��?��.:f�㇠��o�3�`}������R�?�Ms(nw�V�f�t��F����Ëe|���IJ�&C��%AQ�7�|��<��B�ffؿ�Y��98�F�?@\'x.<O\0��Ah<�L?b��$�c��y\'��{g�v�V�2�=�?b�f}\Z��7����ܽ��rM!� ��^1��;�׃�_�.��Y�Cs�>�8��S�s,�3$L����aRQ^0%	�]1?)���\"Ҋ������a������d6��+i^5�8�,b/�KM!���}��Mi}����diC���M	N����@���E��k�����oW�h��NP�?�rX��y<�ٮn�\0_b�a8�\Z�A�ʢ+|7����?�H1�ʉ�<��Kߗ�N?.c�y#1w^vpu��\0W8�I3���x�L�d��95���Z���9K�Y�?�.��\':G�*N(�Ee#�\0�il�l=�Y�2ht=5���aE��Β�?���9,%Gmw�-��7��˽[[���g��^�E�R}P3F��x-y{?ٞΖ�$S;��6�?��TgEq&O�� -$���d����� \'��U���2�>K�	Ԡ�+Y�z�Z��;noU}+��&I�OjN]�.��R���uw����ê�IY�>uTЅ��[��ws��P���Bp2k@��U�^)�J�T�ly����]=l�.�����EYg�Sk]\r����l�q��a�p?��≮�<���Ҽ��y5��ص������?�g+Կ�PI�f,�N<.l�)|�S:�ǅK���|����Tl�c�d��+�AEO}�l��h�T�|i�h�򲣾s(O\\&ry����P#�Ӌ��2�3qK�5�-�/}S�A��I��??\\��<M��D��x�>��mr����@�\")-���-�k�����H���FtL�Mc�n\n<,��F^gQ�n?�3�_Z�5�b��-h\Z/�Ta�]����0�(?@,M#�˾^N�� �Г\ZO+>,+��#�u�-Y�1�Rt��{j��6(�s���1d����F1�[`R�+�g��=ϟ>��,%��d���`�	y���?G[~����x0\rsĖ�틨Qt�G��?05��n~}?���|�k]�9W�]�k���d?��8*`�|!_���3-g����,���??\'���p��b���A�6M!?��B��^x7\'�jkB�����X%������Q�������k��k�\Z�`�x�ף)f�]����l�4q�E\n�\nͲ��*E�K�x�ӧQ?��������OY/?�?~���@�:���ධ��B\'���\n��̔dKC^�(�6ތ)�}��V�*���^|���?�2� ������+����?�p�o-:!>J?J��j��M�eT�K\n�\\l&��)_Ag�+?e*h$�d���L��)֨�~��^���\'�0��2�[j�J��o�\'���.W��1J��?��=��Z?�y<��I����m賡7PN/X?����2��Ms),�|�W�C��0�+����������k��ǃ�b:X�Ί��r�Ȥ}�3�q.ET���Wo)[W��F�B��ow�?:\nnGQ������3q�Nk;hjdW>�A��z��i}��=��pO\ne,R?xs�?��g*�d��&�^Qh���)�v�(���\nǄ��6o�i$=\rIR)���?~ꎿ��\rEbp��8K�5��,�6e@5�����>��b�T�5��xL�QV�*��4v|ڻ9h�fe:��Xv�9����Hu�I�שͨ|��G�-�2�DV��Z4I`K�g$�j�� �]����q蕨=�S\0�v!l��hݱ)��)��V��:���X��h{f�V��:\"��\Z�?ڲ!�\\�#��FL\Zg�O��a.�$�=�x�*��է����D#+��{�td?�wM@~�A�A��]�ݨ�~Fsǟ���(�쬚�c�&$�ڂ�_�CW�ե&�`�Sv&�k��T��w�C���躊�\"znwl�a�q5����,�b�JV����R�\"qL�E?���觜��BׇVԗΈ�p2.�Vv�f�?Q)����Kj�Q/&+\"�Ƶ�w9iݲ�No\"(�z��D?W�X̑K:����P���1̰*�y��H��������\r�\"R�t\n�a|�/��k�fk�Y�\r�CK�/~Te�_��dQ���ă/4��*�M��\\�*2R^��2�\0Q��\n)�F|�4 �Wi�o7r������;<�x��tR�t��is��;�߾p��d�6�h�s�	�}t\"ٳ\nZ��~���\'��~�o�����������ϊĔ�ka�F>�v�y�=_�/t�����河(3��]����6��*���$�O\'���.y���Sb`�i�Sϡ*Q?%��������`��Ylfs�3ȕ���¯./�e\\�RC���&�|F�����?�[a҉�ܨ�k?�N���]�?�馡������k�7}n�j��u[�?B����?,��?6�I��\0Wg�戜g��E����|ݩ�T�;Z\Zti���K��郯W��Y���h�TE����x�jeR�;��5��_�\"�H��/R���m#�%iӎ��G���V�[����?w|穤^=~�S��eVM��Ơ?��դ+]����#���.��:w,ݻ_5�p�ku3��Ǔuͱ�^��wA���q�|���Ox.��=�\'�Yq(�qj��V�����������<#!V�?^>�Q���8	�����,N]uOy��?�<�4��-�b�\r�?D�T@mvl%��i��2������w��_�����\n_?7o���d��߱)ua]�0ߪm*�c�m��P���S�&\n�+=�A�>P����G�3(�/��k��Eg�Dן�6R�;�l1j�q��2�{Uғ�x�6��;�Z�/��|�v�2����5�JLT�N�Dn�,u�}Q��}�i�����V�i.�\ZOyb���G-�zk�)���\r)��>��:8��i9�z͂ �MQB=��@W�.?zc����9!����Ha�/񬓎.t�~�f��|Qz�#�>��6���6|	�m\0:��r.���K�7aO#^��*�gǜE�oje���p0�!��Sy���?HxG���t��)|�h��5E�p�rnŔQЊ�H�\\�T��#��y�^�L���?����e�>>}՛ZfeVi`�j���\n��M�%��c��G�����T�&C&��#X��\"?V�=m��T��u�Th#o+O�}��\'����*�-t?�O/.h��5R�0�9�^��Z\'��!�Ϊ��&���>��WfY+V��\n�t��Y��̄Ez�ūG�<7����X}t�q��ظ�?���n��<���#q�U��z�4�\0��5h�P��2!�yw!(8�p�+gнY�q3���$�i-�Go9�ETs�:hD��{5�G���E��:��9�E���y�:����U�k�_�/\Z6x��{ɕE�17]�u�F\Z��|_§_j|?���f|$��]��w^�M�ū�4ϊ�nMt�����>��O�PGMNX1l\r��L921>��ۭ^\\*?\Z��?�v�?<s�(����	.4���[�X� _��Ȧ��L�:&�R��%��\ZH�g��?�+���]EE�T{:�W?T�u�?E�6�O<��C>����Ɋ֒�]I�a5��W+�t��Y�Z0I�&�D�C��,<�^x�X��\\뤼b���J�w��aO?�O��:��]?�?�ɋ˃��]H��5y��ͤ:�8�¼+F�oM^���u�gχ�C�(�M�S?}j��a<��O�t�N�cI��xK?�)�A\r�:Z�uS�������h�\\��oa��F��??��,Vkl��#�/�]Rs8�T��}9߃����><���:��F	=c90������K�<�?*KG�%�n5*u��`_x���y6P��C���*ƣ꙰7GI?��0+?�m�2��rQ-�I�&�~iS���ǵ,�]O]fH�][r���|�<���$E����;�!�?��nĨdxc�/.x�5ĭ+WN��d���:}s��J?�zV��{��_����[���/R??M�Nn~/.m;\\s�X\0^�G3a?&j8�����?���5Z??\n���%�YGVB2G��s��#Ѕs�̦*Xʞ=��)�٘,L�7|�I��h6K��t�D\nJ���waW�\r�*])��|�v���c��z-?7Ւ��{D_N7�p�q�U��C=X�2�Z��_�,Z��}K�tS��@K}\0�}f�\Zqk�K�۬�P|��G���\n�?�uj1:?���n8s��!��B|�����ξ\"�e�L����P�\"cBZ;�OQ�7���W��:e��\\6`NL��e�hr5i�_�ՙ������?a����G?�6IIZ�W�������G�NC\" ?�o�������!kU�?k5�?3�Z�ӻ����z�@�mV�:�����t\'\n?x;P4rQ!7�+�6�\0�B9Iw��N�J_����zV�yfp��J�.o�������7�ʪ,	\'�9h3��\nI��z&�����}���s���N2މ��3	E���BB�vK|�g�a>���S��-?��H<�2i��D���`]��b�^\n�*)9gC�0:Q\'��/��f�Ggc��R�|�\'�]�af)rb\'�f�e�F���(ʉ�a�+;c�\"\n��*�⢃��*�q?eX��!�\n�*�;)ʚ�m�%;����KO)�6Q���8���\'t2�ݒK�I�\0�?��.Km~?�&�����&w.YE�?Q�G�y*�i�����%��z��S�y��⛈��f�\Zǜ�V��ʠ��X�a>7c�ML��;��ėno�λW��\n��_ș=+�#L����	՜�{���=֫��n�R}�lxI�N���%ݵB�tt�S�ܞ���\'~�Oq)?��m8xɠ}O��\"l+��\'�p0z��]��#����1P�f���g]��$�\rʆ�Ǹ��%i�(�x�Eb�rXI�dR�!G����i�?K6;�r����է�MAtf[AU)��7fA� ]�W��&?��?��zC���Z��r�?�.����6?|n?��ظ��l�EѶ��Ոo�:�_�\rE��Y�j�:W����J/d�K�/�υ�?^�ʘآEϱ>�8~�>�ޢ�T�%�Y�2W|�\ng�f��[�h��\n6N��ݦ�#\nԪz,�S)��ƭ\\A]Qg6�Qai_HI��HOU1K�Ic���D��*d�@��x#�lt��U�&&z�x޿Qg��ۥ�Ƌ{�u��|�;W9z4Nh����#�gz����\\E��F�)o׫���P�7��$��L�$����_)^m�ڸ�5�h�1u�?���b�P�7�̢l��˃�7I�V�U�x�V�~�n��|�b��.��������w�L���\"V4 �`?�1j=O�:��\n9{n������|���_w�h,� �^�yݕ�#p7��#��\'�×��?�-DF�i���Q�?[\'7���a��y�+5�%�UG/�FP��@k�1�6�/�p����J�GM���~�\\c0�h�V�̗�vٰl��Q!��O:��7$(��m?���ޘFh瘷?1�˔�kDI���i&��*��u:�ԕ\Z2?f�ǘs}�h\'��ޚhR_����U�%�#���Ck|�|�E�bz��)��vB���!�v�K�k]��Z��\rC�O*x҃$Mo��Ǘ����V�<��?��k�d�u;_х;��5b-�9/�GM���N���]_��&ilJ��y����A.䇵�G[!��?n_G���|��\'�4����+���Cd�_�׹J�C��s�f���<2d�٢+oژ)�]��w�?���%�*ͤ���^�Ic|z_���?��u6���Y���Y/hf��\r�o���h8H����v�f�)9�Z��\'z�V�����zGku�4Z�ۡE���\"�?�ϱ-�\nu\Zѳҳ?sz\"�����kM������1�|Ǡ�x�>�i���F�K&I���T�S}��[���J���= �/��~RR��\\�u�������&���}BG�Ub޸�5TF��j��4���<⦗Zhx*���??׹��/��ܠU1]˨��ﲇ������hZ(�_inpp�\\�Siֿ��hJ���E�.K��O�\'���|���NR������.)�o�A]A*�믙��Ф�J�o�Wi�v0ܸ��~������A��l��N��O��k�R��k��.VJ��T$s�\0��`/Iz�F2�0�ac�qb;�vM�ijsS?���������<��̢���o(�2	]������^ORծ���~��	o��	&�CZ_��]��+/u�p�U�T�!t_o�0��(���OA?��2�d����de�Ɔ���e��V}�B��(��?Ѽ�=ȋ?$�U`p��bS&��ϗ]	Q�h����_[����D4+���ѹ}6�U*�uCZO��g-�����Ovy����_�Oƾ|`�[���Y����ю�ͮ\n�-�O��_V.�\n��H<E]�$�z��N�x�S�^WsT?|4���*AGCP����T�k�����Ȟ+t>`�OiWV�k?be����|��C����ț�8y%��\\�]�����hx��h��m\"���Y�]z���:8���]Z�����Z}�(��vK�{���?�ȣ����E_����(��,O�q2�y�l���r�󄃱�4��T�+h��_,�/O�@��_zR�M��0�ƴH��\nU}�9�����LՄM�?��\0!u�c1�Ngܽ]�}��A�?C�3Ns\'��?$��*�-�e�I�\n��h�\r��m�i>!Z̿��4�����aX��,C�\r�P2ؾm�cRQ��«�|Y\"1b<G�iuAg�J�\r�-\Z���?�����\nO7�D>.4�̊	��=��%:�xc覕�-��I���W�f�?���o\";?)	�a��=H��,q�WX\\�}S�k{��`ʇ�iQx)I+�NS�L�3��������i$c-ɸ��V�fI���(\"<��m��#��T��#/Un���ۨ�B�̈�d\\�[��5��4~-0���?�Kn���B/vn��@���ך�����q\'�,6��,�ӦO�K��4�=�?\rJ�1�?���6���Tͺ��\\T�sd��R?e�-�ҲM/~}hSBsscu��nC����£�Rs��:����~�U?<�����,����I�?��n�ϩ�Ь�T�R�G���LD�kv�D?�?u�I��A��.*j����J9:��[T?u�]>�:OJ�bLm �8������Q�g��C�9a?j�S|\r�0��w��/wj����tڠ��P�Z�p�H�	kq��5�ל�4?K<�����f5[��������z�F�\\��S}�%�j�\0QHY�]WI�T�@��>^�N���N?N�>��BO6���^���.�������7�������Aee��ڽߕ���a�ceg��M^MV:����J��W�N**��h{7�\Zn�Ù�  _\'��[zT\\�m�8|F1&\n����]�\nF	��\n܈��VQD�N�1�s8�	�N���je�7b�<�w�S���_�l^TZM�h\ZiHj �x��p�?!��lY��բIS?P?X\Zϒ;K��5�����ߚX < �=�a�K;OCf��Ң��t�T���7�2���=%Zd��d�r�H�b\rz�S]�zZk#�9��_�^DP�TP��=��R\\t�.�z7s�o���\n�\'���?U\"k?տ�)t\'4q�`wDo�,?E\'�\0�^p�A�1Q���_H���E3$[QM� �\'��lMP�,���3u��j�����d��=�ͧ����r��%H�)NIb��8�`X��G��?�4�M��#�C�,2���E�ܕ$j��(yB2��8����L�k4/A�?(��1�����a��rgU�Dk�e�+��c.�痬�]���C�����H6b��h�#��k?�\ZC]zs�`l�3�vl��a6��#14ZaS��|�zނ=zs�����u��-ȅ���Qk��&��Y��L?|�U�>�����d߃O�Y���+A?%�X�o��\n�K�#ǚI�8\n�\"Qw�_F��=����9�Q:/L�F�\n��Ɵ{�ꛬ��L�։��\\�󄼩U�dcV�+«����~��?\"k�@��Z<�\'?QI�ә�r��7�)��HȰ��Qp?ڱ	��a�q�LZ�\'H����B��K�?y�7��L��$O	�~?xA�93��D�Z^eA\0�~��jO@lѴe#�}0�#�\'�oQ?����%����?�T�U&��ΆD�.�WK6ke<a�z�,�j�h�lEN�nSQpeJ_?�!\\(?�R�E������z:��}��U��A��/C��D7�Qi���E���V|�{��?���� -Zq9�jh�����1ff�FH8t�	�Dnv�>sD0��~>�*����V�mɜ�?gC�p=6>[Wp�)U�����?��cU�)�!�\r:�\\Ea�ۜ�����#��C�E/�e��}�z�|8�@���&]Vm<��.ӊ��Y��f��y�*�IH{?��M�\r2�?�v�ɿ���L��xs%3��\r?�z�q���0x�&?�#̪-l�q�듷\ZE�{g���n1�7���p�����G��݌�\Zr�[*�Br,|���vTe?�?N2?#�qi�3�}��b.�?��?<7��*�`O4~���:{��7\"<y��߱�[����}c�6~��$���wkv�,���?�Y�9!�>WCר8E��MNr�jT��$�QOr��J�0��F�>_D���?�I?ʹ�u͇��l�숶��o��ڜ8�䱰g$Q`5��2�>}��z�?��UC^�#3X[�~ F-2^X7�x�����Ig�D(���.�w&E���8/��(��X?���-GB���k�?���ϦOm��~p����u�2Ӳ��m���S�/o�tTk2��6f�RSt|ۄ����6űu\nyW[f),���;_�5�?H�Y�xs=�Cޚ?@���:�`]�G�vKEC.%��*��7s�2���\0u�{�?CVgy�V#_ʯ)<@˿]CMy����{�7?$!��w�r���۪_�������oE�>�\\o���*�7a�r �I��G�,X@�G\Zq3v�����,\"�_?Y��*�\\O+�����zV�W�L��%�/�3�����F6�NU\\E_�Ϲ.��|g�ĵ���\"�e�|O�ţ<v�J�F�[&zy�����7��\\�lj�-�3G�	��.ؠ���A�g�?s�?|A&��fy�9��е:_n�g-0;��< Jz�p�9wbn��p���|J$����<.��ԩ?���W�+-?}�V��\Z��jXN�j;�����3pSq�~��͗�*�Ւ뮒�w�RiS�L��2;� )s�ùG.Qw5�[ۼ_��<�j�>���	͕�)�y(��-�?�˻�*��/i.lzG��\n|�~��] U���V�>��4vI�T�G�ڎ�(Ϻ��Z����Q+��ٵ�^��mPf��Qm)�+�z)�8�\r�9�l�^���z���?���4�5:����jڷc��~��k�b����OٔO%��%��%V��._R45���y���[��+��y�������?Q���(WY	f��5����|;��-��C�>�9�����fA��;Έ�7��\Z\n6\"t+c���d�Ln�%MP��\nן~[�s�?�t�?�A������4����Q5�x����N�r�f�KT;�}A��ǋ�SI^^J�ӓ�4^�G�����Y���SƢr5�Di�?}SKJS?R��3?kٴ08�w�!6�֣�Y�S����d�N�ҷ�s��\\\'��ѯt���M���	f�6�?o�]����`��y�\"�L4ё���?/xƴ\r���\'9���Hi��qb��~��g���c�&uh�MJ�\\W��@���I׌l�\Z��ƺ�y~pN�����9�f��-�R?f���%�\'/VZ�G�<(S��dk�1����LL�~Uח1V��a_�9�Ƭ��tF�E��(�Y�*��y��7�k�?���9��#��}9[\'��<{7��P`�e]�\'�p?���hL�sA�xS�X�V���;���cul\Z_�|Ւ�,ph|��XzWJy�TZY�U���W|��l+�N?����]��ɲ�s\r\'K]��&y��P�j�~P��MTWop�8�ǲ�}�|M��J�m��Q዗��Cj�d��Z��2O�Ծ�Wy]ۀB\'VW\\�=����<�}�```8Y�Y>���AR�oy�\\���]gz��\\��Bi���o\n�;-��9̖�-��Ô�o^d�#�\r�\0�rg<>���P45ʯ:�[�q��a3W���r����o����|g��=ٴ\0.��|P���{-M��E޳:U�Ɏ!T�i����o%j�\\B�?���_�R�JI���׭�c��z��%�3��e?oJЫ�S)2�?>�RN%��S�D(��\"6���?Ō�j�O���7�?m�P�@݈~��Q����_?;֗�\r#~l/�j}?���:h�Y=G��Iܣ�%�D	�?>�K?�ßO�?�͗)�U�L,$Z��s���������m0�v~w�s�H�l��\n}:�DV�Ȩ�I¨���Mԓ5��\n��n����	��?Z,���ca��+�Ux�\r3�o��J��j�q�u�O�7Qģ���Fc˾tYaʈ��ĕױEj?��3+\"�E�n�!\"Zkp��Kb��\n�U����iD;Zh�y�%_ex)��N��v9�?���a������U����LD�ODQ�\'b��0/��!x5:�_�f9��M�ZN�����	�5|��Y�c���e���?���G����7?��@�zy�HJ?�rڙ�O�Ƈ�����`^]??�/��*�u[���k+Ίo��\"���ekpn�F(���{�r��6E�(\r&��*x���v#~a�����r>���yp��R��.�\n{\r�8�+z�?���:�����{F	�o�<�!w%�b�,��V���mƗ�,ZHՋ��:�lN�ͳ��v\"һ��V?��RM]MT�x` Z�fls��4I�U����D������s��;sIΗ{º��Z��a�k=/�k�_�hP:�f�=өU�R�}�z���A�D:���\'UwL?a8����u���&M#���?2��4��J�����ז��2�\0�?��M�:��7����o�.-�x��n��Vf(������0�\"ig^a,�X��4�X�Z�O�b���X�M��M<���*)-��Vy�������1��Ih�q�8��3s���n<_�����^��ջ\"`p��Јeϩ�x.����m8괮�HU��S���P^=���J���?V��*?~1�U����E�Ea�!r�!#g���E���|-U�^��q���孳�������r��x-Wi9BH����F���%|�>�������\"�T-<Oѵk/�Pz�\\�o�%<9�I��H���+�{GlV//�y�$�?7�\\�ѶG�Lt�Fd�;8?�x���A��J��5H�i�YC����m^)���M�C>ݤ{�k�m<�~UԱO~�ɒީ�?A?@-�P�b#��]��Z�z_<u��Ⴍٛ��4%\'E�>���6�M�s�Q_=��x6�%)�>X�Z�͕u�8t/�U�I��PS&�\'�ԅ�<�\nHq�C�×������T�?�%ST7�220��>n^�n����.���\'u�x��j?���ț(v������<��mA��#_����硸��z?�_���,:?�F���\n�?$Xмi{h�n@��Y^X���i=�֪�H}��X��ۀ	6��W8/���\Z?���+���\r��u?XES�(B򃹒��:�9��:�NҒ\n��o2=An:�����|��^���~�e��c��1�0�����O��%��lF��,�!��z��g�w9�q�[���/{�*f�zy�@�������.�!:+#���2���7(������B����r�?��t�*m�As�o�١�rw���6��?�	ƒAi��y�I��j�\"?�\Z_�(��]���y;]\'��P�x�ݤ���\Z�9��k:����)�<�@�Gf���kt/js?���:3��l�\\�D)<U��ʇ`�U�`��\Z�ҕM96��?P����V������Q\"f���9y?��\'������MY���>�?7<�(�kC��\'�}�P���l��?:2˧�K`�0�٫�d�(t�a|6��!\"�/g/��E�Px�9]R?j0<\'����}[�u�,��i��=C�%��T�?�ɮ��,z�b��ۻ:Qd�9u	�J��[��f�qR�A[�5:{�RǞ�z*�r��.�m\'�/I�9?(�7��6���ғ@��4�\rp�<�Q�k�G#�h�N+���?�.Ŀ��58_�(jr�FƯ�}+%�/h�(�����l�f�,�X���`fEC�F�I�s�Ⱥϰ<��rz@�u\"��`�?2�(W��/w�4�\\\\�O>|y����u�h3������;��*4�h�-:7یFb1�?2zn�����#\Z�^!K�z#, �]ըuK2��nz�40$����[�Ƚ���\\����l���Q�+����\"���̤+sYR�R�%�h0E\'F�@>�~\'�?���e��%��k\'�Kj5E�4n\'֯{�����z�����G�Y)Ō2WC[��t�9K��g�\\aU=��٥~F���X��Ti �\0E�s�]�om�~��N�8��\Z�մ�\Z�\\��s=�~;\\�q�7���&����3�ꕡ���üݯ?��@?��E�|9Y[qч��e\Z�Z�IG�Z$�8��Ÿr�|U�1�Vɋ�i���\\3o>&s��.�u[G�!C���M��e�b���cV����m���R:��l��.ȱ�n(ù�t�-�J-�,��t���?3]����4���\\����iފ�6f�I��?��k{����]S�*��<�u?��^�?1j!UrQ�/��\n�\rV˔W��h�UG�e�8%�7��U��&V��Q���>Ki�:ƚK�\n<8�$j��u�Td���Q���I��c֑؛g���\'���5?3���_��:V(��R��;�Gz�2957ؔ�TY��m�v��F�&1_��s�D?OYJ��8D��TJ)�b��XB�ϙ����o���94?��Wo���A�\\���C?���}�V�3�ư���t��e�g�P;�4yb��+:aN�a�̯�����{;�Vv����)��X���M}����f���oK�Z�k���&Ux������(&/�:q��YKۘ\'9�?�;�I�?WCr5���F���\n?a�G�����O�u\r8���1���8J\n/�H��.\'���ߙ8KS4M���h�������K3SOF����,�-Ҿ+^��}Ҽ�j�u����м�C#����?�WI���O��HR?e�t��#^h�y~_V���Ŕ�-t,���L�HE�5���F��1��F��R�3����Ta��Y�u��;�ƌbQi��l�l��!2��c�:?�����?6�R�21X�G2�Ť�\\�Sg�2�E���?��-qyB��v\\�,\'첳1CX��w$�� ��&25U��i|T�Dy?N\'�o4.���h���ムk�l����O{»�^7uw�q��?jҊ6�W!g�f!	�[�o�f\'{��;��k��sy�i��g�z(���(�3��e*�֓�?D�ݲ�?=}��?c�ɛ��/J\ZH4��?l��2Q����Ŝ�xh�g���43����J�|��=ub���,�1���ҟD�8�習��@{�W��t�!�%#�x��B�\"�������u�?R.�I7�&:��䳳�K촧\r�7��?đ��E\Z%�^�5��?v�:���N�ަ���;�(6m��\"����S���v�uK�͔�?���:VLfWQ??=r�;;�q����+~��)n�f�/�����.kS�?\n�t�k~���?2=0����swX|Ʈ����`�����Aj�$�?iL,X��3�\Z�0��c��%�Efj��Mۊ�z�p�C]U���%䶀O�|�?�Oξ�4k�˙*��>�h�?h��ცR0�	;��ΊAg��wtB�t�v�����\"�N�η����U�Z���צCPE����\Z�#�3�䈥�W�,Z�\Zm/T�����λ��\n���z��U�4j1�?�2Kg�:�>�&�HڌJ �%1�<�I�)�2�<�<odL�$�PJ?�ʋ�V�s�\\�?=ӫ�j\"����%;�>�\"तf�\0�hBo�؟��徽}y�\r�v�ʳ�p1�x.s�|d=��Eϴ��!�6��km#lO�^�y�o·��u�+�3t��EW�K�PU�?�����Ԭ\"s��ЪS����\0\n7יݔd\r�@Vɩ3�]h�{j:Gd������{���V5r�k���}B9�᭭�	\"�3u���\"�n��a9�<I�қs���\\�oS��֤&wK.f��|��מ���$c?:m�YreAڒ&��#��O�	,�C���`�n����s]S�=��\"�7/��^:t�\\!q�:�������F���1F�r�2T��	z��[�i�?��\\��;����1�\n$�۸9@Jw�PӬSv9�t�tJI�驨Ī�{��\Z�g��Wյ3���$j��;,��\n0?K����?BG�?r�m�#(Oz\"K���|�F\0ny�U?�\ZA�M�˜��a�t�*.���I�E=Bʦ^*�͑�ŰB\'U1c���0� ���>��-��\0�6�-��Z���2o�in�S�W}c��l9����ViU1��+lMr���e���\'�\\?�\0������r��F����3��P�?�s\'�iȅ.�q$?V2Pq��I7�LS�*+���|p[��s�P,ʘ�?�Wy:/����hr�8���a�ߎ�I�We͟T�&/T��q >��GUef?�����S���P��h�f*k�˩T�k�G֒�E.�V��ɢ�ެ�����={�Aէ�t�!�{?�T�F^Ɉ�^-4u�?�z�Պ�\0�a���s�)������Y��?$Oi�|�bz|R\Z��E�A郀�U��\0&Zʇ�\"\'f��O{F8�`|�yX��|x�p���nY<؆?2ArT��p�����?o7/�	�g���%��Sq?Ǉ��\"��X؇1jt�iM�,��߯˟ɒ���W<S�TTo������^I�B��D.������7�\r���\\��1�R��y4��N\ZV�i>޵컯���[\\H������i�(���L�bh�\n���&Vl$����.?IGƬt��&�[<�^3>?K]��ա�n}Z�WE�eM!g��\n�?L()�Ks\'+w�8��s�)J=wg8�}Q?�c5�|\0b����ٗ��Z��X�n7�\Z_�?�O|�nv)����	�\"$�*�ѻ��st�R�6ʑ�n<�ԧ�?k�wf֮4�-S\'����?����ݫ^��V��?�,F�g��?��\ZE�&��ڵ�?\n28[����w�f�R�~�Q��I�(`И|�X��_��0�h�_(p��6�}�^\'C\\4#A~�?֌0� ]�X�7f��8Y\n�ݙo?A�]I5C/$?���(}|�.7b��YE�\n2����1�!f���͊\"D���D_XG���J�:��ho<?�?\Z_;{?�Ͱ�V��/NQ�ru��Cmt���kl�w��?���P�I�S�}��g[�!���k%�2xg�%�x.҅�ԛK��9;���6�+\Zw�ΑcgR��syurfԤly�:�r��ٷ^g9	i�&S�u��=��6���z�#��v�s��F]ɧiJ��<H�Z�A����E�,7��r�0?r}D��;8�*K��U���򰣔?C�3¢�-F\\K�(:��Y&��=J�y!���B*�+\'R��p)���G�:���Ix�W;Ԉ�\r��.�=��	�ef\"k^�MEsb�<J�1�A�Ty��]�pє��l|h��S(m�v\"�æ��ފ�<��s٫��1�ԥ��	d��C=�(��J��`���cj�t�REɜ�q\Z\"-��4��\n�?W&�\n?eh?�ړ��FG�\ZK9�-d�(���h+�P�KS��������x-��0�h3����	U�r���T|�B�\n��攀��7�H:�_?��X=�hR�K�u���X��r���{>eC��/J��?2o���\'�JJ������\"�[���z����+J������J�:�������g�?u�yfT���8�*�?q��(�@4��8!�=z��NDʇ`����Vd�N��I!��JSFn�cV�7�Ke##�.[��1A>��Z����^�w��W��/$^/8$,A(�\Z��ͺ�u��r��sp���]c�x���7�d��?4`.#���i��o�\n9m7�4����b}`r���	`I�K�����qڶ�i��,��##>yY��,������|D�u�W�d�ؼB.��sL�7�݆��6\Z4:�ft�d�� �\r��+ZC)�7y���]�?q�����\'M������GK\0�?�NDe��8OS|\\/3��~����ñ��|^���s5ί|�W�?Sx���um�g�Nu\":3U�:ɨq�D��j�����B��̨Q�jW�X+^��t^p~�ߤ$�����M�ql���N�!+\\B��|���G �5���7\'At/UVU052��V<^{?�:�0gA\nS{\'3�����Es�r�Т�rO�U\"ba�ó;7O)�JC��P�?�q�Z�Rr�r�0�O��͋Tj�24������W����^�%	\"?�4˯������=?ԱM�>|^��w�@?L�?sK�����+9)�\Zp�Yֈ?o%=L($i9}R���M���ٷ�Z��8���05�F��(\Z?����\'���_8��� ;�U�r�VцT\"����q+���S+2�\n�z�j]�/$$�[�[�h�����?��EhZ]x�?�8#�kC��/�=�&��/�?��]�qQ�P��*�\r�`�L�cSU�ކ\\.�\0�m|��S?t�K?/��&-��u*g\nV�ۿU ˭�p|���^K�_�Eɠ�\\;B7�QT�Y$@S���\\�]wm\\;��(��us�G]�?��sB�U�\n�.q�\Z��L6��?y�Ot���m�����X�*D؄��s�Y��-���hJμ�Y��m��-L	?�8����v�+?⮫�p�Nr�|C�Zc<Dx4vg��:�i&�?�v�Y�~��w�QG ��ba9�7�q|S_b?��y���v��;m���湡��=��h5�����Gi���0�x��mQe\\?L�s�p���?�W/X����Ih/Fn�~{sEYK%�����IC?�眗A?�jX�A&�Y�����A�`��	[�ֻ2*pb�.��q���@���h��ac�QC�U�КE����_��Rz�x}\0\n/.:�g���oT�b\nZ�!(E?E�����N�3y���LD\0����`x���U����nN����sQ�O�Y��n;{�/?����o���uH��LD\"75J�����[w����B������\"����iҦ����A��γ\\J��ǿ�v�B��ϋ?LR?6v��yN=�\Z�\'O��}?S%�\n����5#�xf�x��N�Y\0�o758�\r�xY>ҩ��GX!_M��\n�!���ꨦ��Q�?��Es��w�Qg�g��f*�G�cZP��\"�1˧(�	8��\n�pd��5��$��m��?4��`.�W��d갅ӴD������8����������\'Y��i�����o>�d���%ʳ�|q|����x?~��k�}Qw����$K<�@��c�_���HX�?��U���0\"\'�Ltx�?���y3���g�P�MP�(C�?��du09�ǲ�b�n#/˶Ĺ���0i�-�8�|�g��Hܒ^n��*�]H���ڪ���#\\��z�/�p:9}B��I��7aT��m�De��l��3�d��!o(���,�rQ��!D�;��.��?�[�<Ge��W��?02��l�*o�B,H�#Iʎ����������]�$z]s��x%��7&G��\rKwp�W%�\"�?������ƪ٦.�S6�b�.��n\Z�h�?�Pj6��1 Nr�N\\�mt\'a.HN�+�+�m?�{�*F���_�=$͞�yD[E|uؤ%PJ��Siێ��?�$�7%{	&��QVCiD��*AL��\nc��/]9�=�������Ww˲a^ZB�\'���4���s׎�Q�n�~�t�~���\n)??��w8EM@��\"\"�7��m_Fao�H��̗ô2N^�Xn�tЗ=�\\��wA֦����Ӷ�?)7�W�/s1 xMC\nM�_���#hn�m�c�]?���/Saᢋ�UY>����#~il���h�~G���O�Tθþ�Mk�ir���Gp��t��?k	D��#�_w�?W_iTPׇ��՗?��bd65�3��g�>?����\"�.9��?N�H���ެ�8qN&E�\'��2\n0�L�KR�@�T�OF7Nr�EW�Y�9Z�U�HEl��\'�9As�����5xi��8K�:&ǵ��ؘΘ?|��?����p�o��C���F�u&vwiA�$ϕQ�4��k({�\'�&]�(i>��\ro��.�X�y���v�����i6�a|D�*�З�a�?����Y�47#�Q�P*�\\���+��E�~�`���~�?h;�#c<��S�\"�y ����)쾉��;S�)+�Q]�-�eG��{���١O�7��9��R$��v�H���@�f�)G�/�K��pU�TzT��d�;R���~\n�:�\'#�5�s�W��mEy�)4Ӆzc���m�řo��%�?\Z�H�O!Դ��?��|;�S�p\"����焹̣0�Q��1�f/�ʓ�~�*˭�y�1��k�!�:d�k�je��׳ƨJ�T�2	<|�����>7�&�psH\Zn��#nz,�߯�\"	�H��4_8;*M|�V���9����[oA��Z�?7P0� ����[W>yD�Ax8����t+�����8wnz~���ё%f�?�Bl�q��|�zG�ҫ�(�6K��K0���T����\n�9F>o�{�͗�z�o�p�Xz�<���[�Ϸ�?C���^�t��-���5�K��I���R��F�\\����~-��+�\0Yc?[$M�]HAtѕsVBV���uC����)ۮH�7|Mf\n�.����?>���JU�s����k�J���@�î��+��E��3��-s��S\ZV\0s�\0��J�fmՉ�!�	gτl-kzܽ�3�:�^�u�?:Ż�Դ��5�a��`�\n0�5��H���K���{�_\'	켻�0��O\n.6P��M|=2L�C��|�\n�yGs:z�\Z;�a���K�ļX��v�x��~�ⵤ/~Og{k�n,PeD��sC��g=���J߿l���s`�x{�?��?���9���[f8�X�8͖�.�-X��?������.)ur(�O]e?><�p!����Yc�ڣ�9>]-���2R{�����l�0�/AYc^��S�N��[��eM7m\rqk��!�:ߡo~_�q�J԰��B��SO����@\"�t�MnKlqz�_SM3a?D��r�8��ȚF��ųdE��� ]/���Qw27�W���Ůs�#���L��To�>��h�������$�B8�����fd�R�Y|b���47�?GG�\Z��\0x9ȣ#�@e�}G�4;��M}�/gSo���T��;�c��=ݕ���t	��2����a�M�ډ@]&<��Pl�\0t1�G����g�D_IHD��i��k<�e���9*�<�?�a9{��p㩱vo�<�L�a??D�\r�\'�L�?7MH�:��)X_2*5�[��Q�w��IL��2s�4�?����-��<:�����Bwi���G֟��?C�=ŉ��^oȮR�\r&T�Lde6vYt���?�mR�X�*?������Z��)\n�b? #QB5����?L�^�[<N�$�2p��1�	\\t�T�\"1x�\n_���\'�s���L2�pQ�K(�稖�i?�F�Jn��RԶj���/w�ku�S�uC�7?(�bo�#���Do��go�x����`�b%/_:�x��*�C��;:��t�Q�L�~� s�f����NM:�ܘ(�3����);��N�=��b>g�\0Iq����{�\\Mh��ϸf�o.\n7=W�K����H@s}�4k�s���pd�,�Ӊ?�[at#���[xz���� �c����o���]�&���<�?b-���oc&���ͮ;�ٳ[3c�R�V!��C��]�}���?x:	,B���|�dX�z�J\"c�����Y	އAr�.�!��;G���W.C�����v���v��}��2!\\�1}���^DN��ܤ��?ӹ�e�i!y߮Ҽ����W6OT���Tl}.��|y���ɱ�b��D\\�����X�h�����������?�v&�Vk����?Ҍ�?h_#�(�>��D���W]?����sF����9/[z\r� ?A4?n�c�M{\"?���ܩ`0��W.&#{�\"��Ε�d`?H��D��|;xۘ{��7�����g?���m�Dƨ�?)�Ҳ��ز���qU�c?�z#<z�6	mFa<�.��A~�%=ѕ��W�����U?�	�\"�C45)���me�|�t2X����z\0d�Fh0�g�u������	yxR�1���K�?H��G���O?��=5WE����5R[�^\"�.�.Li�D��e�OE�f7��9n�o]�?�`��f�Q���1���]j;�B�P�=I��y�?�z�k�Ң\"���c�m�aa�!9۳q�o|r�Bh��{/�g)����X}�qĸ��H\Z����r������ҭG0�܅�kwJ���:3���7�+���z֒VԷ�E#��SF\r�nI�|/S^��*��\nG���sd�5]�`9�QI?)�B�Ũ�:ZS}�5�Y��Ѷ�?2x\\�s�\'�e���ʹ��TH܄��	�!��sȑ�)ĥ\"9�6��lC�9�i���Rȗt^I7.�DULF�_�a|����ϛ���нʂd��S�?c�\rR�Nf�	?ɰ!<j����D�Jc���j�M\Z>�U?R57{f�+Ƴ���Ua(i���\'jTپ�eQ�⢮d0��;|�O�O?��8K���#�M���I��t���ƅ�=o|^��m����sTf�]�6�j�1?P���+ڪ�:ChF������O��-B��o�OΚ��y�Q�t��Hıg�եE��˾a�Y�S��R�����I�����G�\\�LN�:\\�y�U�_Й��<�ݓ찈�1���#�R�N���i�\Z���D�5�}YI���S� �P���%�ݧ#�f��/��mT�̯�k�)�z� ������$��|C��6՚2PRy��IA���S�9J��1U�[�X7j<�}�q��ި��Lj�\'M��RK��Jof�?x�\'i�����t��f�������<�?fX�bIhw�p�`?]tRT��(&w�h�m/�9� ވ�a����]��QI�	�W�`��)�!rI�W�6u7��p�5w<�i1��u�����Bw����/��A�I���D�pl�9��j^��i���LH�N��Q��C��?���?�o�X>��h�N�����2����\0/�����j}\rb�Q4M��gJ���j	WK/�?.W����VS��K�p�\"�U�t%~gj�{�ܱU�aZ??����u\\v?�VKJ�n����k\r�%���������ߕ�o\ZVVnͅ���s���28�a�j���n$���5_��\\���8�D?�t^ZWW�� �sd�H�?�37G;���?ґ\Z%	�2Az�]vJRQG\Z�WS2�uelmj%8������\n���_�LPz\\.�,yVqsȷ5:P;���pbѹ���+e?T�U�c��,o2�Z֧�sC�8�޼�s$��Ї�\Z��ӰSEYyB7�7?x��x�Ĉ�ܠB\"����[*�9\'O��zS@E��.]�C�zT�����>��*�)�O\n${�T[��^�)�0\"�a\"Z�0���5Wҡk0t�F�yǋ��t�%�1��ʹ�?kb��)M<�ζ\"b_����xp98��uX)�i����f�����p?����;|���cs���,�R���n�ϰ^�2օ�<\r���x&�4@POrq ��\'?��#>�����V)�k�HzJ��~���[0H���iL\\�����f78S����p~�߷�� ŷ�}�Ϋ���jN3�s�W�?��oQ|�A��e��r�[=௣u\'�?<\Z�Z���AewJ�rUS����8h?t��:vB�?�4ͮ1�]y����^���ܗ��>ؕ�\rU=<��VD����A��H���H߾(�3�Dx�v[d�/C����յ��e��ӣc,?cos���̙�Y�?�	{=`z�̖%����,���y-S�����a�&g���:�R��#/ŉ� �[B�Cͥ���k?*V�4����|��@��1����#���N��e�Y���p��3}%#/,t�?�L\"�����\Z��H�O�of��>�c�R�����y�����a���%u�?�>4�&>���?��_�{\"S��8��B��VU?#���5?��Aqq�O%Bˉ^��W���h�\\�\r3��X�]��3�E�B/l��p/d�?�i98����+�N\0��;x?��4�?@���qB_E��t��˓n�?�&���Lo�k Ih��T�bO��gͬ�Ad��qs����:K7U|ڂ��t�����,�������>ipQ�,~^��>�Dr�LO?��q���V>w�?�����*�K���΃!A���\ns�!�WsM�W?��J��3���q�M��?�P��ŕg?\"n<<������V��y�k�M�\r���@{��5#1��1Eҋ�/�LǣԲ��	Fٟ>B<C:hd��,JkB/P����LJ��)j!��,���������Y�,�\0�9��`nB�mc��$���\\Γf\nX��<yKI�o�&U��l��Г��ٽó�*�kG�f��@�}�IKui�\\�,\Z��;?�.D4��\\��mzU?��Q?>Q��a��H��%�B���#���L��7Se.5��\n�מ�{�����	�uqIǸ����l��\ZI\r�j\ZYWE�=�@%?wK���Ї\'���`}휠�}�Ve���qqk�~�l���e��Ҝ�y{�0�Eȭ��e|��\n��������K�r�6�!%>����C@�RK@��,�t5\'ʸ<O?r�\'dx?��[]��%j�+4��C,e���>i`��|⪽��{d���B�:9I$iH6��!p��j*i��4�\'}�H	�ը@�hɣ����At�p��ӟ,o-N����ë0��{Q��N��q	��L�٠џҵt�*ْ+��?2A��#�>RRʾG�49�W�����輔l�\0*����l,J!r�������w#?��iw��>�6S�G���\'&7(}4��n��(�t�\n������|^�4�MZ�/�Pb�eM�ٳb��Y˖�:�?o�3Q\r���;�� �Ƶ�N�R�� *py-�?e쯥g�Tn��F��?���:,�KO[\\`�\'�}���%>?<3��`1#j1q6��j4��ex1�Ul�������$v�	,�h�U;���b�|l�Wy���G]x_�FI���!?�eA��\'e����N�C\r�z�D�Yi�U��>ƿi��?Р\\#��-[�aѽ|�}*��{�e�a�����`��m���?L(?��R����z���E�>~�u?W�̯^;�YK�-�<s�V*}[�\rz����%�ъB\r�Y`M�1ք��[4���uȒ^ϖ>�h<�u��9���v���%Oo���{d�6B%��\ZY��k�j�P�~z�iݗ~ò\\�\\7���2��u}7j%K�!�(\'�jL��D�=?B�0+�$�����^�E��f��ë\Z1<��m�EV�PoL/O��Mt ��{?�]jv�,��I|���;�αIy���6]��v:�9b��(� z�Q����(�\'#:7��uFW������餄�ô��t�hha�c[����FD�<e�g픉���4@?�bF����Ɉ��8��P�X���M�����t}��6u��e_x��G��<�5O��;�o�)b��TM}�����gdէ��L��\Z:��*��OG\\6�R?:�x�&\'�\0?�c?�U���Z?f8�����|���Է��o�u�WN\r�ڈg\'�t�Y��W{Qt�:�B�G��*kP��W���}gw~�V�E�p���`m��V�S�B�1M�o/Ry�k�B�>\"�?ξk�Ķ\Z_�I�닊�#z�+��ŋ��*�D[`-M#]�4l���2}8M��?����\'e.�V�J�˃L��F�L�������Ǥ5pʒ�=�輴�[����\'�o:L�/,O��\'�o֕���?����Vɱ��7x�V�U�J{��_�:����!�d��<##�\\;�3��)��Q\\��-�?�)��U&�8=Nm+B����/�|�[ӂ�f�<m�NӰ4f8*j���< i�F[-�n�\\�|n��1�����&椥vv!HgRyks}�3a��k������w2��?�n7�f���N��\r�|PQ}\\�Ur-;�&Z�3>�D��1�[\"�a༊������S_;���I?1�{k��\'�?*�p�Tw{	�_.�RC%��n�~2����c��^���p5�q��\'	+*$��\Z\"���?k��V���rϯå�H�&��L|\n�&ebr�~4j����8���F���v�\rꕟ	D!Iӽ�m�������~��t�F��.��W����Z�ӧl�_1��C���J����Æ;�j�i��?�������R�)�\n�(j#_��\"�}r��1,�d��P5	?Y���?�e�z�ɈS(�����NUp�m^_xy�Y�U{�J��p}�s�jmΎ�\"�S6Vg􎧡�����@:{?AU�y\nWQͅY�D?�*��>�� ��q��ū��|�/�gE�����S��,��}��^�[�=o���.���pY�C�����9}����ns!A���}��領Q\\�����c8js��R7�٧/g]�/:>~/�����/%��1�vQ����2`�������*�^E=?���$��+T|��m���<L�	��t��\ZM�gx�kJ\r,8��I��K��S�į�,_���?@_T6��U�HO�iE��V��#Q���)�>��wt	��R�d;P?�������->芧�,�m�Wr808�|�����BrV�l�	Y~x�� �����6\"�Ԫ�� �%���[�l.\"��W[�ZJ���?����2?��M̡?h	��,	O�C^}t�?�\rEw��Xj_��2d���e\\���8]�A�}Z��etTο8#\\s8_�=i=�rFf�1<Wq�MW�����a��$s�\n��@���+��/�j�|���]�-?�Z?yr�mZey\r�2�����?�������y\0���~�����?�����g�?����������?\0~�Y�0���q��/`��~���?�?MMM�/_������8s�̅�o̒8�o���η:\r_��|���?����o�&i�@k]C�\Z�w���xH3,��]&�A{�O?��tb+KBv�9��\n�?s��(��ڜ{��|�s����3)����`#Ց��#��z>tb�z6.��ڙ��7��/Կ��_[}�sro?�4la@���?�_�&�	i��\"�u�4�R	4��{��ٛ/h��U\'�To9S�!��\\�?��m9r\"(�G�_h��\'Ĉ/\"?���/(0jgfv$�ģ.wn�ysKc�ɊdQ���#�?Q��I?�rO���ɭ-��=��h���B�;bȸd�)�G���Lvj�x�uA�����u}b�2�k4���?�i:��g����?�Bk��k���?`a3�Ц��C?\"�دN塞�Fg�r�~7��?�XJ�D��ܩw���(,�YOF���p����j��-.5%L�p���0�S�I*�L���)�F.2Wf�0�W^���\09�Pn��+�*�V!j3/� �:L�1�ha4�]��j�d� �F���j�xXp��ⳙ��;,\n\'�n��ψ&I�?q\Z3��)w��@�=�B^����*M��\'?�]N?f�s�I(�~�ls3�����\"��sRZy7���7����8�e�<�B�z���O,W%D�!c��9��Z���D�4a��O2.%�e\'�E�ue3)%j�o�&�W(Gg:���s%|m�kB*�\n�s�*T��\'�l�i�-�0�&�S֣ω�մy>e��o��8��m�R�}�E��?�����ի\n_7l��/9<?j��acy�����b�����Ȕ7Dp��$?�R�~�㪽߀�����w)���N�K����+�f��\n����)(�~���?r��|>\rK���SvB�j��m\'iy�E��	=����1+�3Im�c�&�H�� *����Okԅ��ｫ?��\\�N��R�\0o�MM�g?��?1WL\\/��p*t1������GEP��%�\Z��;�\"�+юf\'�e��\\�E���7\Zc��p�μm_+�a+Rit�g���f�;�?��l��\'��Q ������Ē�a��m,�q\\��n���H��e�R��34�agK��q���-����W��?W���&NE��<�O��NVk�����i�dO��b����ڇB).���t��>̾�[�Wxe����v~�����1X�39�6)����	?�$io	�>���	���Y���\nˈ,t�^�r�\Z�ʿPY0����9�_җ����<t?�k0V5���?�t�\0?IMɅb�[�����;��J�������k����Ǔ>�T�	��?~$r��CUT8�\'�ђH-��*Ok�v��qkj��zR\'N�?�ּѥ\n��Wm\n}�t引��֤��B\"�P�doU]h\\j�D�k76ic7jo�v~�_�:��!���Ȓ!lYfτ���̓��C7��һ�T�ݽ��*��l�T:��v��-����;B�I��@��r4G��,Q��D~�	�4n�|��T�?�n	���@��<�H�����s��ˀ���i\0�l�ػ�7kE3#��1\'�o�D�ϩxKS�-���?g�\r�Xk>	�����3`�}`Z�	\r���j\"�ǦO|4;9B)j�LX|�3�7�1PDC�})g��?��n���É�B<��=��?�;9��疞^�dyA(8��Y�k���������������c�\'l�a�?�~����������?����������_�������o������;�:.h�?/?\'{�g���,ެ�?rqd�XR���J~�z �q�G>N?^O�?�� Pߞ��W�5���h��u��������w+�||3fEr!��?M̧�i��� bu�x�ҩ��O��9�Af�l3��!�/��t?T@μqC�\Zh�Un�v�\'R�b�F.��~�-�[��O� ,+MO���0=]�=#��*�a���7?�&�R$��\Z�����?\Zfw��A,\\-aNP��p�b����������w��O<���]�ߔ?ݜ��P$��\nހ\\<���-�[E\Z	�vprYc�W��9�B<?�H.����b����Y#0�] \'W[k\'?\'\nruq��a�9A!@^ֻ�An��n?�ް=?m]1E>�~��0��?�vs�4e�v�a��\Z��[����u�Uw�8�����(H�����\rdh?p?\"�5y		y9@\nxnN�����=�1�ٺ4򀂤5t�A(�����zx�Xc�ȗ�?@W^^�RW^�ܮy��l� ?(�/v?;���9�\\0uA;m	��Z������`0ap�-�5u�u�@A���<�R{J?�Z�K���f_��Ǟq�w{�@W����=f0��0��`Im��Z{``��1f2�u�����+�����\r\n	�����%ʚ�> B���L`��#�����&O@�\'�YQ�?𷶘:;��<�\Zۀ8@.Po�+�g6\0\Z�Ǝ���c,E��?\'�m�{.?�����?i�K}-�_�c�#wn�-�nfko?�����1����x�B��l���L?��?\\1,Z�atگ-~�����Bw��]	ı?����\'����Ycf��b�i�=a��E�����.����>,�1e�A� ��W����jˆt����~�cgd#�l�V� \r}55h��@P+p8�&�����!�������n����9�[sO�O\0������8��\0Xh�_����a��;����0�¼��1l?�ѳ�K��]\"�W�&��F�=���{�?�O�\0�l�\\���	9�<�O�cDa{����x���?yc45�\r�??��S@2��G��i?C�?��\r�?�@l?f@߄T8�\0�����tA:��Pd#�_@���\Z�	#��l6{��\'-���ߡffز���h��R�ssE�7�L�<�\0x\\�k%;�8����*��6M`�l�O���Fߞg���7��Ͽ���`��������w���ٶ��l�;\0_�f8+�d!0d�\Z���\Z�1Ǭ־ (�i�`�����\0�c��?� o(�T�\Z?c�Qt^0�0p?�@_\\5gW/L={�G?Pj�y�l�A;�\0������c\Zc�#xx��� 6W����Fzp�\0��??���?{I3r���5?]?�&2�G��ӎ�\r?]�0�Gm��?i�83����\0\\�m��\0���u�P?���Z�\nʚ�r2�lHv�?��o/4	A8�A�xY��]X���k��# a�3�R�e����݌�e!����t��.�A,��>0�N!P��\r�����d�jM�=�Ά[\'ذP1z����4�b��@��O�킓�f���\'L; Y6�z�,�*������\\�l�r�ƈ�?���ޚ�0���ߺaۇ;�~RR �\\����/(`����?(�.��00���Q���ڸ�|�B�3��L��l�o���c`�����=;�\n�[�%�v�\r`_�|�@@��N��\0x�qR�<��p���#��\0�K�?�Ǽ$$��i��{Ƿ �2��X�l��q���ʿ������NI��=h�$$@\"��}rJ��^�����|��d��XK��h@�|B�W���uo���*-�����3�oN�_(YL��Jvg�_<�\Z\r\0\rT�g\n��ᶯ[\\����� XWp����+�@�\Z�}��n�o�S\0��)���3N��g�z~���_����s����6�pu������ݿ���������_�|B����������г��(g�X�]_a�;�?p��Ȉ!�ר�����\"l8��{���k�z�-�\r�\Z\\��}?��* �a���g���5؆����\"R��?�68��u@Y`�����c#$���?����N��7�߶Fv6C8�?�v6�0���߭��?���ڈ��\"�%��Q������?�#���p�ӊ�;\"��h�ǆ��?5���ɺ����+\0nk�rq�e��� �������`~?�������?��?�\0���%@�\Z��q<7g��c�	_?\Z�E�����:�`�`;�\0k����`c�2	 \0����+�[�[jYQC �\0��5+�%V?��\n�l���	v9-y�����?�#���??�9 �@8�mFl\0o������+�����ʅ$F�@=��Dz�\"���~:���?�AOG_c;�|U?Vӕ?�/���LB�tq\0���cɅ��(`\'W;7u1��N�������\n���q���mY�-��u�{��N���v ���_���/�z{�x]���OIu��\Z�κ`p�������{vذ��r�u�~Ⅱ?P������b=8�\"\ncF?J��+0{?(a��\'����[|�Y��退B���Ȣ�_4�c��v]=��}��d/(��v3����^�v\0l��??�i!?�^�d�;�����m@�l����u�OΟ����n������\\��F�n�_�\"��U�߲;)w&�vj	h�	�Y�3�d��rM���ۙ&7�}��m9�<��m@��-��g���A�Kc���?e����Hf�\'c�g�\'���l���?} �3^�H��$�������T�/+��f;VGa��{4����J����-W���/��K��7!�H,�ى����NPk?����\rF��~��1�fj��i��z��eɆ�?X|�i.��pK��\"�p����? �f��������;b�����cW�w*l#�s�l7�	(�Y�%���A(�)	8�w�7��B��d����}�����_i�g\n�?���\'�݅�?��_��=����ng��??[\n�����7��_f_l|=�H\r(���_\Z~�;P�_`��j�;;�G��}q�Y?��4�\Z?��{_H���Ǳ���0xq�����s����6�w�1�7;1B���\n�ras0��/���?b�0?�`���[{a�WO;{��p�1�����/i\rR<\0�U���`[�p�x�ްˇ\r��SE^S?���?i�&{$vg����*n�ܖ�?⟒�\'X���v�ߚ?��8�g��J�^�����˟���_[#Xi�UR~7I��?h���ۯ���?���;�v�׿�t�7���]e���v?v���G���;�5��upw��y�ͷ#:�$p����r�����k�?c�a\\�Wg����UK�3�����?@@@��|�����		~bB�C��w���/�&�UG�\0�n���wdn\'UWQJ�._�	��d,�2noulZ\'�p��E��\r$8���f�����Ƌ\r(s��a��8�w�R���1���U;���\"�+@������??;_\0���?��F���W�����>��?�0��ew�ƿ�Z��6 q��c���}bT�$?X���x��2�e���ѓ� �:�9��bf��?S��\Z����!�/�G0���-X�W����h77���=&ۮ�߃�o���z���/��-w�u�k����wx{m�?�����[J��5;5�\r�^��إZ���?S�8�c\'k(p���\n���jx�cQ�bNbu����Z���e*\'n��YA�W�j��u�oB�i���	\0�ɣP�:�4UA���@�.?�+�`��ȵo�\\��[|�\n�p���O��o�;�\0�\'�Ncv.@?;�q?��G�?��T�]�v��?�vWo ?��ǌߑ�_���s�Aǘ��P4�?\n��c���(.;��1�\nE��z\09��\\��lk\0�?۱꟮-��=&=�\r�V�����.v젿P@;5~s{w�\'U��?�\r���%\"��mM�\'6�=}pu����	����?k@U�:Ap�]�[q�p�R�W�\'�s�� �[��A��`�.]�i�v;x �{(Xf���?�c̚_����X���v�X�J������$�|�����~L�����O<;��\0������ꉰ���b��W.��-L�P�??w���l?Y|X1� X�����	���?��b�`?⸞�?��-�mj h�1��vNhya�P����N�c@a��w��1��t�pp4;��?!f��<??a`:��w�?��/0:�M����芃\\��??	D7���d{k?h^ ���rE9~p��׎Ĵ�J���k@�?�!�^@7kF\\a�v�G�=�0�ަ�]Puuw?\r&��t�����ݢ`��c�=Tl��/��������\0���;�@�cona�?-pqr\n����S���c��/W\"`7Suue�g�w��97���0�������]	�-�x��ފ@���a��;�� ��T��2t����K��+�b���/ �?��v����#����k�`p���&\\��E��&�߷���N��O[�{b?��?�=<���O���F�?Q�������1����¿��u	�gĿ�f`g~�8���;P�{aqv�/	�N?�66��b�`1`�[��q����4!f�AX� ?�%X3���e��\rC�:�Yn@�6p���hw�u�\n\\ n>�#?pE��h\\��q�#��?�n`g���o�����	�Bw��?+����\0��b[�v\0u5��p;?����������~�y;-�OX���[)�Kz�p�� �#5@�J?�Μ��B{� 2�F/�;g�=�a�M���޿YB��[�w_d���?���z���g�����;����~;�#��?�?<8�������\0�`S�8�b��\\�T��Z0��\\��\\ӊm�\0cN98�5�0<Ĩ��{jm���\n�e���3�\\p��M����8(�Y����U{����7�|�{\0y���(��$����ŵ�F|o����J@8���|��46\\y �#��r�?�����w\Zq���Q���rp�s����w�p �Gsp����?.g���Y����������� �����_��?����N�YH�=# ��!�	�ÂÆ�?P��?=�����s�Q%iyK5e-\rE@?s���Tߙ)�_YW7_��?�6XRD@�@:�P\'W;={Wgk$H\'i8`@0s��$l�Xo�p�,;����f� \\ݸ\0�����v;��^�-`	�w|	�����W��4v����0����m�����\0v��mo��Y.?����~\0}�����	ć��?� A0���g�n�@`�c�l�=���?*$�N8�3�qcq���\0�?.��m���F??�f�h$P��?\n�h�JW/(�.���m������v���L�n��S�������f\r \nr�v�a>#|1]a?a��?ؤ?��W���]aG��\\P;�b\\s;�θ������hƉ$�{X��\Zkgg��@�6 ��ذ�O���=\\����\r{(�� �\n�t\0�٬AN�\0_v�!�M�\0�Y�lS��n\01���A�>��\0T�NĽW�b���OE]�RCS�RW_KKSGO^��(�%F�`�H���N,��S½���+��������z*�2�a4q�_�?����tP�P�	�`èK&n ೛���\\_7?3�g����c����=v�`gZb�t�h��?8?:�_�\'��d�Es\0�i\'��b��h*o�I��m=v�1�?��?��<1\'[�d�\0a��g�.;�0z3B.l�h�z8��7���?��aE�`�e\r\\��E3Ű����I$�H�\"��b`+E$�L`G�llk: ?}��<��N?	��v�bϭr�6��?�5f\n{l�^`sU�k�1#�fV�N��@�S����v�	���i��F`���V���bId)��1�5�ud��c��P�[�Ǭlرc�O�q�l�P�?K�y��Yv4*f��?�Xd�1��?f�?!.��8R�?���@�\0�s�D�o���?EH��H����\Z(c���X���!�ݵ#��P�����0���<q�������-��7�ӑW�W3���Xp]�<]���i`��\0P���vO{�\n���u������MT�}7`�#\"?��-���6���}��@�!�sG����\' ��m�H/�����{k�a?��ܽ�\0W	���3:�NH@���}�ؗ�/��~�Ķ���!�\0��:�׎����.�U��x��uű�q���\rw�=�n���K??`��G�������\r8@)�X��?����[�����v�?�0s��wLS��v��\rHx����0�F��#1*����M����ۛ�c�9�`&���\r/�\\��6���<��N�i{����o����M=`J�F�ڙ����� �/0�]�@���垘m)�?Y ���C��C#ol���	2 �����13�p�?%�`s������guOg�mC��ka���m����ܒO�\rg�Y�!�}-v6��ƽ���B��e����\nn��,ws���\'��?����pu2�?B/W\'�D����>�Qr�\\�/U��i��0��K�9j�U��@^�v�%��.X#\Z�^Y=�3�l|AOg?���#�B����(gE1�Tշ�$��u�ĭ�8�~�?��mZ\\�?�uƬ���@�~?��_\\��YI�=0���C1w�ܯ9l_7�X�\0�!q�y:Ap�n��n�#?\0���wƘ��f�Ӷ�È�*�M=q�bm����R�T��\0�	�i,?|@�|H��m���r7Dk�F�#3vG�~�˸4\nKࢌ����ƹ���:��z:�\Z�\\ ����?5�7u7Xv0C�[�b�{�b?b����B�5?�/��?���?�v�~���f^������la ������Önn�����g���\0�?�\rt?b޸��8ˮ�?��j�8k;G~f�n��{p��k��0��R�w���+���3�03��ngy{[���ŨK7�ks�a|bn�G�0s���tŨ4@U�\0b؆��@�#D���X��� (��&��q�8�Ү���X�g�cD��x�.�@�?5F?�Ns�>��!m��	����3ۼ٭����$Dd�ߦΚd�7Dj����\0%0t�`��ˎ����1vw@cP��K�ζS�]|��w���^ރ��\"{��?��v\0b���}���R�ϼf���b���tgp�a�\0�N�=�ȵ�daW��\0�+��g����mیaٱcX��-,{�mz��7_~���r��h ľ?�Xrcv7���\Z�M��	@Çߚ�a$#�?[�f��\r�޻���\\�7��.A�iF���`e^VSMS�R]ZW�RZMKIz�?�%ǘ���\0�q�{\\؜�ݸ�~1�e��v�`[�!�\0�e�{Q��#�g�%o�%�&��\'/���=�~��?��58Y����z�5����+��W��CR Is,�x���>H��K��?���w�N�yvV`@^�N???�����������>u�f��$�]8?�?��Zh��;v鯭1^�n~����B��o-wP�#/���9���U����ds�\"�`��!?�����O�ޡ ����9�?�W5?��s?�~�c/�_��D�el������=��|���?����N���e������?�����\\�>�����?j�?v������Iٿ<�R�a�q�~�n���P?���yf�=^?��_��_����>����/�E�	�=�����e���`x�g��I+�H���\Z��f���{�8�;�+XC�0b���5���Кl;0$q\ZJ`�M��(1�m�u�5;;����?�������H�,�o�����3�Z�{��\'���\n�_I�g)À�?�m�+��io����/5\';`!Fos8���钛�O$Žè<�J��v(�ƀ=E6N�\0��_��\\������~�\0����6�����\r�?dr���o@?e�l��}?�����Xc��=��������?g���?�v��(�;6�I�?��;0^�O.A��Z�>!w>!n̈�zT���`$e����c�r��\r��v�����>6H�gS��1v�suى�9�	���e���3?{�	 �4��?�qu�v����z��oWsg�~c��Y���[����\'�z;[�.�������53.;���5�����u@�Mo�#v@ p3R�!n��?�(\0�p��/\Z�?���g��pu�e&�I��y�s?�,��C������+�	�޴��iq�8�١#�Quv����˟ mN?-R�>?�����a�J����~�?�(Ti���N��P���H�U�� @���T�\"��֪AZ���V�j���TԦJ[���X�c]j��R3wy{^@k;3�~��WK��=wy��s�9�s.\nV�`�Ub,��\\\"�7�)��\n���\'W(&??i_�\0��V���%�Hg�Db��#efI:4���#e(q�E�D@0�߅e\r?%�me���H �@��]�D�\'?���\r�F%0�_��;ľ��]We�/	�!e���E\\Ki�Âaa�Sc*���I2U�Qg�`W�E�}�����2ܬ��\0��P�h!�!�����P	Q�/TjԥӄDg)��\0:dV��K�A�������!�k�!�!ٔH=3b9�W����)��al�5)�o�B-B�P��\rm�P$c�Q�M		��,{˚��G\n�S��\\޽š?|?��zp��\n` 5?�7^\Z?4�媴??T\\5�SH��fL$���%Oy:� $e��2.u��t`Yj�1���\Z���vdd����T� \0�/�]�4�3����\Z��bL?�e{)�?�}T?i��� �6�<�9(�0ikN3���K�@e�(��`d?��L �BV%�B��,�P۩CgF���E?���#%�d��_6����-��C�qP�O*�+	��`}�?�A��\0�8h�=�G�O�H�I�}i��ԇ>�f��MiW�֡�Ԏ<�Gv]X?�?`N3M����(�j?P�п�?�� ����!�@\0��+,�^�����Mf��d��e����-r>)�-)9CJ.�aP�|R\n[R\n�T��^A���P\Z�\n!�Y\"��m��s	t-C��D)8?�)��@�`�R�AX��aa������\rR���\r�A�H����Y5�6���?�u�k������7~�K	-�{)�H<��7~�D��N?�o�O�4�U\r�\"��*�4x�v���L?A�~l�A�nROJ���7E�{�?�Ox�f����1�A����0Y���c��D�*����zC&Sn0��� M��H��\"u&$r&(�8X�<e�h���J�;�zrH����A����M|z������%9~\\�+����\"fS���R���#��B�;�!�\'��\0P-S�Uys@R[��f.�%.��_qo?-�Bx�/[,�3��v���\Z���`��H��\"�.\"`��ߘ\"4���$�Q|��79!zL\\Ztl�p��ӑ�)�R�4�\"3���@Ȱ��\Z�}��eET��ha�b�łxj|6�=��&DH�.\"�(��?��m?K܂P.\"�6.\'��/�%c3>���N�a@�g\Z�ޜ�0�Q3?���\\ju\Z�tmp�`��z�����n\r�.a�O�)}2�\'	�D\nI��hAj�z��?)��y�h���,h�70a\0X��q<�\Z��Ŏ�#\n��\r~@I���fS/�K�K�8�d��??�!,UĠ\"Tо&&1�?`�g��R=�ʸtp�/��R�ڎ�\r�Dv�Y���,�A}�~��y��+R�P^�~rPFˎ��q\"�|T\rU.�	��g?���k�j������ӄ����i��ú�G\ZAo<�?B���F?g̥��nө����F� [�/���ڄR�4YI�<[D�8?�f�����S�1�!t��0�t�ÅlC��\'�-\n2<��4��vv���ڋ�A��JF�;�\\ԃ����dfJ�	�9>T��`COgq��(�8�?y�&�ОM�2�2��b��b�\0�?0��6�r��]�¦ډ��)塕G�\n�y���n?���S?%�<��1��/�)�?��Hx8��`<	g�FJ�N�������)\Z��`��L���?�ĄbH����\r������I�=��?xP\ZN��?6T���Ȇv]t[0<MLL���<�����ܘ�t�\ZIS$��bO�P# ��%CF�iמj���^�,AY��::�/>�CH�	&P�P��9�?ff,;����Aip��ʊ�??$J=ɀP�L�Hr��hD���\\����2�\0y<�,��Ziy�\"UӗW�b⒧�?I�?49.9y\\�D^_`�z?�?1Fl2G�<THP:?\Z\"E�݄�\0��&��cz���Ѐ��Q�c�q��	�\nT�U\n�5������FW��?Df��d��c�q⤀e#c%eeԎ�����yփT���-d�*|��U�i��Fg	�>Fi~�y�� LP�H]E{J9����l�_+�?�h\ZfD�!v��|�㉎\Z�`*���?�W�@�&;h��5���\\8?���p��Y��J6VwFJ�-��:a��IL�P�\nr���P�\Z�L\r��Tt��µˌ��H\"y�B��e����xQ�6LvR8\n��+sK��׉?{1:%a\n�o����l^=k� S<��F���*����\"�Qr���l6��#F`�7;���p�g��XV(�V��F�����wW((m3�����u��e]�0�]B}l6~� Ob8����-��[�.D�\nI2*r�R���)|d��c:eY�p4-J�D�d:��\0J4r*�����d<9����N0�	f%Vk�4���f�c����:�g?m��c1�o�Ò�_Q�I�!�gD�\'����O�*{A?�`E�n���������e���(18�HQ6�UaL:�\"0.ܗ}��zu��D\r?�b	�f�D����??L�\0���`7,*K��,=�C?��(l�\0�ԂY�\n	BEǨ롕��2Y����@u\rV�ٙ���2=u5�0�p�5�,H�`��$0��!\0;�h,��@z08���Bgڂm&��<E����A�[��J#	�g��be��TCgZ�����0�@#æo@Q�?�@�?����G��؇�\rd����)%\" ��?�g�ʲQeP�\n?8����d��X�?v�J���Sh��X�W20�T�g{˸���0����n��D�q�i��\\��8���R[?�?��8OQ?Q�n�Bsړ�&p��ےe�m�N�a��Ė�?o��N��\"��Y���e�7,P���ʎ�g0B3������ܩ6`X�Caf�¼��eAaA�Hh\0���?�J�#�I��1��)�����\Z?%L�=+�,�������X���:�o������6��C�d��w|���Le���{?=�zBP�I�$�� ��	�\'\reA@k�&Q�XV\\^���U���o�\"��0#�~)?��J#�!@���d��\0����P�@MB�y?���ߌ��\r�C�T$[���\0���8�&v��R�2de�d����\"�<�T\"�\0�!#�/�U�qV?o㶑?)F@\"RB�84MZ�F�/g��\'X>��(_%�����QFCڞ`CE�e���!�D�e��N��z�E��D�Ά�Q��L?86SN&C$2��R�Q˚v[��	�Qͼp����\Z���5H�?n+���&�&?R�\'��\"9�X,�j\r�b��ǜ�F&GN~�C�?C��/0��?�<��p���m�����a6��W������@�qqz�Ph����s���sn�=���jh\0_�Ȫ\"��PX,\n7��� �|,V���\0���/\n�\'!2�Ba�(bAYA����b��l��S`ma+!�	X�\"RX	EJJJ1�� �f>$�V���-7nܰ�FD\"���Pl�-3a��J�/Q��҄�E\n�E$d����B�h?ΛA�A��[�l����j��֬V��TX�\n�����L���\n3 �F`??��f�ܢPXAi@?c$,�8*��@?�V� G�`?�	�d%\0!������jQ��}||`�\0}��Z`�Ag��?���β��ӹxi4��jSfUe�~yy��+�O�Uy�?<�����}��[�Wo��?���x���J���>��Ͱ��>��!?�Ϲ}v���+��K.?�ֲ����(��������a?_���ݦږM\r?ߔ账O@�??��>�6��.�T@�\rm�s��|y}���uy�k����-r^tg~ڙ��w�?�����?����.���u��L/15>uLIחݛ���:੽va޶���4�\r�H1���yo�X��;P]wtk���=ߘ&?l��wn�Φ���8���7��c���������IeR���N�ZX����\0��c�����xe�:~l�sN�*[�,�`fS��w���R��ͻg_=5m�8w��e�d7E��̓vHW;�_��έ�ݖ/sRRҵ^�73�����q�����>���u��:g}���:mjiV���o.??�?X�znhyf]�?����/�^�]���\"�~Qߗ\"^��bAr��ַLS���¬�5c�H\r�?����>�~r�}ǎ��ޫ9�wG��l��ڳo��򋋶&�?�Yy룲?\'ʇ��Z��\'��@���Re��AS����g���87��U��G_T^r]�X}�H��=��Ϯ���?^w#&�ڸ���++�����?]m���0��נcN��h��9kda-��׹�g����m�Gļ?�]�>?�?��O�٫��g�Z?7����71!{�ܘ9~{%xK�\Z�i?�F����g?��?/�|kڜ���m�:����3z�����~�g���k�,[drh��Dt�o��a�I%�M���S�r��kk2�_����R�sSۑ3�+/u���o�\"B,_`X�~,�Se���c�l^���������{�,��>����nŞey���KR����<ou)�e���#��js��qoȺ��uW\'m�|n�n��&�pꬽ�7�ϖ?��|��[K�~����iKʦ�&mQ�#Q::t�G��>璆�������\\>}k�i��\\�=�\Z��ܩ�6�P鸣���k��>s�g�.܎�����>�lv�(��h&����Y�l�>��m��t�+ᢤ���s�4�s�e���vKSv\Z�r|�����~�^d.t6W�_�Y_��syh�wQSM���^g�2�F�2�D�����,��ux��J�\Z���ő��v�r�q���l��H�*�f��\\c�޸CW��+d��.�)�:�c�hňr�}����[����)}/�f�CiHs��Y�m�߭鄻2�k̮��M-\r����_v�>\'J����xTV܌|�fӲ�{�[<s+������\r\\�p��{�sڗq+.d%5����G�b�z?ۛ1�>N9y�z���?���<�Is�ݒ��a��&�s�k�b�\r}[����\r�V�Z�?ґ}G�{��U���|�_�yn�G/yP�n��Os�>��7#��k��5����-��3�����G��k���/??d\Z�%x��;?Jp�}�q�غ>G\\]]{����ƹ]WN��V�������z�n�ښ�o����XF�9I1cN�|R�f~���g˹n]�˼�dl\Zq`܀��+^?�b��[s�!���Zuk��ە��w�x��+\r?)GN�֬�j�S�mlM���ʷҷ/4\'?�r����py����8��C1�g/y��HN�G\r�/����L]�!Nx�ϲ�;��g]+��a��kX���)�f�v�ռ�;�.�z�A�:����\Z�t��ن+���?�Mxq޹�/�?�<G����YQնG�[#��|P���;��F\'��\Z�.���ۺ�[]���߹�\nq��ӧ�5oWxn��V�\\5#\\��Y?�����(�JG�?:�������e�{��bZ������ֻ�w�U#�Xw*��)�&ƶf._i�(ش|�E_�?>��������s��+�����YQ>k,.�.�*?~�p��?t[;�k��ת��ݲze̦KǵC#�������]��dn�?WsE�<z_����Qs,��7W�{Xq�ׅK>�r���4w��\"@��W�Gv�n\\S�7B�!S�_����j\Z��!�f����+�s�eoL=���_����<yU�9ĥ�3ndO�P]����K���u�3?՚\n�����{z�k��W������T?X��Si�c��}+�fm~z��[��?��̡Oʊ��|t���{{�;tJXz�_�}\\��?�����\"��HZ�0��\0À$	J?��3�,\nF�Y#xf3*��\"\n�b�3�5���w�w�������?��owuUuMw�ttB6�w�>]���:ű��r���\'���x^�9��ʲ�?�G�F�v��)~�(��w���X��AĚ���/̈(�P�?JY�e?�:�b��]:�C��}���=�Gs\rlg-�.	z�}Ux���v�|����\r<��8�>{4ڤ�di?;}�F���d_\\�v�Yz}༳�Zx�=���,�t}������6l�=,~&?��8����W!^�;��|B5�qѽ��,G-.<(3|��j�x��a�I,3�I�,�m���N�+M�>�rܶ2�a�̓�/������\\��q����Cv߭0؜����vIۋ��n˶�!G������?�[&nQ5pv�� Ѡ[�#�?�-��,�UQH�\'�sd��>?�b|�g?&f~TO�q�\\O?��M2$�J���������2~[�ik<���2��U�:st�^��Y��Ċ�s5&[5�?�v8�HW�~Z�?Wu��e#��so\'�7��o8S�i�9�s��#�b?�?,�_{�n�Ή�_N��-K}Sl�`?S��#�	�W���f����|���vO8�����4���c	\'#�����T�Jw1���;�w�o��9�h��w3�?H��m�ڋ�g�n�h���\'��^]�x|����t^���?����͵��I��w��?*�]-m��wђy7:=�~�1u���[�/\nv�x���7�Onf�x��}v�Nj��<�{>�݃�N�Y��v���/Eʯ�{��?�GͥE��ΰ�����\n���F3l��{ώ�*�����^f���>�?߼?�|z�����������%�`?���G\"�|��Ȋ��wb��d�?l,mi��>s�8e�ǌ��Kc{����N��:C�ca6�F��?���:�&�,]q�p�@�P��]W}�|E�	z*�_��p���l_���c�[��s8pК�[���d����6i���^?n�{7���ڹ[F�9��4*�L4i?�J�z3duuu���E�FL}�ڷ�o��?ڿ��?��F�\Z�x���9L���U�И�np1��a�Ǳ�,U�Gz�v	���`����>��m�\\�42�����p�i��:>۳�����ƻKG�:R�2Lu�?��!���\Z��-ު��Emԕl�@~B�i�\'��a�`�a^}}-�Z}�Һ�;�z�O�+L>���K�,݅�b��n��Zw;��z����㗔�_�y+��ڨ�:��^�:\\�v��@��q+�r����=��ܹo��������t������\"��S��B�IQ�=gY�<��7�顕{,��.�?�{_�;Ɯ���\"��������j�_����{���İs��oYII��N�Z�*�*?�lޙ�kI{b�W�:\\�ܤli�F�#��?T[�ξf0oC��g�S�?�oĩ,���m}�.�x���۷6���&�r}?�d?k&�������lj�l��!�}�]�o|i�sk��g���>xf|����?\nB5�R�!�`X��>��#�5\\c�?�:1U5�T��}��\r����-�o�NS��sX�< t����v3	4?�R[\Z�)R?9y`�֎�A%*�;u=?��.*�9���h�;�?%w�&��~���m�����^֬��3?�(޴�n�?��\'����V�Q��*��<Z�x�X�>+f���8������o�/�N<��p�jA�	G{��国z��o���:s�?���6��$/I=7��\\gx_�~�Rs��M2�Q���w&����ώ:�|�mn��VF��h�;:���ټ�N�n�ɟ�\'��7Y���c�Anz��q��:tu��Z�,^��<`�?o���P��������7*8V��W̑�q�w#�}��з��r�UgRߟ�������U�ec�M�zv���7&��x��@��Fؾ�n��}f��9�A�s�����jg,q|a��uw;�\ru�3R�_��z�������ܮ&ڃ���,-���]�5����=]�Gw�-ͪ��n5;�\Z=y����r?O�x�.k����G��S|ۤZ\rh����W�u]����f]��xl�Y}�w�?7�a�������7u�>������i�U?g��MX�d�Ʒ[��݈���>[�����#-K��}1	y<�5�����w\n+îUW�K?����:�6z�\r���X��f���1JZSqy�:n\'�}�w̉s�z��������:��+�6 �ۙ/z��\rB�����ކ�zs��^N�Z��v���쌹�����^���o��f��Ţ8�䰬�˷~��q�y�s졎��dW����M�몕v�m\'U����Z�?^Kٛ�����%7�l����?�7��D���e�b�0]����-�&|��-)�|^�k�I6�s�ӆ�Kخr�d�����?��=��c����\'��;�\r��\\<�~�뼊�u+l�^�=�}ūD3+�zR�C�N�\n�H�}��{��u�߬��:���\r�\Z��\'��1�;��X�A,;Y�,�e��U�BǓu��j��	��_����yi��ۑ7O�ȇ����3�ə�t_�v��U%��H��}n���z<>6�u��7�æ�iw����+λW=��N<T,�ș��\\�eױ��^_�{Y��V��j.jR��:!O�~<|�}��?�6�:��q�<}?����?�?����������)u;������<i�?�m�$�Q�p?*�G�,ӭ]�}��\\��?��̷7�*�=?{��<#����~o��Tƻԙ̮,�\\����g�oe9�S[��}3?��}}�ϻ�O�^���t����j^��	U:�#Vu�����~ޛ?��Coo�g2mߋ�[׬�{Q���7h\\�\Zq-9$�rP�ٴ�V�i�l���Ƀ�0���[=���Չ�΂��ˇoX��e�7y˓��<��]��W}<8+y�J�����U��Nϟ��o�s${��řӿ�,���3����psid�R�1-�s�E�V��4~�\'�}w��b=�ue�E�\n���G^ȳ[�����X4VҲ�p�y[�a��fF���ޅ�q𫽸�rߓ��Y]6�;�ѳ4Y6\Z�>%�h�<]�?i�?�={�ݸ��hό�R���\ZX�\\�_{�u�ȳ���Xy�fT�M�J��?�ߩ��3�ߵ�밭�.:��Z�8;-��k�=>�Vֽ��=]m;_������\\a��$�O�;�=�����k�G�v�/�9h�q�A�����\n�O�~F�j���aUo����gZ��&V?TsJ�ֿ\\`#9���pk������|�	�ᵑ�t���9���\"|O�H����ks�^�Fx����p���㔢w�_,���W�}���?��\nt��mQ}����K�oZ���.04��Zi�\"!��K��۶��>����l�Ƶ��:�\rp��������t�K�,:k}xz��9\Z��VM���Ӿ#��9�����l���2�D[�W~�x��T{?�����}��g��Ϲ��=<2����W��&�>�?�&��v�����a��?��V�ͩt��ڳ���f��ڕ���a���7j?��P0?�iN�!���<���f��f���?�|9�~�pi���*�:��z.~��e��_m�i���;��ّa\'��F�`g�͗�]T.�\\��jI,M)�P�zF������Y��!�D���˷3p윷\'��.�qh���GO�ͺ8�ɃV}����:sQ���7	]y�R�����/�Va]ޞ?���f�ьo6ny�_�]�22g椺�Z\Z%so�N�̵�h������G�*��5^���l�r�Ok�V���k\rm�W:D�c�}��U�/�	�*�?�g鴞���������7��+V�\r>,?;m�Q�����x��Z?��Ne���a?�KR�ʺ����|�H��������?8l��-�V��e;븭\nu*��?�9Z}����Ի#�_�Z��̠�����2�Ƿ�X{8!�u�?Ţ�5��mLGq?�A��k�繃t����>�S�����>,x�ziřҾG�\'/����d�23��UDU�^~��ee�	uoջ3��PIs�<��o���~Iq�(��}��{\\��~3�C�R�C�֥?�>s��XcX�_r<���_-�|���9��i+X�[~0�i�T��6M;�r����p����VM(_�����ʣ�+y���w��mY�&���;]��.�������<K�x�t7;3�˅n.wDf�KM�.�7�sr�r�֋y�p�����ͮ3#-�Y2|lu?�A��ʣ�K:%?�)g�ͼ-�UR#�y>h`v��A:?��?]֬���^W��r�i8���O��F\'��[��4����w�|x�������q��Hb��L=?qd�� �YK{�+�LU<-����V�i־lhr����[�k?��0�k�iD�䅿MचXF��_.{4��oD��㎧l���4�0����%�U��Z��:�zM��>?�?N}_�2�Y��\'��oء�k;\'m�M�<^���\'���	����L8��q�^):)���4\'W]��8=�^���&m;�?���.�ƪ<?�i.�0�Ӝ�s��G��u��شoy�]���Qc�L�2�ǥ%���;�g�y�ǋ�7i�	u5�?��}���hk��ӟ�Ӝ���\"�n������j2f�����q�4�G�y��w�!�2�R6x��7en1?5��~�zv�uqq���]Վ����ŉɦ��2�F�]�?/h�#֦��\'���=ִ;�t?����%��u��{�Ӈ�yU����uaG�v��\Zױ�fW�&�1=���b�Q�� ���zS�1�mr���,��h�^��Ǭ�����h�<�����f��I�/o�|6�k�V�Um{`�i�-u{\'g����Q��j��\\e���%�S��T�k�Q�$�S��q�|f��j��\"�邧a5-]xg�� �WM�}hP��V����测���y���{5����gz1���Dȼ-�N��?�y���ixNob���Lw����?���\ns�Xkw�kQ��w���=g�KW�Ꭺ�mm��w�t��Ǌ�_�i��(z��7.�t�AE�U[e��?(���[�:i��Z���3�����/�o5v��ݬg�+F��U�n��o��Й?B��[q��L���Ϧ;M4nh��%\'0m�|�R�7S*�g����ċж=J��zz?��Wu�.����C�[:��?4ŭ@u�@W?�?�~��ۨv:s�j��3g��6�I����V����em5?qѫ&t��>(�n�?w}�zvO3.N9����j���u�޶�[Tz�訾�}������.�0%Bkáճû]���4���r�ݕ�k�\'-���]Z�4�r�H�PT/\rq�a&�a������=�t¦<����\\+7w�?�*^h�T�d\r��?ݰ�>���Z�xs����#&X����E��Ngw�z3k�ФNC{<u��4;����-9�۶�ݬg��K��p��;eϣ>Y�����C&�	c9�����q�ݕ|n`�G���aq�G�M.?6A%k��k/�]ߙ�c�6�<=��>Ks��*31#Ucf[s|�S�[���@q����z�r�8E�n���]_��$?��qP��t��;�Ύ��qD���ݡ�_^�1Qb�sf䶥�?�jYt�nӢ������{\\P멗�b~��oVo��Z��d�\Z~�2��D�.?_�8_�3u�gO<1\'>s���=K�:�lX�P�䠃��ٰS�v����$��>�Q���1^\\Lί襥:cX�+��}jk�2]f�X>�1�|�\07}�|���&�ڦR�����?U]�T�{�rW��ɕ�?R�V�c�h�_WP�x���VG+��z2�JK��Tc�n��U�b��6����?#\Z�b�z�N�=-Z\'_̰[2T�N4�}ϥ{���<��KU)#4\r���ng%���Q��)��ta���E��j���I���W�tߎ�zi���?W�ڧdG�w��W���Y|���KϠ��z}�?z�����gp���O�?�o;�������Ek���L#?�\'+=���i�|MNF�:cJi�?v��h~���G]�\n���_2��I\\?��������U0�f{�X���*{����|y?з�Go7M���^�YB\"�\r(�7J#�6r��\'���sʞ�d��\\��\"8���tt[�����[/;Xj{���ᨺlI��r���vv������/���o7EK0�L6f��4Ge��F�QG3��rlܾw���Æ˗j\r��}�}���:�g��M��*Z/�x�a��w�?�<*�<���?cw�.{]�~<��בIӢą�~�\\O�2ɻ,e�J��G����[�o[�?\r��2&�^��~s�u�Lvm�.J�v����	�F^�:�g��f���?�-`�4O�/;T7�k\\����/&A�����^1�(\'�c�ݾ;D�9:�&�������G�)gCL��ع�/|���z����?�>;��͊S]N����tУ��9]s�-��?���/\'n�q��9w�r�!��|�֥���:|zX��α��y:m����A��賾n+\'��W+??�vk�3�nZ���j��Oe�sG7����������Iއ�׎�����O3a>��7��\r#�JdoX��;�/K�����\r򥹇wZT;ܰ�lW�3��6�v�߲;w,\n����h������&\r�t[W?��?q�*5���6Zb���PQi%&s�����Ǌ�|{rBew����ֶ�M���2-w�|3��í�i�^5>�n,j��a�&�<��(���3?;��2��6��F3lB�\rK��9��F��z#�L_��dZ�Fs�]�69�šG����MqI᧿�23�~a?�/�~:l�%G����I�q��Ƽ>�5�l��?��ǎ�%���,�v�\'�os3�ub�i^��}��	�^n^��6Q%�e,r����A��\n??���5�v&:��ݣ�yd��諸�~?�l�Xq�ٷ��\Z�˲J���7ݡ-�p��\'^��m˫��L����˰N�C��kN�4��?{�N\Z<����y�Ȃm�\'��(�?���cp׶���t�?ows��%�.3]1���l��}L��K�,��c��xr��t[��0������O�)�Hn�l!xs��0��f]�k��.�h}�[ؗG�{���I�+oy1c�a��mY�k�>sFpn�fܵ�?�?�\'��&o��?�����h��\Z߇�.L�=�I?g���d���}��s?-w�����4;�(J-rq��GG-�/�I޶p\r�)k�����-�t��v��jܯy����ǷL�)^_��-`@�&�w�+5�?{}�Ŋ�k,\'nz�n��i{bOdO���pz����нa�����];��gC�̗L�澿��Ι�)�je�V������4p[¡Qmw%�d����!��ބ�q�\r���#u[�U_�^��#g[�?Z��<jo��Ŵv>��+{�Tq�N��B�g���(3�±c���\'G[ϰ�;Fu�����޻�;_�j��wϲ�w�x�rpy���&v|R�rh��)W�[�>5/er?�v�/�FIڄ϶?jk?�׳q��O˛���������<��NȦh}��g�	�ޗ�\Z���)����W��T�	7_�L\n+ըS3.;}d�ۺ���85�Z?Nt�m�U?����c��Y^5g��Vc�i?2bȞ�ܸT?c-�?�K[X?2e�װ��ewk��v��|�������Uw�N8��θ#\Z�3;���0�����vt��9��z=�g�z�O���?Ѓ�5t2f�k?��I�/I������B9k{Hu�z������&��z1P��=�\nV�ԩ������Ӱ\r��m��e0;�?=?��+���Fa�svx�)ҢO�89���3���ZdN}�f�����,W<?V��W?vnc�Io䗓����%ng�����]�~��׉S/�U+�7�8X?���b\'�:��<A��fip��d����\'Ǿ~��5x��� ����D�?\r��em\Z��Ҥö�E+F״�X�wv�1�䩜�C��<�ͫ��a�?�}K�\Ze�����]d�|h[?��%?�϶/�I}��t��� ��=��&?��o��yي?W��]�����6���:Q���L�a8�[�_w�}���{_-���q���L{������o�mu=tX�kF�B愹�\\���c��#�y��J����otb����l�c7���~���W��T��@Id�?Q�����Y�\n��F%J6�,T�P��l�c�}%u](䣂�.QA���7>������!�H0t��.r%j�??�(�!E\"P��)tb-�Q?���\n�L�F�,�q�v���G��Qu>Q\"1�xB�O@U���EKXUp).<$F�.��q����4�A�P71!UP\\0�CM¸��&,?,�J�\\u����\\tQr��?9�:�G5��Q��\\Bg#���X�H l�N6�PH?B$�����R���3�`\"*&��D���?	̙��h&��	\rcB;��l&�	?bB��e&H�	a�|� .&H?	�d�l� j&H�	��qa�01aԘ0�LS&1F�	\n�}`�z0A[��<L�%&�4?	��=d�Z2AK���L�a&�44�	\n��g�90�:�`,L�&�,�	���c�2�*�`�L�Y&�0,�	�{g��3�0�90�W0�u0��0��0��0��0i7Ĥ��vTL�s1iWƤ}�vvL��1iwȤ�#�v�\r>`?��i��k�BE��{�n�QE�?C�-HZ���i��A=P���	K�b�iE�5R��\"ъE+\Z(��\nŤ�V\\Z�iŦDE��0hC�\r�6$ڰhCy҆�0L���҆r�\r]a��#��(h���v,\nGC;�=���vd�c���v�\n�H;J�q*t�.�^�^x?���Gt�\Z�:0�g\0�`v����I�*0�����1���`ނY	dI�w0��\\3#̓h�`��k0��܋��?��aΆ�s��a�GzjHG#@�\0�D[@��ԟ�B8\r\"�A��D6� .`�tD�DK;A$qDYsA��A���q���^H)裃D�����A�\"Ȥ�NE0�?b�~��\ZQ��R�_���#�������3ӯg�_�L����ïg�_�L\r��\\���FJ����\"�B������|�0��sq������__�@y��\0�z�!�ۇ<�\'�6j�?~Ŋc?_�_Hhl$c�_�_��,�*C��BB���q�~�aQ�k ��\"���P��עC#��{Y���?��QA�1�;��?�}^�C�\"\'_� ~ш!z�;yo y�FP�U�E��:��ٜ1iR37̕x���Cm�ǔyx��5�����TF����ԔѳYht�Q?��g7��]E�dc��$NP\\@X���qC4_�A�_�]���y�J����!vkry��yJ�<��x�w�t�?)����$\n��|w��I\\D�g�����/���Q��Z�?|���zW�0��n����S���*�JX�M/	o�O���u?��&\"��0\r�	\n�!c��+���\Zc�̕�H����ݸ<�eL~4�V��h�	=9�s�B¾�MC�M8���\0u�A`?\\���1��,��&+�|9s8�* ����(�Hnx�S�V���;>4�zW�*%�;u�)�*(t ��zS����C|�{��0��h]\'I���m$y5�^E���&�����s�Q/����C�����Y��d�\\V�Od�x�LV�$iPlP@,5�H�i�̜P�����@8!��M��E�%&?�2?�fk���4��טy\\DLh0�p@��,�H��U����T���Rm��r~$�CF�TdE�\\�\Z������}F��?�����e4�}�,sF�W�rm����ef\rh�	�Z�oPը�?z�\\�Ѭ>��h�;^�f�ji�m��>E@����SW���m�+\n�>��z͑)щ�4��င\Z�FĎ\r�	����L���f�.\r��.�\'\\4n��\"��Aړ�Q��ɣ\n065���[��S Jlɡ��*s�\Z@�c�[͋!�z\0O�#���c)��p��pp4��Vi5ɗǮ���6��P�f��,����c)�k8�^���T�[�L�R�\n*�c�?6�-�K�v���lN=\Z}i֟)���?�)w�6ls\\�\"_~�#3Kiޒ�y��ZՌj��?nZ����[��_�\r�8��}=%��zJJ9�|	e�?����?A�b0c�g8��M�y#К��Q�\Z�����	�f͆l�!���#�{2��[Ù�tL�tŤL���g����467g������NԜ�5%�))?��~X[���lM�:9�S��m���P���(t�����|��[S�8��ty�fHT\\\"�M�D�E�)�@��j��D?!E�TC�Ǵ�@���\'�IDC.�prh��?�Y�&\n#hl!��!5��Z6�!�@/d��P�J֎?$�!���F��!��WBQ*��C?Oņ�L�8?b�zB�����@+�?�SyF�l�o��?)8G��z�q`���~$?�DG&�Q���4l���b80�lÆ���\Z�?��\0�f\\6Ò�w�=�d���?���\Z���!fsf=�9Î�2\'.!�$!���@?W�_gbP1>	~1\r&�n�/E5Bxv����x��+\";�~:*OV�Kq��P6����x:�\\l���s%�{�\'*D���QC�P�[�߸���B�K�f��S�ࣼGqPv��V2�X�x)V�6���$�O<�� L��jp�Vl�W������A\0�,�G�2�\rW�\\��^O ���l%�fΧ?i�4?>���O��O��O�J@�J��*M/��4�?�*�iz!M/���f):�Rj��+.����O�\'eI�ip6[!,��:[?�Q�0G?�Q?r�9�J\\��p�1�\'�2?��\\/���h(�V�E�1>\\&F?�\'�	�)�t�Ȁ?�/ڜ	M\'�\r�3u�y�����$���B .���q�7#g�f�3ڡ?���G����5����{@2RzN\'�	����U��X\\�m�&1��w9�@G�6��l�@�?�u�o<\"fF\rcc�e�zy��f�(��K�?�=���O�Q�1C!��\r�$8��?h|d�i��ꙉ���(�\"���U,��D�VJ�h��������H_غh�i�h�� �\r�\\���:24h��YϑdA�!�A�x�j�s���NO�?d�K��A�1D|&9����\"�I���\'yQ5�W㣕`h��?s&�Z_4V�d���(��\r\n�;�����\r���f�7>4��1QA�c��%�h��1�?�SM�\'c+�Sf��*�~0�d���>���\nii�G<�Y��Us�Ò��?�B����e$-7���\rjZ����4U��Lq�l�)�J�I���?�HfD�ɳ�B���&V�g%�t<�	J��	G��dΠ�D����e�HB��I>�)i������@����t�\"�	���(*��??h�8񱑖\"%5�J��{22AA?u�<+D����M#�q�?S:]�����fF\nԪ~F��hp_��>��D�C��l�>�@)�\0�g.?\Z2B--��4-���\nF(r�MH��\\�������6�V�)\r!�Y�5˺Y&M��hB���E�Q�k�&5h�ҢT�}%���u\"Z&&�0X��?fiI��tc,�u�fV[\0C������ۿ�-�!Ϧ�\rVi���j��@i���P!�2(u�=�xF<]1�F��\r��I:��DmP��\n)ј?`3�j�`����j��%�Q��9ה4YS\"lh�JY�J�9J�H�?��Ӊ�X1�4�?�H� Y7pB����k��)�:��x3�����L1�MO���{���\Z0Η�(��4��Ք���?�c�l�5$?\r?\Z�d�m�C�L��(��)!46 �a�x\'�j���ᑄG�!��*ch�5(?A�Z�$h�b��(:H����t?�8[�=����m|������aOn9)�E�5�&C�2>���\Z�El9!�:,k�?tNf��.�A�]e���T&aPWh\008D�>6�	���F����׻�F��I[��¾!3��������O�^��ikɘW��\n���Dm��P��=�������z1.\"2!���?F:���ɴg�j4�?��1���?aI:�������~H�Rs(y�~�R�Z�S�	\r��x�2�c��U\"@T��3B�X�P7Q7���%z\r�����͚��s�H2�Ԅ\n\nMf�?��U\Z��*B�u��!\r���Mk)�)��mn�����l?�/��&�bLt��5jF$�|���ɲ!OĄ�UO�,��V�Y�e�N\'m4�F�ފp��C/?h���E��?�\r#�������� �1�?�G�BAK��3C1A\Z� W(�\'X�Vhl?�?�Od%f$�u�%���;?���͠GS�̈́% J��?�J?��D��?�\Zo\r�\Z7�!��V��Ѱ5A&R���i� XQ\'\n7�S��y꘦�I�j�8v�U�D�	%��tc����Ǩ^�I�(?^h��K����ʢ�,�Q�&ڴV��i޴Ŕ�*��V�lz?J�R�`��U?�Am�0��?�j��?�A=e�*��9��\"@�.Ի*m-�{۲������h�P��Iq�Ԩ�M�Ѱ*��.����!BլP�Ǌ� �)$G	Ō�X}�q��0� -��>�v�5RLJC��49���N`����)~�A/�X���?����������~�����s�s89��O`gF��S�	ԡ�M��?����P��<6)*�:��\\?*��ar�9�5G�g�$�4ښ�����%Pq?ɖLg%�H��P�a*�/*��[�M3��qЄ���!��Gy?bh��Z�\n��\r\n&ςg���D�g�`%rɟ���C�r9K�]���w�J��6U�?��PR�Y,1��c,�]$@߹2T_ƅ�r��B	�B�.��,��I�d}.�Et?%�S�����r%��?,8��C=J��\0J!�T}��_�K��������=�á�>QB}�J?\'\Z���e�?Ƒ͆v\0�\'ذQ)�R·���@>lw6ȅǃ�?J�:����(}!J_1ɇ�?�\Z/��,y�0�����=\ZW����z�G��>Q�q�%b(�Pʠ$7�q1�El(Q\'p1J�R(AI�b4lt�-�K�l(�08\\�xKQj7����J�9�DD�����	`�(���\"J������\0�A�?�%����;�߸$��)ƉâK�D\Z\'�y\"(A�l��c�?���*�t�$?6�aq�wO�J8%02����ż���e��m8��#�g%�nX���\r�a\Zb�`�4B�S6�6J��?4�p/��|�s\0��&8��|�#K\"J�]?�[���Ƞ��#��>����\\z:|.�s��\\ѿ��1��\0��q��\0|�1�Ǡ����c��?A�q��|�q���i\Z�q��|�O���0d\\�Q���`N� �� �� �@B J��1��1��1��1��1�i0�Ñ��q��|�q��|�q��|:��|��\0��<��>�y��|��\0��<��>�y��|>����|��>����|>����|��>����|�\0_\0��\0�\0��/\0|�\0_\0��\0�\0��/\0|!��X\Z��MÆ��b�M?\0�?@?A#D AB?D AB?D AB?D 1A�b���ŀ/|1��_�b���ŀ/|1�K\0_���\0��%�/|	�K\0_���\0��%�/|	�K_\n�R����/|)�K_\n�R����/|)��\0_�2����e�/|��\0_�2����e�/|�\0�r�����/|yӰ�?6�C\\d�D�?�%%%J>���R�EP���@)�R��\"�	��E�+\\��\0W���(�K`ͅ�F��/�v��bhĞ\\1�C�C���1�_�C���1�_���\0�p%�+\\	�J�������C��\Z�\0CKDɆ�%JJ4(���Y��|�.�R�J1�(�Pʠ>R\n�1��@;8�����\0>�9�O��9�Oo�9�?b�l1.����B���o.����i:�?�υ�s�����q��\\�?�υ�sA��ăa��v`��?A;0��\0|�1��\0|�1���k�ojz��~z����qp6\\��AQ�}Z\'�9p?K�p�KN,Xjb����uV��?��j8,�\\(1(a�\0\'��C����K������u4.Г����˓���w?�]�U�W��ج_F���V��F��e���o�oj�_F���V��F�������?o�/#�U��~S#�����[��\Z�c2����(A\r�u}!��㘄b�c�M/���B9�Y\"d�M-�r\\\\�?���S�h{�\'C��<\\F�C0��#�?a�m��h�\Z��0���8(��}\\(�p<�3#��v���h�V(F�+<�\'_\"�����Q.C;�<.�k���9O�6��8ڹ�T�y|�ك�Pzy�$�ar�c�C��C��?ˇ�c w�/	�Bz?͂�?��C�,<!�J��C�G��㈎/D��|)J[�KQ��\0�B��P��@����?�%�\\$���i=A���?|�/E�t!���2?R>\\ �qڧዸ�>?\0�I�A9GB	ڼ��h�����y�1�G8�}��O-��pxR��!��Α65�1�?�yL�C��B>0�P~2�E9��PJ�\'s`�A?��	��#CF�E�bB)F?��KH��(��0d�<�9�ZC]�M/�v��4(�PF)�E�K<)2&>�rf�8J��!�?D6\Z��&$��\Z�<B!�$��Xq�I�b�نˑ��e�S��	�?4�<	�O�v��J���$0�(�P(@I�R?\0�	D(�_�A97<)R2>.�� 9%T�y?�E(1�#E�lBȃ�	��rBJ�F�p8�M�@��hG�t\\�rux,��<Z�\\9�WL??�}�? �g�w6Jl�Q����*_���y��(wJ�#g#d��G�J���(Q���<	N���agˑ��l]\\�q�\0�O*ij�c��\0S\\�<�����?A(|.�T�Y�@���@����W�r_p	xn	�9p����,�?Q���F�&`��\0eK�!��!abr9x&>\Z2{S�2!(��~yC/�����!>8xl.��19j\'&Gٛ89���X \\�q�f\"1�\\���/��� \'�����P���M�٦� r���Q�%_�f.�S\"�NG���9Bw�qQV�\0�+�<B�H�\"d8�I A�W�fr0J>�Ō�\'���G�Ԉ���?���h$ڇ��\"J ��SE9PB!���B)�(1�?rn!J��y(���\\���0J�����)BN\0�� ��F�?��x���o�ll�c,c0x<PB�� ���W\r\"��<	_�Ǒ%��Q�G�Hx`��l��p�,��?��Я����8��T[�b�^��C8Ӟ�(gTTp@�Kror%��\r�J+N���R�9��,�*��RԨ-bk���\\�\"ux��6�u~�n7ZP���?s~g�gk���w}�,s�0�?Z�{m�Y�}\Z��Xi#��AP+9�Ku��w\niN�����t2�T?t�xEy�B\'�+\"?��PVD$�2_���@�ZY\Z҅R�\"jK�P�(��?)z4v�\'�*?�L�F=��NA%�,T�~L*����XY����а��\nG�uPIu��V����PsWh�?����n��N\'?h%:�{$:+_L\n���%���o�$�Ť�>�f׊uJA!�>�0v�i�ơ~����J�l;o++WDM/5�,V#�?&A?�8��x�g�Bgn�z$h@�2(r$e��rZ�,*��1�Bm]��u��G�5#�*IS�yz}O���X?�I�?=��D������  ���%��\nה:(\Zη.�r�?�t�HB�0�U=^%U�zPu�ѕ$�\n��[%%A02�t0+\Z�Y�#�v2	t�Z��\"��3��\'\0s��IJ��I��:��6tHZӱ��U���$�I��]��J�jN����YVr�ݺ�n���O�@�\Z������q���\"LJ�p���W���P�N_�\'c�ml�0Eף�2ݠ�${L����ǻ��c�8`�D��KY-?x�}���U7�?N�V}h�F6\\*�SŠ�I\Zj�\0��??������?���&��	�@WQ]u�רU?vFգ�\"�:��)di����^�+$V�?Ps�(�??��hgG�@�>�`l?|��E��GR!�,�J��ۡ�{���~w�J\ZQ/�\ZDm�tO��u�(cK����D\0�HRue�D@?`��\0�T�Ǡa#?�AB\'��ط�g�~�d�g�v�/Ԩ��>74�J.2G۷U5(�7������b.j�\n�N�D]Am�ioE!����C��b]�����Tz?�.$3�8��5�U�����	\n<�ՠ˥��6���;�?�u��rft�q�*���v�:�ʞ@?�� -N���7����Y�4K\Zc�ӴQj���+D�N$a`�Y?|9ˠ�p�w�2�Rՙ�:��C?�FT	�rmt�*[���u��m�و6�5I�+�z�#HGVLm�P�ʩ�+Q?a@ѵ2��;?V�bR�C����\Z��At����I�d/�eS&B�ߢ^h���\'���ɰn����\\Y�ƴP	�7�~����Ǿ�}u�\'�Z��D�B��?�:y+q?���:�PU�%\n\nA��j)G#iV�*.?x�}��Zh��ld�%A%Tt�*@g|���kx?t��<��z$hd/U\'w�A��(9�OV\n�4�vz�5+��J���ίXnu8\"�7��*Y?3��R#�\\�X��d�A�(7�����`{:ɬ#X]*���Ct�?H֞�rX�jqk��JՑN��B� �m|uOUVm�X3�k]�cC��+*V����h���i��?,I���TX��6��I���0Ho{�6��,�ӴN�U8ĚI2$3B4�I��p��ʤ`����VZ�ET�C?�?��E9��l�֕�\\7�x�ec�?Xce)P\n��T�S����v�l�\'!:�J\Z�,E\r�Nlr���ľ�N��J�X\'�3]tJU����X�6i��/Ym�O@\0�:])z�%EcղeZ���?�:[b=0��OW��uI�̮�s<V��\Z4Q�4Y$��_G@��3�S5@>W]�ֵ��\"�H���H�kDĒ�����Zq�tP\'�Ktv-�Nބ:T��\r�FV#�d%G�%�U�w�-ǀp��Ɗ�3�eT�_c\Z�t\rQW�X\'�pkT�\'(Id�������TQW�~���h&�~xn�D#����=e��`�a�^��h�թ���1�c�*60gQ`�5Nt�ơ��<6q�1��t<[��T�G�T?s\n�O���1!lP�h{�=��\Z�թ�EO��حjT,���ƨU5�w���E+�2���e5`�I?u;w��ȡ�\n�9&�LH�\"dI���HLu�U?��Il�W,�=D����J,BE�K�ޡ�:Bls��k�L�D��� KެGZ��T�Z�;u�aL�/j���L�5v�(\n�.�U�?��)�μ�y<�RuX���{�+GB=J��g(u��?;�\\�\nd��fX�4�:պ\'fR���	�{$�4\n�\r�G\'H���?��a[�J�%�֒�T;�39��yҩ:�2���b?�׫�pN��:]�d�y&�Z}�؊:��J��!꤉x��k���I?��VbE!��A�r5�ʲ��Xc|]D�Ml���?�b?�$?��&������\'�3���\n��u����b��P\r\Z�X&\r~��5>�1`B��!�W��B?�Y*��X�\"V���p��ĭ�?�:�BTs��5�������+G�)r Ԭ�?�4_`\n/0��sS�g�1,+�L��\\c�h`U�CX���c\"��ԾQ;���4�����&�3��T	�ʌݺy:&�c�c]�0��4r-��\'M�˷�ޘ<U\\\'A�*�Mbo�{��3b�+Rlm㤔%	{�g#�=V�&bU0�N�r]ҩjg�ײ�|{��������Iʄ�_\'u�dluҸ>�T̤0B{�Ke���qz�n��&�L��Sr��oUx���A�T�	D;��頒AAM�1G��{Ǆ?��?\n)9��U���[?��/:n���)�$h<0�c�j8(l��[�0��ޠB����U���ǸA}�Mm��S��zX\\Ǟ��IH���\Zs݀�*��V�P��7�H#\'�dc�X�����=��Q	�|Ϡ�$Y����&4�؛�����y���/��N`�ܨn��Mo�Y�Ϊv��_�\'�?N%[�񸚳-�ɵ�*J�?�Eb�?q�+��\'�\Z\"��`#��	����D��f�Όn̞�Erg&ϖ~U	?��\\VmV�X��6%��d�GwG?);<�\r(ֻ��M�4?ߤD?�u?s���g`��11�D�)xj���Th�R\r3�.��*Ē�ԾC8�A@��?u(�J?0%1���jF�Lb��;t椔!�&O=߫$�м�I�?$�ì�I:�b��ެR*�RVb��{������jT0���)��?��f�O]�?!���\'�e�A�]��M	�M^������g��uP��#1��a#���(�ԋ8ժu+��	*����g�����V`\'�?�y��$a� (j��C��c;���r6�=X+�\Zyd�?Z�J��f�I��+�y��D?A�B��6{&7`�@5�\r����gO:$L�V����<U2���0�x�]?�,���[�ڈ�¤�?�9&��AA�L�g��ؠS�4\Zˮk�ȴ�n��ݭ�\r���>�L%*_��ك?�����5f���t�XcO�$	�A0T�����Jr�<9��h:?l���N��$H�����ب�5���^Ն̰V�^�\nk�S5%���k��.j�\n�:����nU���\rr���Tj�$(sd?DM�4A��f������.+����g@�ƒ�$&̦@��Z�\0�����S��w��Ǳǫ��\'�j�e��V4V�)+��W��I`cC+&�#\rN$x�iT��\"���\0`E�SĠ3Qv���t8��=�}&�S?�Յ�0�:���x�a`\n�u�8\0�\"+VR��;\0v�,.��貉;]$�n,?q� 4uIk���U��u\r?��s¹&�r��b�Y�w�\\T���)�?�������I4�� ͫ� a?��V�;��:(r� 0�e2G���)r!�(y\r*�4���7����6�U(�B��3��)���M2���\ni\rL�˰.\ZZ!��R�&�7!�?M�p�)7� ?��L��o�\0?�7\'QL���#S���q$��ۊ?�J��Ǥ�=7�Y��^nВ�T�8k|\085��\r�%�^u��$����\Z%��E8K]��?q�1�k�8@��A|����tJ��+�Tx�B}a&:L�9j�b��;�z����G6ġ/��f�Q	�y`\'�\rz��Q��L�8�x/$Z�H8�p�Q��0Hjtj�{���<��1ت�3�g������\Z�\0��>p_��)����hIc�(?j��o�W�+y0R~�6M�Tjf��z^�1�Q��K\'c����P�y��]�`�v��koPY�Xv�a a��5���T�N�iM�c#:&!+������eERI�E�������Ϳ��]�c?�	��8X&�����I%&�������	*���\n?.Z2�Tb&H���6�WQ씨?:XHN�Xy+�K��?�Z���\n:9�>3)֢O0x~�G�M�C�\'x<~�sRK{�n��Ӣ%�~l|��C?�ڭk)Գ�R�F	ƪҽ��9Z:�\\Q%{�l��ث(l%A��:}S͆\Z�Wg��<�g%�cs���e,�?�W�%�dW؞;7,˾dY\n8��	ր�P�_a�s�3s���՛�Ȭ��pv�FY�]�*9}�Z��/�N-L��P7x�6 	�D?)�y�?���jh�:��E&j\nN���|��A`��l�~2l�\0�����0�I���[��w��-+	+_���[�\"M�\'J?란8��cB�[��Y�\0.��.�֥h�m�J�R*����\'�މ8��%������0�\'��5jNU��/R�P�\0;�������1.{�Vt㛠Dݞ?ƙ����<|�Z7�#�c�.q���e,�G�?�u������ds�x �\"������\n<O��ײ����r���`ߦ�Z��oA?��)�?�?n�:�F-ĺR�Z���2�/S�J�a���4�̌>�[ڕ0�\Z���\n�c�\r�qOP�\' ����X�tP��?�grf9�=$y?�߳����R5���4I�?=?\'�F�*VIPN�`�b����I��O\"\\�3�آP�Q�+ݘ��hᜆCh�?!�E��[:	�;tٵ��	�\"�2�D8�]�J�$�5<Q6��j�q�|b�&\r�6Vl,�\0l�47�6V�?\'���T4V�A)�3ݩ�2�\'�:Q�\"�\"�\Z\0��ֶ`�j$c�0I}^�?�$�Pp�k`U��l??Z��?�yخ��|\"|�qO�?I�]�F�v*	o4�v�ߤa/G�_\0���E�k�[�51ц?�Ë�T4\0�M	�;{�X �\r���S��x���ˀ\ZƺWXL7~?�Iq�?�\rᢲ7�?y��\r%ֆ0ke��\\:	,�8cy�6�`H��*_�lU-8�n���ͽ?�N��� �$�B�?bw*\0V��&���&��E&a*pB9����|��t�� t̞x�h+���\"�����V��7y��?Xo��`��S��W ��`�n���R��zlc�u��Ix�2�\\l�#����11�3�jT��?�nL�;\"�B<9����#F?�K�eP��@;`�?u�q�? ��?L��uX��tc�?�Q�;\"�P��<�:)B��bPuS�Jg�\n�mg?X�ʥl%c�?�\'����7+H���V̬\'�&�Jd?KP�\'��)2�j�w$�p��D2��5k�/�S�+vj�?e��@�H2�H�c\"�M*\"?��\"�	�\r�#�&�9�l�B0��4K\rjU�g�f8�.�?�򵷸6�PZl5�?��)fJ�$C���<B�e??$�;��ˊ�dwx�+��=I?�K�3�T�Na��\r�l�<�N=�2��3�a�Pj�,ݫ$1��G`�v��rNQ�n%�N�:�-P�-����41?�H�Va;D@��<��6�8�r�u�<����K	T\' ��L����\0Ɇނ:t��\\c:hF��!�?�ap8��V�N�-�s�`��6���Ƙ:SÀr{6����1���@�\Z\Zž���6H4N��F��H9�#�Wu�3x	��$�+�+��1k+F5�����CpZ��VM@\"z��\0]���A��?&�� ;��?�G6�I\r!�c\\�N-VL�ф���fQ[������l��J���Sh�؃��@���H��nڮ+b�@{�)L=ַP\0�R/�j$`����K&Ae�?n�\Z��7c?�J�6�x?{o3������/�\0��??�$Nu Mg|X�#�X$����?J\"Y���.od�?����?�ɓA�$��K�T�l�[��ED��AP�w,�}+�1L��bv��M�n�e��?9�Z?�\r���lt=��A5ݓh/%���0�\Z�b�$��C0��U?�?�u?�����`�ߙ���V!\"[�M,lu��^?�&�W�������Z\"�Z\nJ\Z�b5ND(m\\f�,M2�\0�!��~���?+�i��8�dWf&l��\r4>��v�l?�HIJ�Uch���1�	������X<��?\Z]�c2��:V��\r�J�Z�;k�t��Yp�)k��-���Ӭ����@�`�*+��^��a���#<i�\"0�4_\0LB�sU\'#�o�Y�@Lq�z�\Zz3Q�^�M4��\Z�Y����`_`bF=��Q7�?����3�by�:c�:��{�#`#��v{ۄ\r��P�u�a���ي��m��%�܈?�R!Y1+�T�ʃ����`�l)�V��8X@|����\"|x�\ngX��NY������X��a�S�!j�Or��s��� aJ�9� SY)�>g��U�\"^�[D\Z�L���:B������?t�Lq�Zw��j=εH`�|��O�Gh �\Z�xN�\0�\n놬8�z���t�y�ٮ�\rj��@G�y\nf���Ȟ��LuO�K���4i�*g�ZuE�v���s�uĳ2Ȃ�\'���<SȻ5<Ίp�͈)H�l�A��h�\Z���0�$\'n����IJ�?5K\'?���\Z�0?Y�mA�\Z~gLEȸ�?l�{��lXR��\n��maJK���0���<�?�/A�\0up��Z�4{���H��@?��7f\Ze�3�z�\r]��F�*B$?m@\"��b_|I�ꦲłɎ���C��J�	��?6>�If�̡�)Zs\"TYW��u��s�0�L��Y��_�Y��u!��uEf�\\�� �Ɩ����c_�qN�)=�F>��?\n�N�?چX�G5�s�ŉf��$(i⠰Ya��(�J�o~<ŋ��R�Pe1�$��ά	�ǃb��>9X�\nV�\Z� mԈ��È��Z%I�	�#�O$=�H�\0��0ȬzC�I� �&`�9J\'vnЇ��`0#�Q?4l+0&^�8��D9�B�F&\'?i�4ة��\\a>��\"u=(L�%��}��f�?V5LX�*?g�PeN0��$U�=f�T8�rX�K`{���;��j yۂ����8NR�3�\Z�!��2���?I��\n��I��VH5,8b�e?B;b?$�)�4z<ӆ2{%�?�œ���e���B{��A5㈮��8\"�*2?��?V?�DB45vzUV�އ}(�gc\"XC�r�Eȟ�AK<�@�E�\0��@G283[Y�R�?�6�O*+G�\r�b�\0`��C9�U,b\'�̹C`�y4���0ە?�S%�L�	�@�*���3�����4�?ă��ao��EV �c�\Z�1ǅ\Z&�:\'<�	+�v\"��?���i@����V�r��i1T��eU�\'l0ɖ��9F}\r�H�̔{P�A��J�VX*<&yo�_�$����M�}�?�=T�7�$m�*.u�Ux��]1�n#�yk�BbM�Wp����P��2ȳ�\\a\Z+,�ÂW��@^�\n8�B�����!�.lT(\n�eC�a�\"K�z^W8�\\n�v̜Q�`��\ZX6�\\C�бee���^�$l�bml\Z:y���͠���\0���?.�7�>0������E�7{�>%OdVoR��`c��2��KG�RT�V��6�:� �T���:V���/�%�����\rPf���dŹ�F���Ƽc�4�Ȣ&\"���A�[�43.[�W��gi-R?R��T��e=�T�tZ ��O_wT\n�D��?���?�������\Z2��q�`�K�vX}��L���аb?\"����1qp���fD݈V��d�Bx`f��}���X\0zk�1�x��&#O�`�4�N��1�Qך�C{R\0��^0�v�l4�3���W��$�c,�	��25�@��z\"%���\"Y?�w8)	t�Ӡ�\r��:�`����\'Yid�U�<�5����-��<Ϭ>�����.?IB3E��LnX�`�JP���0`�6]EL���E�K�C�~l#��D�?�+ڰs���&�\nR�\nÀ�<��y��C�{L�Cmo\'(��\r�v�\r�KTCn&k\"0\n�����k�A\\��uL?�Yņ�.a�FB�?z��x��! �.3�N0L�?��0���	�c�ab��F.�2,?d�C.���?�?c����P��;6*.7���V��2���L���/`er�	s��ach1�8���ZB���J,v5�l,���r\Z��?�X?�h�+F�1`]��$�1�6x�D�S���׆�15��4F?��lXs\"���ۨ�?yg� ]�<�*�DIĠ�Mr�[?AZU��]`h(r;���truV�(\0`�\nb�\rV��R�:&%����E�oF�?�r8Q��>%�7Ӽa����P��K�c��t0*��?���l�y�\"�G?]��`2�A�\"?\rѪ*+%��N\\�	?�2��1�ܬ�$�`Ҕ�5��%���1�y�d)5�ߕFpkNB�ӥah%�B%?Cx�l�y.�J��0��9r��=��ؒ��\\y���4��d��p��@d�y�K���n��G� cR�*?�����v`h5pW�v?&R��?�H����y�K�T�y&�&P�n§�s��j1�sMUs?,ەY�@ƥ���3	rc�CUH~P?�p>��P!+V�\n�ǠtH�j��蔊Ψ�3��r�8�3�I$����;h嘀�m�K�ulx?��*h�X(���1�Ρ�vx�?aLp�;���?I�?!8<��6�r�{���y��q�_:���DB;�Փ��\r�~h4�����y`#�Al�O{y�<q��`a��X�B��%�uO�ț�eb0�4s�I?��y��o��?p�	vd�q�?p�`������E,2n�r�����I:cQ��w_J�W�\r�.X�0�R~�\06%��\ZS��\\;9�\\@	|t`�\"?�?ݑ�|��0C���1�Z?�?F\rP�[P+�\n[?9�}H�`�4�G��,\"�V��&J���ʨU0��M�����y(6���\ZGR-sKc�?��=k<���`�D�EV?���]���Z?�	F�\'����?�\rR,���%�[L�23g�7\"+_bo�XyR��L�ĸ1�%�m��=���%�Ur�70�7�\0JUJ �L���3	JC�����,S$p�?NI@n:jR\0�L�G�%�ӛ��X�P�H������;I��t5Q��@�\"�����k$W�ƈ<RB��F�������AC0���?�)���I2��L�!?^���7l0��~��4l���D�I�y6�\ro\r��!Bנ;7�%\r�9�pi�H��D�_���,|a��B���b%k,�\n+|äm��ˠ�����K���9��a��K �[��-�-m���,<R��(�R??�c��E��?��!ނD��0�Zt�VY�]k�o6�-�#(7�k-I�c�rh���k���ϵL&C?��aIT��:���S�c�\r[?�&�\n�v�p#���IB�!t�:���y\\Gcw��@\\����A�I=����Cǆ�+���<��?:rר:�_C�,�Ǟ�ce��JJc}�~��C�x?a�,��\"i�M�ET���\r�.�}7�����?�-�ٸ���uL�v�A�|o\r&�Cg�6��?@ag�/�8�1�\0t�&@ZJ\Z��(1�{��=�gNo��P	`F��@a3�\0C�7�?N��,w�c8��3?�`�s������-?{L?ϲ#/��<߀wl�$�� �^��/?��>���k�k�[:�&�\rt�@?\r�	�t\r��@���f�2�����3P��{L�>#�)3�E�\ZP��c\'�CĜ�ase���j<$�$-*�=�@u�ψH�<�rP�d�tI|(ϣ�F�?}�������?��X�3KNyhR�?dA+�P�#�?�L9�1a0�,�rL�\0p?�ϓ�?�1���f�DqǓ��?e��?��Ȯ�:\ZÌ����\"���A�\"�\0�r`�`=�Y�?RS�J�s�$����b&\"�Hm�s�i=qr���??!H��<��?ⴤ\"x�1�zh=�>�)	$�?l��q��@�sP�x֥�z<���Ck��|\'��7v��p�4\0=1Ξ�G>�~,�?���R�b���F2I	p�~�/�c�r)��c��y(���l?���2+��`�E���\0.Q8Jf2��r��xJ�@墺�\rVQ,b\\�,��T���/;\0�3�)��N�B�Hc���紖3���VZ� �����ˌ@q�j�#�%����z���c\0ډ%����\0\"�_�cb�%��K�-Je��Q�?ఌ�G���ė�Τ+��P6<4hI����\"Ʌ/��1f�\'K�zI�i_(a*V�T��?�ջ\\��\n!�W`�*��So�eNe�͌��Hǈ4���v��\'p�J]l���\n��r3�?HlL��\ZHaJX?�Ċ?����SI�S�\Z_%<�@|?I���1�z�Iz��)��񼊲�$X�N?W�C�\"�v\"&��*n���xy� u�~{�dv�lC�1��4{�,bK�z,�k���1?[xL�R��Pp�,{\'rG�;��\r)����\'�\0�+�]��i\'L�����39}� i�R#�1��x5�+�w�~��{����ԃ�K*`)y��O*�<���\0��f�z&���$�c�A_�E��\'���Ө���,g�WIbA.	g(BrKyL��d���7(4&U9�w��@�.^� �������c���{��xL���\\�v~9���\Z�#��\\G=��bt�nL=	���\r!�\'�?S�C�&:|�ԣ?6}�1��X^_+��?�kD����y�\Z{�C��7�jb��1e�n��@�Ƒ��GK��Jk��Y����$l�d����=�&�p}�Iؓ4ݓ�����!8�$��c?�~=�{)i�� �D2�K#�<cy��q?.�� $HF�u�?��Ǟ,��(yu}B͂N��~�8އ��U	�\\�XΓ�;��4a����?���zΣ�%?���I��O��)�\'1���4r���]�@n��?[Λ�?z[�1���6z?��炿�\'t�� I�{��\Z���z���B��V�D?%x��M�̞�s�=����-�W�h}M;X�>r���=R�`$���-��&o_[�R���E7����נH?\0�YO�9�y�R�_�cll�f5��=vuo���f�J��N���k��d��cʞ��ќYϨ�-�6?��=5��Ҧ�2Ɨ\n�6�>iz��T74j��~\Z�n��J@D����[�1{{��l?���}r??M&ORO�rO����R�*o?o,����I�?�<u�?��Q??���$��C?�qf�6p�6�~{���| m�-��E�l�F?x@y�|ˠ%W��l�-��&;#+Ex?��(�\'����[c�3�Ɔ�,�rk��2-BzK)��{c�nY�Hc�����=vw���o�k�L&Ì�y�HH�ܡcB}.��#;6�?7�JԗS[���?:b��@Ez��\"&V&�N|�ưc�C�39O}Y���$+�:81��������K�S?�+jg���4��x�y�ޒX#){�t-���)t%������p���t��^����p���-o\0�_�#Ā�{��x��9װ�����A�3�Is�I{�!G��!oCȂ\Z���=&�?������1�{��<�?�2���5�o��	��Ǧe>�-!?���(�$!�_��H��;�\'5�\\g��#X�\Z6o�XCm%�!I?�n`�Z��I8��?�9�{��9�H�*�ixef?�Y	\r\"^������e��x��T.��\0�\rBu\r��\0�H�TȂ2� �`�T��y��[��23�\\X�s�^�wr�frr�a�\r�9��|ҹ7��`+�p��B?�!�!0��0W!���rCNr�ȼ?��3L�r��y�mP�R��?\00�3	��?<t �E�?|��PX�o_�u\'`B\r�P�Ŭ�Ś�\\8%H�\n?\n� �Si(\"ϋ���	5�<�5�d|!0[J�iU�{[ޣ?�Xd���z��5?��e��N�\\�RW\Z9��4�E�%?��[�L�:0����u��R-�\"�Y(IaZ;v�D��o�?�A�P�$`\rd��QC	�GE�V��d*�?L{�_�9[1i*�T��������HC�.@����&R)�IB`(�zj;UPU��`�z.�c��L�f��`�A�K)�ITY#X�V��S�U��)%�M��9M&���2�C�hD�Β�0�����~�+?�(8(RH/%���Hb���n��NG�L�Rr���c�:u6K�?I48Ԝ�Z~��$l�id^p?S\Z��%LD»�H� 9k�~���d�T\ZȞ)Ǵ�`%<K@�=+��_+���,??��zC�����?s�;7&W)u��!x(g<�f��#lVJΓ)�{ȿ�?\'��H�`�\0|X\ZY�-���8�h �XJn&�.�ۀ�VJ?��q�\'͓\'�ѳ�{���Hm��[��4\\�Rxk0�J�y:�C�`��K��48@�@��(�b;�?��(�?��X��P�L�!(?~t^`�:%0��2�V��\rA7�R�~�Ӭ�������%+�����P�v�,?I�F\Z,�\Z�\Z� @��>&�ڰ��!S^H\n��A?�/DR�F���{�y����y�!�ԇ?:��\rX���-�*jĿtm��*ͻu?q�4\Z�/Ho$�>2�?���?������BB��\Z`5�r��)u9�Y,$�o�*8P�ր	1\r�Q�J�t���)�2�D���*	jO��k&K?Y`=����X$��zrKF?d�\r̤�+���X��P[�$f�]��L�\Z��\Zjy�{?�\nV)!*���F-\"?��:�k����	�M ς�5%�W.�PӮ�^�a���i�\Z��&um�$X�\Z��NL�R��4�k4?����ߵ>\r�{c�zn?+�\0�6@u\Z��?�1?��p���Q�?\0K�àF�?F�����b�I|����YAHO`��c���а�`*���B!Ҡ6�@�$���~�>�?�D� ���g���*I1-��x�P[�L\0	@��F)�	ڢVX���B���-��U?I\0���T�����Q[6�-�ZX\n���?�2�5���A��*l#@H�ZK�Şe�d�ghٓ`�-�@˞����X> �(y?�XZ�7��Bk�?z�eK	y=c�Qo���=�����\":����\'����*���?��Fj,�y��I`�?��4`2\r:w�Z�1	��?h|�P���?$��h��5��a�@����4:&Ty瑤#����H:L��3�H԰�ȳ?����WgS��,oAϊ�A��H),�r�΢���=�u$ۖ���)��4\0}������z��L���?�簒�\n����~~G��٠�L*L���8hPP �z�*���8���Ii,\"=�M�0�\Z��\"L-�P.E�<�a`?9�%�f�Hȸ��z$&O)!?Bb��?3�ȘZà\0��)64�\0�XJ�ņ(r�XJ�L�RR$р�?6�[$����?D�\\I��ր�5?�VJ]�������i�\'�\nRB���8fʶ1?F�<��\'fFY�;��Y��\nE�@�cF�7�D ��r�<�CP�)5���\'w[F��nڌAkt�)l�PV�\nYʒ��	�(b�?���G�b��>�S3�n�?�>DL�rߠ�C?Cɞ�OʒR�?WKQ��X�=	���sK!J���\\W�n?\"���UĎsc�&#}p�r̡Z?�!�:	b�1,\rv)��|?��|d���/D�ɑ��1W�sR���F��q�7O��,��.:��=�L)r�}�6�v���\0?G��ȯ�sʂ�QB�E�VL�Ӵ�ڞ?Z@�Y�d�#�wr��P�cr��FJ��iǂT��ZW\"��ۃ������w��ǚ��}*\"�!���r��H;?2bz�EO�i����!˂�AJ�WI���?�I�	;B�!l�����~_\Z^�ǒ��س#v�h$U�6DX\Z\"��(p��!b?$��F�8��An�X��6�?$若etg&!�e�yL�Rɻ\"�X��{y��!)�$���e�ɵJ������ک?]2�̮�=�,�%\'�Q�3�-�\"��R_Ϋu)::�d�T�N;So��!V?�3h-�HE��*�^2��a����r?>��?]~����InR�_�:�b�mA%K��<hᬭ?�U�4���\Zx.��?����| ��?D�>~g�:���Pp�R����X~�Jx$?��8���������m!bo?��#���,���)\n2a{�$���M��&�k�j;:KRW�c%MO��!:$��u#�&~���#��H͈}[��|	?j�W?Ee,̞����?:z$)��m��:�<,ض\"{��`i?�y���ѳ�����R�bR��d!q��]�d�r^�`����C�$+z$qP�B�s6B�a��/Fط#(��!b���#&ky.��މ��1X�G\ro?:�y��ַ��ZJ~w�Y	,?q@�z?�Ȳ?�	?0A3�D(�#v�{D�=a��Έs��_�`��H�`?�d%I���:�\"T�Rr�Zg�wγ�F:+��E$Id�G$��Rr]i����i�dޱ�~˻�ZuCa���R�B�Q\'b�:V����<�n!�Qx���c��$ψ�]�s^���?�Q!�I\'%�Y�cV@�*��y��~$0&��{�tO�?#?�+EL�ĉL;�d��#~���]��)y�Z�\"h�[���{�c-GZrKt�X��|BWL�n��M�@�c�I$%�`eHH��8_�����?9���=P?c痒��y�I��:�r?(G�\01�)I=ڱF��L�Z��F �豔��1bM#í\Zk�uʯ�#?��:�<���� ֨�5{\" ��f%�i�\Z洚$u�{P\'�Z��X[N9�>��e�P_t���5FY��{\ZԊ\Za�=_~�zV����\r)����y�2��:��F�4Ʉ�e�i��rD�����1��F��D�ZGP�\";x�[Gl�~6�x�#��=?B���K�?U��\\�\0���^J\"���K�C����C�[�2?$����#{wl-���vl���m�H���?5��%�W����@KL��Rr?��wlYɰGX4b�F�En�ڪ3.���\\y{\"vl)�ӌ��c%�Tɾ)�@����*a͓c�ä�=CJ�_���y�G]ä-\0��_Ǥ�0<`������Eua���kGд�cRv�c�ұ���_���~/hW){Jb�?#��Ӱ�e���1�\Z+5R&J*� ��؉#�RR	�-�!Eӑ?�F���q$Yx�I�d��=�G76�^��Rr{?^�\Z\"?�Hf)y�?��r��tf�P�5����΃}#��9�?�T(o��vȭ,(eI�R� X? F-B�;@�NN9)y���ҕp��-�]�s��iDX<\"��R��u \'ۀ���9�~1A�A#�\"��q`/6���?74��:eē`R��uh��E�T��ƙHm�2�M���:EXR?��~k�a?�hɼA-����&��	\n�.�P����w\"wX�?HƜ�;�v���sUHء�	va)ir�e���stO�2�Dd\r?G1�O�ɔ��B���?>Nd|�R��D\Z�`�H�����5Y�I�%��9P�C�� �M�\\?uR�>�#\'�=&݄�Wʜ2��-�awj�r�7a߯�:��\'\0�	4q��!��S��>B])u��3N0�&k�}\'P�	�ܟ�;�I�G�_�� a�M(�B��R�~��\'�j��T�Ѿ,��\'�c�JA���m*-_A�13�TɔJ�^(���������w��fSY�;�|KUG�w�O畖5�\\Z@|��Q�kγ��2,��GW|G�۱އ�3Uj�Od�O� �Ju҄�P�s�yɲ+��1�w�G{`b��=�t\"��+�B\'�l���tRr�]?�\naQ)�T����%�u	뜔�2R�����%6��?�V�l(�OW�4�W�O�)x>�Bf�!@�z��\\���2A?��%gIahwO\Z*�~�02y]	�l9��Z_O{�B�r�$��9�ԩ�0��>�?D��<9�<?�5(BJ^�$�4�GB���0@�&�\0�D�M� `��?i�<ߊzЈ���X�\\��5a�K���r��_� A %�)x9�+EPBa);���?IH�?�?�\'I\"�\0�\0��}	��D��RS�7�~U\'�rl�S���X�+jH:	80 ?�vj��~���?Rr�\Z5��^��!�6�?�I���/?VMQ�=)��X��|�T!�����$�\Z\'%�����1�4*?W)�#?�&��)Zn���j����-qM��X_�DB�4?F�R��<p�0m%Lfr���([J��\'�\\Sb��TJmd]�z)?�v=�u\\��ƺ����bfz�?�LtnB��Z��Y&%���H=������j�J5)Yk	�r�JBЭ�f��j��ԫ	n��5՚;��Y�k��~%ЮR�^V���h���3�+y����?@�&�aS?Z\n5��@�JYQ������\nUJ�?��y�f�?�Kʰt�1N�\'���aPb�J��u�AMj4�H��1���7���e�a��65jgO�\'�\\�5a�J�J��?��M��1ױ�7bP��Q��<���tJ�R_V$Ц	jj������P?�a�ʱ^?U,5�Ni4IFjѵA��a:U�[JO�]\'AK.������	��c�_��V/ޯ�9��Ad����Z�2P�Rr}�A���s��?�N��Y��?�I���/]�1·c��:V�N�<���DN��Sʞ�<o?��8u�C�+?�r�C���\'P����?	����|�O�r�%ʚ��<G����<��f�$��O��k���yH�	ڑ,�C�Zn�Nai$�]>)���!�M��	�ǄU+?vL�%Ў	����Ϥ�����|�\0��uKJ�*�}�Ԥ�J$MO̦^cl��:$\'\\���p�v��7��?���-���!��I�z�בYP�L�?I6�bc��H�s`����N%\0�	\0f�6s�\0`J�s��ܰR�\\1���+\r�~�!c��*�}j11Y(,�9?b�.�+\'n������/?x��+}�-��r��s��I�o����?���� �2	n����K\'A�e�r�����N�16�N��蚛Th��j��!��ԗ��q���eR�Ԩj:��pSam����L5ؘ��1ՠ֖��/a�a�R�(�(+����`Lᇎ�AG�����ed��,_�Z1\\n��\'��`8s)dq����_	�\n2���	R*yW��JWMAJĔ+�W�ug��\\���8��j �&�%a�vP��@�\'�Y����a\0E�r�h�����v��?�2�jm?о����?\Z�nT��/���4��%]TG��N�?ԖF�~��ԩuMJ�LX��@�N�Jnh��	Rf����`e&fԃ����a�N+��j�k%=ɶ=��/�2�F�A�K(�+��\nJ�\n\nrg����}n|�L>� xu���\\Ǧ\'Ëw�����=��Zc<�RLf����Q椾?��JG�����(�ac��\r:}oRO�P�J�N	j������?j��zװp�=��`�\Z(�[�9[ؼ[�4[�2A��Ny�<&n?i�w$!g��$�1={�|��]�@~��$%=�}zړ�q���c*v)ddP�S�!��o��%�%w�q�h ���E��\n����Y�@���?��� \Zj�����@��\0�\'��,\nd.	�y 3I L0?:?$:T0�U���1�A��av��dd_?��zC.��/��	x�C�z$x�t�\r�\rx`�h���]�;��`�t�������\\X��B�\Z���B�P��; ���u�*=��,��@K�K��J��*пUC���pC\"�4��P[�bC;V��;�5�����)�5q?�0��K0�??�\0�^?j����+��p��=�&Ll���� ��<\0B���Jy�J?�c���q.�)]JЌ8]��P��q$P<xF	�Np�&�9%������#�Mt\'�S?\'��LR�\r��?���\'Q?��cZ��)T]���YU�$#�S�C4�n)��F%8AS�ӯ;gg��3U%\07`��T������i%F�B	6�b�����\0��\"�����kJ`��`\'	�De��8����O7�#(�l�Xk�t�S�}�)��M=�7��\\�+ p(@��r�\nr�I�)�G�Ux�`+p�IY�wޚ��kv���q.<�G=&+�x��ǩ0u��/�o�����quu��ukg�n�]����<�|UMOMOO�y6)+������#�q�,+�TQ�nj:��We�ߎ�3ۦ���زcav�Ɵxݺٳ~��e�����w��?>|���_����?[g�mO���u�s��O�O�q�I\'\r�KN�o�?~x�w��u��~:��q��?�N���{B��n\'�v��K�/���|����!*�q;m��27�u��������g�Mo_ضc�������;7̯�0��avz�������ͮ?ݼ����u���n��$���Oo�ݺqf����[f�\Z?7�LO�=�i~���9y��w=�af��A�f��ur��y�qz��SfWSهlٰy�߸q�����+f\'�8v㎱.��nٴrz�k���(O)p�I���=R�?��\'��-�^�v��Q[�5�?Z?}ԣg6n�>�;��IKZ��j�c�7m�?�Z�q�Tt������7�)�6�o�|--�}�:r���-�f�7��r�=6�̾�-5?����ㅛf6Ϭ��g|�bk�ާ^fg�q�mڎ7x�xӦ-7�}�l����u��?��6^��tr�Te������t���O��i~��x���?�WO�׌t�}����\r�fg�L>^�����׎��~��IG%�b�&w??9�8��M�^7�0#-�0�۷H}Μ=grr��غm�Y�2;g�7����\0k�-�ʱ~��Z��&>cV��z�~ߵmv�0����ٹA0?v�\r^�y���-��K��x\0�?�O�^��X�[vj��߶E�y��s|��f�����y�q����vl�	7=]/��}���M/�m�Q�?��?HX7�}�̶uZ�M3g�No۲e���}����\r�Y���8kf��f��9��s�3�8cv������2�w�����l���\'��aۭݱmۤ�6�g���m��m3gɘ��.�|vf����Rʴ��&_�O?�Oܷ9&_%���k�_��3gl<G~�4��]&\r7�c������+�736�lLzd�v��������<����ˑJ?q1:�ȟ���q-�Q�n���ޟ���Ul������K���u����QꜾ ?̉vr����D�,��6[�|??�ð�t�i�{fE�L~�����O�����^9������5�k��/_6���L���+ׯ;~��kW��2w�V�\\����M�v�~���xj2C?���s�|�����?��|��K&�7��>n�*N�u:O\'R���/?k��:�N��N��_kL�ܷ?��?�?WM�u��Y��Y6�{�]^)Z����+���V�b�]�rr�Q0<������?�녛g��Gj5�\"�b��\r2q?\\9�2�{���2�v��g�}�]��W���m��4Ct��lͿ�\"�<G���;�\'�c��Ͻ��\'�ۊ��8N�4�*[^W�?�;�����&S6o��Q&޺s��y��u�̣G]oԙ&K�䚈l~?J�bI�hw-���W�߾�úw�e6Fo�9���1 hHs7m�����:$x��7j��\\�v<�ӳ۶mٶro;��6<lQIІ��T?c��I��;M����q�^�e�}�J��OeH��/�����^Ia=�wm_��wT�%T��u�&v�ѓG��+�32��Z�f%g��L�����ډ�m{�����}�Wf\']rƬh���M�\'��\rF�����\r��ֹ7GZH��p���q?c�O���Dzm��(?�R=љ�/�8㦮ҿ���=踟�G����u�[Vox����l?�@!V8Ή5����\'M0�:}rp�̸��G�c��?��kMF�@�n�ٺ?dU�J��X�b���?�kW���c��>r���#Wʡ�qނ8_�8�WL��?r2����?7��W�q����7�0��:�*r�۷n�����L���*{�}�Vm�7�\"��>m�R<Yڦmm��m26�&����̶�g?zڪ�\'d�~�ʥ\nϲ#��D�?�Wޫ���/�{�^���\\5����S���}�r|��T��Y\\���Y���j�����X��7V?�?�^՛�bo���d�#�,��?�V�E$��3���[\Z���7�������.���o~�����w#��[L���Vo1��bZ�Ŵ��ݴ�s���y,Mx3�~�?�޽ئ�d܌�fm��c([��F9X�Fd��ţ�`�F���}�XE��?��#odn]�S���n`��n��X4Ȯ\\��a����}�7�¨��w��+�����??ۗ��}�O�v��eGbNZj�;O�u���\'Wj���~#���p��뢦�}\r�r86�x�\r��[���;�57������_���kn��{��n*^��o�_�o����[7�G�����w��O��-��_�߸���3g�o�_8g��l�I.�azn~��D)_/y��w�o�U}D~]�q��m3��Y��?ٲqf����>|f�̶�cwl\\=/�׆����;��?;w�^�}���٣��vr���ƲԬz�S�����J�1G?9�x�M�m���m��S�� ��c�nb\r�q�̦ٕ˗ɂ2�u��޹�zY*V.uX�n��Bg�߸0�.N�g���[�l[x���W.Z.W�z�Z�?B�S�q�?U�Yj&�?�<�ET��-k�p�Q�@�/���UOZu��;6?1�?UO�<w�;m�f-�t~4�evő3[�Ϟ��3�d3���u�d��˞l��g��-��-�l�8�&wL�/ް�}M�!�<QV?A��-V��a���T^\n�&�#?76��Q;֮�w�^�P6>y�lZ1��4ފ��V�_��a�6��\r���7,�\\�rz��Q���m&y�^�y�+���[�g��[N��%�ۭ�v?ڱ�VyE6^1�gV�O�|ztc�C�����X��{�m�a�v��m�8|�����^{��x����-�֎Kwu���p���4y�}��g����/�����X:z��/l[زq�ܹj����ZzSV��x���x��0���&��\08s�b���-R�-�آ?���?��nқ�����)��?[���ޞ)Y=�8nJ���n��?>f�W7�e��Skwsj�o��{�ͮy�95?7�����w꽿U�P���8�o��i��p�?~bߔo7����7�;����<�9��7�K��f�ɇ�pt?Љeh\"��}t?�ԉ�۷l<k�xVɘP�l��M�W��y��Q�De��n[�x�z0����e�����E݇�ݺ����<v��U������N����	a�~D��#|l���*okF%	i��Irœ�?���Iz?�Dg�b^07-3��Q�\'�u\Z[�I��W�Dg��rc���_�f�^�?�?�I�|��o�~������M[d�z�����w�;�?U�-��_ܲ��e�=���?���>�;���D)��w୧�x��^�e,Nx�I��={��+�rn����?|Jʩ�r��S�<5577��:\\�O����O�+���17U�ٳ{��];w�ܵk��.����}�srZ�۵K�{�u���=�[N�ٳk��ݻ�/����/�-���ܞ���#噻�]s�R�;�[������#g�v��37>ejj�ny��cnW)��O�3�%/�5�?ϑ\nO�2�K��{�%r׮)y�%�\\�gw�{Ϥ�sS��n�W�]85u�\\#o)�=ROy��=;�_��잒���1���P?�`9576������rɞ�x����\\3~�xJ�;%u��\'�{����7,���GM��Oˇ��>��W�٩���٫v��e�����?�;�o�����?/<��]3S�o�c����?|�/���wo�{��g�~��;������??��?>���~����k?��o�����o�{�7������?�������������Ͼ�����s��_k>��������.<��k~�9��u���o�}���7�?��a���_���|��U�g���������������t�cW��o�^��֧N�p��<�_��;~�#_{�=_|̅���%o���w}��?�5�����Õ_ܶ��O�ա+�p����U?�ͧ?pX��OG�ƧN=���n~ş����{����\n��?O���[_���3:�Ǘ��ro��W̮=�ÿ��_����l��^��K����ql�������z]w�Ty���?�.����}�cy�S�����=-��/<���~��o�����A�����Ú�<����<f�şZ񑃿v�K\\����w]����\'��y?ܹ�=?��_����w��q=��ϺͿ��3���C^|�o\\��\r/����~{���>�m\'�{���7O�����NG�y�9�?��o}�:���q~��}����_;��G?r�U}�|�����ڳNXw�e+~w�e��?~�%ox�=>��W��o9����������kμ�?��e�Y�����>9���z�U_۽y��}�e?�9��?�ܿ^w��}�^?8�ϯ_5{��ܟ����޺�n��;��7���\\���=oŦOq�G�~�G^�?yȋ���w���Ͻ�5���߰��|�;O~��;��ݾ�\r+^����O}�k�{����r������%��?�oG���?��s��p�_}�\\x�3���{�~Ͻ�����6?��U������~�q�륧�|�}򣷯}�S�}�3t��/9�����٫�/8��8������;��7|��/\\��{�/o���_y���=��w}���q�uW�x�ԟ]��\'y�.�9�;s~i��W�}��7�}}�mۻ�Ywb��_����]����-�|��}�������?r������+��������[_��\'^��C��?��}�;_��������+_���}��I�<��ÑW����=x�ѩ?|���~����~��Gzn��w~p�~���3�f��x��c?6{�[ξ�����s�_>��>�A�n��w?����z����w�s�G}������O��+����?�o�����|�����w?i�S.���?�s��\\���9�.>�}쓿s��6�:�?�~c�C���w��ןs��x����<yݹ���9�|³��?\'^���}�VS��ϻ����k?�?����.�vާ����\\�wS_�?�ޗ�����n�/�?��s�؞=u��\'���ow��7?�����_�������/���q�ۿz���^�7���\rW=��_��eϺfWs헎?����խ?���{?�C���������;�����;~���x�����W���?1t���zr��ʃO����~ի/9������??���/���{��+>���o���Yq�s����{��ל����_s��^��k�8j�9������\'<�=�mQ\\��g��C�������7�=������W�u�����>�c?x��?����?s�����_Ix��m�~��sݿ|���\'���������������\'���?���KW=���^z�����3�w�S�}���ǯ~�+���/;h�+��������~�o=�\'=�U_������/>S���w��IϮ��p�?�^x̓>����G|�w�ׅg�뱗���\'u�g\\��?l�V��Ͽ�[�}�?��7���߿귯��l�3�?~��/���z��/�G�����ઇ��λ�r��/>��������S7O�xy���\'��+����o���/���9�������f��_v؎{��>�Y?��K_���^�b�[�\\���\\v����h�+�v��?:������������ٷ������?�>���_�S�^wҷ����]��k�}���9[��c_|ȡ��ۃ��\'��Ϛ��_?������k�-?{�[�|���?~�ٯ����}>��{��~�����3�|���S��?��O��?������빇����?���y�=N{U]���So|�S?{�����ˎyߚ]���?K�q�����8��������_�7�����ν>{���^�އ�i�#����ͫnu�?|�+���[o�l���9�~��6�{���^~����>�S�>�5�{̡/��Ϧ���u?p����q�^���o;�v?�IS�{������s�`K��E/���/��!���?=��?9��N��/��ܗޔ�����{�����w~�G.Z�#�ܮ�oN5o�r��^��/�]w�w�?�v�������Ͼ��ֽ�y_[�甩g�v��/~�U�_��\rw����|��v��s:���^{�q�9�o���7\\����O�|���?�ӟ��?\\��{��W����\rϽ�?�O9\"���Ǟ����?��[�?��>�*kDcae���	Nz7$!DBR(�\Z^f�L�����?eѵ˪��{CVWlH�*�EED� 6�� ��sν��73I\0������O���{��rz��xo�.X�⡳Z�>�wU����}g�w�����ڽ�S���}Z��r��[��5��>\'�]v{沂yy]���\Zz��7�?>��\n��تj۳�E�	-�}��y��}��?�V��r��g~:��;f�Z��㻹��F;y����z��}N��x���=��ċ�:y��kk���۠�k��9�Y�m�x�ůn~���+/hܺ���f?��_[;�o�����E�����[N��28���׵�M�s�a��Z�����f~~Ö�a�[����=�ر��;Y���E�<>m�C%Uf�m�����lxq��U-�\Z����O��}��K����0�ſ<���?φZ?mf����K�t��o�g?�6���n�jmYu΂����Z����/�����;Bm#���t�c�����6�i�[��4����������X�Z�-js�u�G���?�=sȸ�S�N9s��G�l�骯���KG=ڠ?}e��Eo���5��n��$�1�?�+Fw\\�?��<����U__9��@�C]���x�]�i�����=��&���9U�_5�p�9��?��w�G�?�$sϟ�]4~K�?-�Px�k�}�K.�����fe�yu�g,-��Ⱥw�fN��8���۞q�/�s�7?=���Wt߈gE��6w�h��^,�d�G���<��Am����k.?���_\r�_ڪh��N���겪��w��i���z?1�Ъ�o>��!?�;{�g�f�_y�Y�>���������������7�[z����.��k.�8=����o�[��!nj�s�G�Ag�}���i��v\r�{��g���z��^��6{~�E�:���O����%����`�ȷ����pC`]��a�o̿o��m�^t�cB�_����3o��_���ӌ�w��ӫ��MK}��S=p��#/z �pW���\'v?z������:�=������_�)��}�!/��\r.�e��b���C�Ͽ/����NWni(���C���%[��?\ZBs>������;��u��=3\'��U�so�������������ú�z��W��ns��r�MeO�����5r߹>��\r����ׄnڜ}�E����ùC��y�ⅷ�>7c����wkc/�W�{���+^;�?��[�\n�|����\n?��sێ`�[���KwtY��+�wZ��๷��j�+���������v��m��wv/\\�7_��y��?����]���Ne;��x~]���[�����_��߳��Y}�]9�o��0v���O2㻎��F������������?/ok��_?����H��qY���	y��=C����_��[��r�C���\ZZ�����W�>��?�:���\'����m�6�i��Cq��f�~)4|Zժ.�~�l��{1�[�LY�g���zyۆ�/\Z���G[?޴��Ic��rr��?�j���_^u�ys���i�\Z������)ޓ������<�1=9n���m���ƶ?׾u��17$�>h�7�\\G��k׃�>8z�/}3v�Z�u�cVoj��n���-����ƛ�l������sּ�q�?�W���kg����˺���K��Y�,^vd�񳆬���t��ik���z�n��ͮ���i[�/���5�\r1?[\\s�}�GJ/:g����}�9K���~�������gx���\'�w?����{�\Z�Ԩ6��<�ͦ5���&�!���;���D�e��w��;3�-��&4�?��<}Y�ޛ0a��E�����KW�y���?eV3�c�g�|���A����mm�}����ۧ�z%�|��?�W.��|��	_�2BS��Z=q��SY��G��	�?���6�q�k�?�sO�υ�^���Oo�[6o�!s��Ӗ}���-�i�����Gψ=�A��Jn��:o��i���ϯX�os-=�s]��K��*{⚙��tpF���W�9j�؉�6,�\"�\Zt�?n�$�ziQ��ͱ}�L�p��U��t�n~�o���|��e�<��٢��������O�w`��n�=�?�	Fo�����?�~��7�����.����kk?Z����Tr�IE�m�q�	O�1�o9W?v�Bߦ1�~���7�ާ�	m��,�:��I�wWC�Yc6�l���6?߻z봙�?^������ئ�w�w�.:�x����:=Q�z��;u��r���ퟹz���g�=�Ç>���~L�7�w��uS/�D�p�K7=�p�6O\r>ᛪ�5�IN�xG��n^�f��wL�j�F_����}�����zn����+><���O��3�n�e}��~\\�b��Z�罇CC\Z??2����yq�����?�m�y�,/z���[�d�2��g��|Հ:]���;�?i{��}�O�vh�\'��s7޴f�Qۯ��ݎ_x�+;t[c�7m�ifwx|��Coy���??*����.<���{ޟ^�n�	/��dİ���+gκg����l��1s7\\���ڲ�?5)�s�WK;t���K��3��y���Z��{Ҁ6\r���/i����λ���\'L�d�\r��d�y�_2~d��Ոu�\'j��p��Ov����?W��q�����x��:��qf��j���s�,���qĵ+_���i3�]������|k�+oy�ح���?����+\n?;����?woW4󾼧f6,����wT-x}���\'�m3g`ݕ��-Xx�Q����I]�)�Ε?���3��E���n{|�y�v����9_]�ɽ/\\ڧ_����5iH�W?�Q���e{�����?~� 4�o���z��a�g�y������w��?=����?c�M���<�e�鳲6�����������܃�5����N\'OxK����=ݶ�2��M�?���\n︾13����&�??�~�ԯN�%�8�?�?�����s�^�ɟV-~iպ�~8b��|����m�/ه�-{���f���Ckמx�3�/|ǖ�;yO��=���^2���w��YV<���K_>v҄�Z�ƕ\\�=��m?�O��v�B?v������oΒm�]��%��ߺݵ|��k]w[��9�=_aO>w�1�ݺh��?��.;��#|k�y��7|?���k������|�M��;���֑^��#g���]�k|w�y��Y2���/_,���/y\Z�?ؽ�r�5g|�u��?_~eî�o�֩��6eߺ�v�y�|��G}�-�0xޒG�7�|E�E��1�?���Z��ܞ��3����玮n��ƃ[��u������K#k������G�w�W�|�~�)3�/0�:��kn�d\\���?�ڞ�H���??9g�%Y�\\���yc6�����n\'?n8�a��g�G��z���}r�ow�]��w|o���B/~�}�hc�W\\3��g�=�ي��y��#�N<�M�6g�gƹ�߾����?|����W^M�qҫ+�?m���w���u��?�:��u�_�q�6�e[�Z����7�\\[�b�SG\rZ3��?\r�տ�53/�;��A�=wR|�}e_Y��\rG^{�w��w�~���w�~\n��5�����օ~�yEŇ�Ɵ��?�Z=T1c��n^���#z<3zK?Ms;���r�޺���=��I#\Ze���Ow\\�_wFm����T��mO���/�V/�yy�[=o�th;��a�/����6|wٜ%�x.��x�[�3;��߷K��o|{�k���ߦ�{����g^]�z懫^/>䆻�Wwz���6��g�tʖ�/���?�{�i�.��õ������_O;�n��+�sH�����⫬�;�4uΡ˷?��Oߣ_�\r9*�?����Yu�+�\'��<���o�3�?�6V�r�Y;����Yg�=j��A�u��Ĳ׶�|���=㶜	?l�e�y���X������n~��䳳��~>���?�r�Im�?>w��3f\rh��ߣ/����9?�=������RUq����yOc?�_��1�ו�__�~�����r��I��\\�)���i����i#����6?�}�������_y�~^;����K�}��/�{��E3������+��/����[���=o������n���9nXM~�s�#�|���W���{~��������_��2���}^|b���l=ai;������|��y��?����z��Ы�v��˭?v������}�]n�^���u�6,�zLC��\'<Z�����>(:b[y��©�\Z�\'���M�]|���^{��/o.9���f5�k�ꃞ�z���E���|��A�_�����\'�E���N���9���?���&��ϴ?�\'d�a�����8��+!pP\\XZ���	��D-��9P?2�-/B�;�;��h6�ףO��=��_������?����O�^���\Z����?y�?�G�(o�,a����P��i��)`�32��P�F5M�E�i�X�5VP?!ʞ��\'��\ZM���q�j�yZ����Sk�hy�%K+/-ri�aA㘡#�i��z	LQ�0~�MeYPP��M��a����?e�7C��i�t*�$@��?\Z����?&�a4��zKk`�F�đ:3f�#(b|0`����/���\0>K�x��1j�ڨ�`�#(�:�ղ4x7�<��ƌ0����4��bkkLx؂e�e�\Z�x?�G�;˭6�?�~6\Z/��\r.l@���\r��\"-��(D��P�\'��ω~6+U%l��墀ϭՔSe�פ�<V=�cB�?Sf�o��\n��k��p�JXZ�k_2@EdX,����;ƱWz�oF٪�\\���-�,¸�	y��M�7�V��J�`<��\n��U��u�a�\0^?\\ȶa�`%?h�!C�8��?�A8\r��bR:V�Z�n�\"���D?H㯡�blŃ�I�\Z0,*Э5pwؠ\ro�/�nϴ��T��uPca#�Ro�¾�o�\\��)?�r3ޡ>1��Ev�Z��Q��z\r+\0pR1C�`1�T\\���\'�&e$�>ę?�1��\"��hܨJD`!�x���]xk(���|!lܩ?� |,��(�\\\rt?lX��v6�TI��*i���:8m8�D9d�Ì+�x�c3�~�.JM�V��(4`4F�:V�\'p���a=��l`�FD?��[�� &���l��:G�X���?�)PZm MU�F昲Za�����imL �ƧU&��p@�?ѴL��,��Š�*(?9e����X4P��Ƙ�:�;@��	�A�	�*���$�џ+ ރ�e�6��`�F���x؛��,U�[��E>t\0T�.�Й�cKx��u�a�,�^\r���j�l�P	2��]2�!K�0�aGj1�VL���c�?ۙ���N��ߛt���E�?M��ar$\n�*Bv���q���G�Kc��$����3L���F,�u����0�U�[L?��`����\nl��ĭLR�?�O���g3�ѡRZ|?Ld\"�E\r��a?�ܢ徸=�B����nzPs��33���Y<�qtIVl�]�\r�Tq\'4���\Z���#uz������!�����k4\n����Ei()��|�����m3���9|?[��z�-D�rKٽ	)J�S�/�8�=*��?ՙQ�.\0�2Pθ�D\np�($rj�É�=&�$�5�#,��H�$�g?ϔ�z�ZBo��P��F���m��d �f�m??!1��K��&a\n��U1��D\'_I)5���t3b�ǌF\r��a��5�e��*���Wi�UyU�#K��ae%%ec*Q�J�K��Z��$�*e89xh����%��/���ҘE�03��1�y��p=Z˸I��~�1��n@n���;��!?oyϜ슊�9}��f�T��\\�8a ?Qǀ���9�i�q7;V%�\\ax�(S=uT%���rbr�K@.��?ѣa#�28P���)bX�U�F��Y-�aR!󥇤t�!i�ϴ��^l��x�B?�kC\rO=�J \\�=Q~�O6�?��\"7Ç��m�IO���s=��ֈ���:U�3@��9m�?2b�*���ѠI\Z��$��l�m(CS�S[�)g�)@*�l��tTaj?���F�#A�?+!�R8t6[	8��0T\r4�PȈz��H$�?���%�W��$�aR����JlB=�u,WD~ɵ\"����?�P�ZEF�Az���{A���9C�V�b�h\0����1~n}��I�u�wV?�A���\"�<(dk�p��B;[������o\'�B�z�LnN�V$���!�&ř�x��H�[�\\���,�8b�\\p[��L?B#ɠDy1�^��3���?�Yt�\";�)�\Z��vΫԊ+�?k����`0\ZAFA�\Z�t��Z˄�L�ynP\'b�y[�D�+K\08���~��BX�oU\0º22\Z��zl@m_ ��_`�ta�H??2A��\Z��\r$b�~E(��Dl��uN4?���?Z��]D	�?��4�a; �J�S��:��&� �?��6�i9:[5���l\Z�:?y�`���?3������l�Q]*�4*&�(���$\nK��aZ\Z��ة����=I^+��1�d�J�i�R�LyoTo��?�?�����|8Q�\r\\����`,A?\n�I\\��!�@Dg��8�j�N _\\QL��\rQ���r�v?Aְ��=3\n`?���j��l�Gi�l\'ǘQ�q??�W�FR8!�s6�r�؅X�)���Q\0AFbܳ�\Z(TKM��/��5T��^l�PH�ك�2�>�h!!8�C ����d\rQ��?�����E~�\r�i�2hI�{�`Z��=���9�_��m�+��ɇ\r`g`�Q�9��\0�{0u=���lfW�gL���z�%\0��_��?��$NIlи|�@�� Z=�v3V;h�Я��?��7��Zn?x�wI�QF�b5\0��8C�׶\'����̎s��uw˼�(r�G?ǆ�GK����I��(��7[��I	�T0�Uƌ@��E�&��=�`\0��e��3�qu���ݨ1)bYܳ0��F~Q�P�%JiU��;˾\'�0Bo���4o\"���n��a��%?%�=��u�[�ɟ`-�l���f�{?��޸U�rx/��x,?����u��S��Ԙl�cf#cmL�2?�XPh�6�-�nA���ƣ�.������=��F���~\r��@Q�I�\r���ϟS��f7ZE�ر\nD4�#�=��~|	\'?�%�	�\n�%�#.ш.d�1�Gm5��ѫ�\nA=�g?q�04�-,�6�q(@\n���g��m)6���\0��0�?�\08�fy�?HL%�t�p:s�v~�N6�\r�f���+�@��?m)����!�R���ߕ���1�PX+\n\Z�4?$��z�P�?T\r�W(ٸ]���e��@S?��\0�a/�����:5|a�\n\n��U�T�++�*ϫ\Z����e�-���>E�FF�Lr��c�\r�gz�bh\0[S��H�V\"Tk-��0��>l\'BC�%�?�}?Fx?v`D�.\nJ�E�������(\r�b++��s\n��!8mK~��%�nry��� �^�$\Z�Bp�8@��Y �������(쎖�݄�,�����;[�ydV�E�H\\t��1&DV-G��+,�bZ��?��u�3dh���I����I͉h�k\ZjC�G\0(�j6��dC�\\�/���>| $:9�w��ia#S�?��1>j4���ʴkO=)�u�rض����䦬�������w�q�(v�e{�}8ɚw��aZ�>�?F�p��?�?~7�T5Y��.8`������]��$�?�y&��G�S�1R�7?)r�B{	o\"�i?8�Eɷ	?<�Ńd�P4N\ZT����\04�I�5\ZC�ԠK,go�r?�M&�Pf�`ߣ�9?����?dl\"�����R6��5?x��8��8I��g��c/q�֩^���a@���b����h���R��Ke�m�EblvBii�}��z\r�vL��?V��^���;ϼ�P�*�����T�c��`�D�@�G.�o��,��@��Lq[NoT~�!ќ�3A�����f��S�S�m���:�����8-b	N�T�J�-\'J�?J�ňoGӽJa��W%y�ĳj+���ɴ���1C�V��j�]�p/��K,�)�Ki��c\"� �+$|	G��5,Z�cL��ʼ��Z,�ף��P�,\r���?(��uR�S�\"?N2`��gx0���9SG�s+���m&��-��+tA�?R����\"�$}`����}�;w�?X7aGv� |7-�p����?V��ܻ�ӣn��$�o�Pj�EW�֙x��or,4??pm����Ѐ��ay�@yVz\n��I�ی���m6��M�\Z�\\[��&����4Z\nP?OF�C��/�@��R@�̨�������\'	���;J҂i��4��#4��`\ZX��E�\0��[�J�=�@��t�z�E?&�I)���|L�B7C)�g��ѣ���pC���S��Y=�MA��1E��lDϼ?+�۸�c̠ϯc؊�l����j������@��~쓺I�Q��O-n�ty��&�yЈ	UM�3�uw?�\03��l,&�<�8xf�^�CqB�\n�ӱ��-?�WS����[��h��݅?)n�^�XV)f��9�aۊ�t��H�����F����C]a_�O�L6(��=Zh�d3*Z�G\r�̒J3��`?�뎮\Z�`��HPf?X�b\'!	v\\���Bx���?\n���#N.�|-Eq������p$ʹ��.!F<Q�+�\r���w\'�D@�3)\ZE%������p���>&�p��jH!�f�@n�7\0F���{�;w�0�M�7`S�[+��?ǀ�?t#���S���<�©N���NQ�7�d3�=��T�8R�N�N��s�%�հI��y�qĖ��%��C&���@E��}�`Dm�2\0�I(A6�\rP�.��0�GP78Ș����̘$O��%1=��ث�J+��|2:��<�CxyP�g3[�C�l�	�-���\Z�=H;bcc�J$\0�c��1�q���\r���牚����eH��\'����E�0l���4�~��/B9B:3��Sxet?�,�� ��϶��K�S�rYF����H$�,8/�a�s~g��:�Iw?�T��U%&��nl\'�\0&�@j�Yg9��B��A!:�WI�W�5�#�t\'��N_�ݧJ:*���R��O�����e�;T�]tt\"?򠲰pDMea�`���Ya��0��a3?�(1u��Yx\\??�U��Ӧ����{�FB�t�Lv�\'H-�5�\"zo|5�mEm�zQ��b+Nr�@V��+5x��4h�?d@�����(�@8�!�wt`j_��@]��S�?�е u{�j�:�\\al��J����\0�}�M��e�\\�\Z�vt�Y�d�}~���@3��X�<>nq��Ld��\r?�?��/�\0�W+��n�f���?0GV-���Zq����A�\0�t�f\"C�ij�p�gX3|l�@� �s�*B�,dz�aFu?H��<K�3c������F&��I`���54+K�u�P�~,?#N3OҚ%?��[��8�<J:&k@��&G�U�H�?��-��vQiugU��\r6�4���g�2���2kH�\r�\Z�4:t�}w�aЧyh\n?7-�@N:\Z�q�$�7\0h+?I?RL��jO~ �[U�,�2:)iZ%?l��m�dr� _���}׽(#:��1�F�֚���I2$�U�{y�Ë�)��\"�Oa\r�6\'� �a��`�C��Du���?�Ji�\"����j�?P�3�[M�d��LѰ_�N��p�����f�1?�K��[��胴�{\\t�2[�Ŷʪ��@�A�Vow���*�a6�g��P�\'\0|ܑ��?7�	0�P���R�} ���!t�4Q�3��H:��$�O�\0�1O\n���O=2���-:1ݢ\"�X�<�M��SkZ��4T`�ٛ��p6�Éb��,R�H�}Q�0\0$o�6����ƌ�>1�*�~��Uu<ȅ���S�So0�6���d]?��aCqʤ�ё�7��&�P�\"E�`j����Fb�j)\Z�~�s�dH�懎��\'j�gJ+�I�aNac��i�+5bL�2��I@\0|x���V%�0�5)�O//*�t?0�ӋֽL�掼�j �=�H#��\\!��($��Z�ƽR����BoKXXʠى�5�|��&�m?�)�29�Sf�b�\\�+����qG?GGL�C��O]�i���)0(%\nW\rmo:?���9Y<L�d��eb�q=�7TV\r9X��q�M֜?Z�*|�P�*�[�R����?����A:?�Xa4�\r���v\\\0�b���,\r�&�9/�5����х����F����-LsM��?���G�rT�`F���:�Q�38c���s q\\��Z�ti��υy�~o���UyN��i����1#���-l�e?���W�І�o�Ʊ\"v�\r��e�30�����@P]=��I���?l�F}7�3?S����aw��C�O��e6���\rIux�Ә0i��??��RJ\rj�]1�.�9?�G�{ ,p�b2���)L\r���*n�q]Q:Y��`a�yZ��!��0?~�hNK2X����?�-�7�Q?Z�)ƪ�\nKR&������%?�4TlBz��w�k�I监{!�+(�tF;�y?I܅b.��a�	�k�!�1c�t]~��9ŀ�R8�8��q/\'I>w���B��.���;�I�:9�?M|�l1[�Ɋ\Z3O3e�C���հ\n e/��?_�a�+�\0D	�8���lט�?�4:��`bw�3+\"�i֤<�g4 �ʔտ!^��]䅿�.-?R�8v�;\Z?B,��?�`;�Bj6��Xc���-�CS?\"��/�\rw�0�zd�TK�B��eU��k��̧����ܙ��BE�ݤÑB4P�%�~&�!J��\\\\�Qk!@�u6��I)jF�陪���[�{�i3��cx��nf���疩��@8��M��kD jA�j%�P�S\\�`Po�J�c\"�`0H+,@�b���-�2JA-�P��/�$\\{=�wQ�u�RaO&F�Q�Vn;My��U\'O�ӱ(��%��xF;��O~ӆ�±�1��!���XK2�\"iO�T؇iy�`%L^���%���@����	U���j41?�&Z��2�3��tX�n�e<���<F�q�\0��B]X�L��F�??Ax���7��B̸R_J��&�|h�J�b�xN�9�cT`x!Z���6M|\Z�q?�%�R�h1s3�2Y`�U�Du+&����&�N`���ߊxX?Tb������ƓQek�$�#X`��AUsb��;YE��hxH���朘׀�EU�D�/ѠBXB\0T��K؇,�V�l�;,02�I�#;߭?��hq�6�(eq]8�4L��C���#j<�G?6���7��p6�[)����8tI�i�\"A?I��V?�*�����BA�$W5ٕL|%*� 4�(�}e:\Z�ꛒ��lRr��r��q�3�$��v���O�W�2ܨ��T�b10�7nra[jKBQ{\'�mh�P2:xױ�g���J��x�?ilN��FM?G\Z�V*]�^f�����\\V��M�=�[u*���s�Z�A��n�� G��QF���\r�&�{b�{�j:}IK�����au�Zu�]�?���%(V��L�L?:��ݰ\03�p`?r�Z�Zh*��M?��J��I��h��A?�u\\�J1y���C_�m�EA��\nA�?@\'����k�l3���ߓ�ݩ{��[6��a�[Ƙa�-�^�4\\G��@�_0ჩ�Af?\Z4{L��A-�?�	B�t %�*bq����?��>���&x�?$��/��8�E�>w�ʠw?�M�V�PP5�u\Z�Rl�I�����1Φp�Qa6dc+�*�]���tE�����{�5@i<��4f8���Ux�ik�h��sil�����H�[�M2U\\%*��yz?���D���\nmA��� (?j�VgFS����W�N���,�G~/R*}؆�]ɋH���ˠ��(��@����mj-(%&)W8�p����a�e$��<<Ç+�*�p�q���?�j]��d��*q�ť�hD�6QI�?�6}(q��L0	*�z��W)w��&��0a2�7��\Z�a�W?z�|�\"+ul7��e�dk����j��͂*i�?.� =ݠG�Z�4�	u�L?j�q�QD�� hθH�?���!�\0�+p	8N�  l9;�嚗JTP�E�36?��D�P��I,�,�>H,^�v\ra�[��}@J�ׂN@������.��?x�M��@v����X??o2�	�!x6DRR��[�nU<�A�����w��RÒC\no���Q`x%($	\Z$X���.5X\\�a���ڨ$vb���&��R����`��$$��\\�P�[��b/\0�Ds�.�AOرT�6�������ci=��{⎃F����?`ݪx��z�&�ֆ�o����G��Ez��Ocd�p�%\nO��)?�_\0UHpn�>6N�+c�T��K�i=��?��E�\"�AC�1�?��ru�xf�Z~H�w�B�)����[���2ס	mxUUy�?�?aS4%��|U\n�Ӯeo��5�s���u�RS �H�i{����I�wJ?>rF�ð�\\`�dC�%\0Z�QQtJ\0,(��#,���0�*�	� 9r���wjbm\r�ȧ?`\n�?����C4���C ��\n�C���g6X���)I0gi=�i#Y�g`�<G!?	���D���lW���L�nz�B���[+��,��v�Yc(�1b\0\r\\LZRL����k\0�]��a��?O?�766	P֥ҥRl��9\0�7л���6?� ��·�����P�59�Q�P4%F�r�&tv?�/0\n�	�u9 {4B���$���#e���̰NG嚯V��Eq_�������J�OI�P�,��~�0m\\Y�VTX��FVh�e�.��b�vNuQ�\\�U\r/��*\n��e��?��\0�W?.Dե��?�QnO�V��W�)X\rQ\\.�_�t�Z.��7�M����I߉��]lm<.�0��C=�.������c\"������\0W���j�5���~�<����I�|?\\�*���ݒE�=8r��?D?���b�(���ף�xG	�x.@�s2�\"!ؖBy<@��(;��2�RU\nxJV���4y\Z�?�R%� �?�.R`���hN�^\"JX]4��\"?P�2rxq�\'�2V/�	?����hx⼥pC�y��LA�٘�iE�a��2K��^C}\nHQ�[�z���?0ܯt�Mr�\0 �薌��G]�FA�bX�P�#��lE?ܘ��-��ܾ?�|)��0���%+�\"зª��b�c�?$�&�� З#�}A�-c�X^�?��Z�\" �r/�L+�Q)�)��1�G�R�(ҿL\'�W�Z�p\'��~BF�\0�.?s���\r���g���??��RJ�RJ/f�w=D	�� SMɦ .B=�����MbQ�`�mۡ\"n�hL$zH4�������?ձ�tU�p�>t����.��$����Bu��Sr�f	�GV@2?���*�RdQr`I��,f��̊>Z�#-%����	R�F7�/��:R֩-.�\'K���X`���26�I?��gtX�L���:�Zv����-cixrx�D�p@J֨����S�%k�<�e�2����L�0&O,�?��y�\0X\nऊQ�2�����Rt��Ц����~��k7ժ��S�E����6P�͉���i�ny������B�ՠ����~E����?�E��n]�Q楫�2�k�������c�@�2���\0EǤ4P�\r�ȭ�npF�1����M��)��J�\r%�ߋ�n�Q�{����$�C4��+�4�OiA?\'�;a�?��~��V��PA��{���=������kH��B� gx>�wO{ ��7�6�ث$:�3����P[�c	$�Bq�;U��Dσp��qh� lG1�hJm�㧖�R�A�u?\"�=�VgGC�\'�\\�u��Z�,�ciz�z#MV};=���s{��eٻ�����؈�všF?I8_L�a�ى?/])KE����`?;\rʗ��(+ӻ�?�&�RY���3(��íun���83��G�ѱ�6��?������J�]L�?��8U>*�%�bK�c�2����@�˅/O\Zh?)��©}�����l�&���ɑ���k=-N���ٷ��L�?kN�j\Z>�@&MSkH��W�;��HY`�}R\\� � �\rR�p4|\\ZvN�?��I�B���_fʩ$]�@�w��p�L8��E�#u��v6Jg:B\ZS�I�hg`s2@l�Cd���%���H閨1\'3#��?�6ZiyN��p^��\r�~�H�p�I	��P�Ǆ�7i���D&G�N\\p?E�*(��R����xIZ��%�\Z�����r��:�PB�z��n T,�ʴU�/����y��\0@v��ݪ�S�G ~�J깊1L+H\n�+&\Z����Q�4�>Ei�O�?��y�\0jJ����{�����=\"d.�I2*�vF���~V�?*�q8w͑1��_�3��>F(�:������/+�	��\03s���v�?����h�\n���3�(\n���y�W��2G�)`�LXz9%�Q�)���Y���hu��	۟@?x�/	�C\n0Z2�?�G1��c#�;҄Uj{�̈�m.���$2��^$�M;�rƹCD���{�%�1?�بˊ%���6\Z��� b��V!�J<?*n8��Lf7����]�te�?��6��}J���#	1.�?)i�\Z�<�@��dRKv��T���a���̪q�Y�5\r�����W8�a����<�ɡ�*PD񃮉~:��6l��Rrz�חZh(��0�c\0�L��?\rD���͑@`/�#&��j�2��	��0mV¾8�_T\0�ܪ2�N�$�C�أx��(J��x2�z�&�y�?L���&���Xi���q�@?�o&��G�+�7J �jə�;ݭ�P�p_$ς�X���jZN\0���S�f��\Z ;^H�U4�\ZF�A�AA�٤#yK�,zAf/ۈ?�o$TLF�S�8*+�h<�{�@>�ֵ+�Ӝ��՘�w�����/��{G�?H��_?��>6�=�X3_�r����61%M�\'�}�}?���T�~R��h])o\n$�޷D�`\\�	*iV�=02մ���D{t�����a?قp�?�j�9�pñC�ǥ�����ቃ��F��B���td?A6��Q?�*�>����[g�l�6���C��?>�5�C,h�A�Z��	��HM��ny�`O�C��0f\n�~��TR�҆��$�^v��\Z(!\r!g���M�9&O!�b�v�r9�M�)\rQ����W*g&!WE#�Խ�;��l��?��٨��q�C)�XG�02t��xY*�^n7}Qc���F_~V2T��c\\�5_[*62��\'èsN��\0%�O�҅i-Q�b�Ű�	<��TH������\"�?�ՔP �R8~�S�\\b�8>dn0\\����^���Q\n�p-6��`�\"�nX�4� �].��zUa��/����\"�GƳƉyI�]�5�p����⭜$�Je���tkSag�rK��cbG-`�R�d����:.,2�)�Z%�zX\0r\'�{Id0�FF��8~�֕b�*�]��/�A��\08>C<ᕶǙ��?��Ǩ��W�s��J1?,-;Ft�U�.���q��ΠŢV�<��i��ո^�Q.�c�E<?�ۣ?���cЗ�)u]^\\`�\"9�j�,��I\0\"�H6YK�ޖ0u�D��RjM�)�J�������??�\Z��đ^^S�5���\n%���e{������m �?~�:��:k�JA^Vܥn%���R7Ա��<���<)�	��i��oz7������=0��^���@іyx�j�0�ե�U�e�YM��c�b���_�s1?є�,��XA��?@bٹtj9��W�~�%W=lMK�KJ 3,�)Y��J�u���A�u����\Z�?�?\r\"m��F�r��}l�p薽��jFRX����`\0N��F�\n�!�y�S�\r��)��ݎ���c?-?��cZxNL�\"a�DA-��X��,�ڔ�$\\�m)r���tl�Sa\n\r�&+[��^c�)/i�?��G1?�W~#NU��d<�ádm��	R�S��?	?װ�k4?# c�X�5Eu_�D�Y$C�ig΂\niM?I�T�W��DQM���eFua;2J@<I���K�JIJt<���B�n߉�\ZAd��eи�\0?iy�%*��?{O����Y\Z-����,��B��B! �C��(��/�$u=S1A�}�U���!�6��\0�F?�]�o5u�����e7É�+vb��ė$3��Fȩ=�&C6N�#H���T`�D�yF��Jr﹊?gFZ��8��s��Ev%%��	p�6��ln�i��ʕ!=ފJ�&c)I�\Z(?2.���?A�t*Muh�\r摪�D=z��_�iy��)F�D]�<��1Ӄ}	���?��I�meob?� 3l[�ᙅІ��[���\Z�2�7W�ϓ�2�V���\r;������f�MS�4��;e8�%�ڄ�u�\\\n��`�d:\n�i�v�=j����l�oҚVMi�g6�-d�6��q�-n��9�� 6f?���wD�fX�����<3�������r\\p�K��8��:L3&�x�����\n{iHժ�ۂf�?+�M�*�h�J�Ky��#jAYb�>-�A�w�� �`?Kp����\'�Z&%�?b�xL��6���@����?��J�<R\rL��k�TST���&��$�F\n��{��?���@��\n��S�ӴVؤ.���7�p�}$Mi�~���mI\'d�����E���b+�����Xr�����~����M��T�|EpU3���+��)\r��kk�bx�U��X�kQ=���{+=?p��>X�i��i?�������8�-����?�@�N�wH�������8��@�ԩ\r��?G�^��Oa+�T^%)VaZH�Q��iɸ2��C�	���n\0Ը�\Z�\"�����/v�q6�I#\'·Yt$%t�3K��;%b����ܚSMZg(���?�nckC�!��S-��Zm �#)ҡ%���$��v(�������d˥L��-M��?�o��?�!7��%VT������P&Y̰�P�~@��|$C�U �Ɇ�6�?<����3�9�Jl�̨�y�k�U��A:N0�<L�R��\'��	�^�x���8kI&?�j��W()Q��X_���%?Mi$\0�H���˦9@�5c_:8\0[{�6&?\'kߴ�t���U{��c�M�t��t�e��X���l��E5�A��(O,��Jn,�{ɻ+ʇd�$թ��S����u2\Z1�E�6F@�������wRĉ�49Aq\"�?ˊ����r����;8��+/����{R-Xt��˰�zTi^����%���\nQj�)@����W(؄���Dn*K+[�O��E�(x�\0?�!�|i��@�Y�[m���XC���%��RQ\r4,����Ç����Z\0�sCg�;I!�P۹P�Ǯ�/�n/Lg�1��%p�t|�e��դF3���\0H�X�v����B�?\'����U��Q��N\nd�y/\0��bإ������g�!넊�=t|�\n����ɫ�%�[+�ehX��?@V3.�Fw.�R�?�$]\Z��xf?�=�_/����X7�\Zg�$(�vld>q����K�\rA���	��!P̿0\\�(����!5D���rqG�.�ç��~\"\0�ż-o�%N�cԊ��l��Āw�Q` \0R �b�	Vh\0%��E�B�F�xH\0��kXm�\0��}A����3��T��/�?)��3W���0?|\"���?��-�[b�K��g+��\"8�}�̢��K��?lY3��93c�i�9�s��e��(�=�ϽTP^���,��}D�(�ұd�#��L�~�?�����J� 7�`@��t��W9�0 c0\\���hCpAr��dŽ]m/��Ek��P�R1/7�9I�U��e FW��TY}�?5�\'� _Vs��e��t_\0�QJ;\0����*}r�4�{��R\"q|/ɪ0(�a�WP}<���ҽG*K�q(3�%?Τ*J%�?�\'�`cr�nq��L���x`�>uN���To�k�<n��?�-!�\"j}��~\"�^1���@8�?�M��%\nQi�T�	������3�\'W5E7�7�b�����0���4�f���Q`����<��QF�t\\���[$g�=�6?f��6 �o��0�?���<Ӷ7?jVRmS^�����yɋÿ(Œ��0w�\nz�igM�~�2*�7��M$,�-�w��i2G1��29IQ�\"!߷�D����dZ\"?\'%3���&5�NH��50\n ��2UQM$ܫ�A�luf6�7��R�-q퓓�W��lA������&(6�����t��i:?=n�JD,5\"��U���Ǘ܇��)nl&nzF�^ke΄AؒP��s��o%/?O Ks�!���g;@��s` g�c��:n8R3?����A��8u\n�j���������P\\���F�A\0t\07???���7���Zq#~���a��t<�j����ͼZgp`����Lݨ �{V�JJ�ЇT�]Q�\n�c�^�C�S��:�3��?<�lk������*wCm(�F��姼s���w\r{�T.��;������ߨ�#��6ŜH����?R��woJ�w��b���?����zU?��u,�2%E���EG?9e��qW�#�|Q���17��>>*�4v?���ZQW��\0ǸD���^���Ey�I���\"�����O��?R���eRQ�~H$�djH�#�r[H�������2��Bd�5)�r�[\\���,�p-��m�I�s���+�ט��+g2~ZyEb�k4-�r�S`�m�+H	�����.,8|�K=�bр1\'\"e����A�05w��me&[��[>8K�N���h�\ZtAԈ\0�n� l��B��	t��:f�E�aEʤ�x-?��Y��H��5v��xm�?\0�eˌ*{5L�8�0��#Vx��Ξ��F�lJV�\'���\\�A?���O��CNv�%-��/��6���\"o�j���?ۤ�?k��a�-�/Y^QXYYX�{��M(��BU,҉���E�oV.r��w�������;Y�4b��vK�>?�O�e�-��\"\'�b:o*�h����o���6�	��h5P��ò�Yj��$�:�x���?�塻t��Rf�*0�(�h,�����IA�	A-��I�Wh����8�\"k�y�o<3g�C�aC?ҫ\r�jn�DH\0ӫ;�/���&4��vGRȹx�c�7�\"K?���}�[ƣv�I��oc.���U0���)��~;ݫ($���)(L�D�ki�l�l�\"��E�]?ä���i]�*n���P�o癗:.��\\@n�:5�(���V�xַ�;NY`�;��\r��?�o?������X�4�S�oTM:uJ�\\�DZ����*(e˺�\nG����0?4\n��@�nУ^��B&�k騚\Z\\�W�qw���<in  ��(A4�lZ�Z\Ztp��@��J��H]�Ϊ��Z�t��Q�0+J2��Gf��&\'ۢ�	3*-ݘ\0�LC�`Uf	���l�9Q?bA�L\0m�?���s?~+RH=���� ��;5�K6\'\n �C��0?�bB��x*1����l�?�Zݯ���ezG(\0��)ʡ(Rb�n�Td_[��\0Ȓ�*lTA$���??:_p������wv��\0��N\"$?����g�f3�7f��Cd�Q�R��1�J�n6�aj.d(�2�H�=���O,�KF�)��Ѫpxv�˟n���;X�$\"E��i�i_��?m����\\��=�����e:�]$��))���~�j��<;`�*9�V{e��E�op2lH�ɦ.,�SW�]���J��v���=\'gY��+^�]��ܼ��}w���E/G���㒬�?�צ�lM9���?���ɕ��)���烓y}�X�nl�������\"`�k?�?�����&������\'��0��f,��3F-�G��$rX�AB�?J�z�<љ]�̣� �G����JN(�Q��?t�ڿ5�ȳW��Z�+��������I���Nn_z3?̜��˳��N�X&/�Lc8F�T����>�g�Qǌ}�v��I!��6�d�Ǡ\n�\'��,«D�,J҈a�A�X��;Sl1ƞN-_٫!Qr5�L�2_���#Dॆ�U�hғ�F�P�u��o0�F!\rGǌB�M>/���1odi�rj|��nH��������|���NQ$܅r`��$��`���?&��7�Q���(�*��0N{���A���?E(�EFx��?\"�{w���]\Z\0��!�<I&�~XjM�_w��G�q�\r��0I�lI0�黴�J�4`Ϩ��\'N_ݛ��?le�x��ʅ�<$�V���]B?��������1`��g2�\"R�j�,1[�3	�v�Vn_�)�2F��2�as�7�Y�ֿ��̠҅�@��c�H�(�Y\Z#5�����2��,[��&{�	�?�Fl�?g�=/Vy`����_Yk�\\/0g�d��&	���l�G�[P`46��B2�J=b*�[�~��x^zĆ�f�a8S}��}������cm��n�7��?&I,Y2�/��В�h@6�$X\Z]����{wן��$&�Y�L��n\"ʇ%6��H����x_˽�&�ɲ_�� �j�	GPP�=�tJaz<|�l�B����׆^�5� 2�vMK?�%I��E)��?*Ckrto:�Qʭ3�}2U��h��-s	_��i�1lhxws8p\0����$�2J&z�9�����W�G���J�C\Za��(�x^.��eadN2\n��)Z�<�BLa�?�Ε0e�k�>����P^�U4�QOˉS(�M�\\B£�@\\�0���Aק�ӎ��`MJ;ԛ]��/��L��>_����tEZ�Qpόܣ� ��/A�����2�����~��_鸦�4O�1�t�/���B>8��{$�w���aF�%?^��.��$�j�\n���w,X��?]�y?�c�F?��#lREX��(]�C���=�H����\\� ��ʤǩ�ڲ�:�?g������w�5�Wuda��+T�\n�1҄%N�Sb�f7�C���9�?A��h�4�h5p�0�^r�\n��f�T���p�{?&on�C�u�q��CҒ�*\r|ճ/�[�\Z?�v=?�j���|�8�E]�*�P3g�9.�G\Z�ޫZ�x�_:`8�}��Ë�D͚T�/������EW.�!�<�Ѥf�l�FQ�\Z���bv�pϊ��A�A\'ӳs\rN�[]�Y2�I*�ԤF2Q�M��K$?]��Z7�����������v��͎�1�-��s�(z�R���e&���F �?	3�ȣ�$;n�(��7(�ړ`���$_�?0�����M����?��4�C{SlR��em-�Ŭ��V)0��8�U�(܅Ke��?6�>[?�rD�����?��?[�w�.�!8Bmb�~3{���Z���p�^�Ad8&s�]��DM�ϫ�>f�(�&\rj�I�#�2��l�&���^+vsD�P�۷�5hAS�(�(e|�!�A�-w���?��,����*�nH���}�yە� Pn�~?.�G!�d!�+�Mԣ��tUA���p����.f��	6ϰ���<��f�쥳���f3����S(�gk�*��P0��C�y���˙?�@��Eԇ��}��s�s\\��9�Xf\\�-/��;����\n?ÔQ%6vg2�}\Z]�r��Oq�y�Ȯ�����	u��s�?�1\"�����4�]f%S���T\\~�d9;�yL��X��ȷ!q97���ȸ�.���9�~%�M�\'�\\�m��?�ض��v�*l[�Ys��,-��Jx5?!@K0myV�Sʖ3mN\r�V���\\�B��7��x�~\"��l�/ͧ�����2/e���4?>�GC@�̢Qo�ȡY�0�A���_F�\r*O\"�rk�ո6���Ǵ��WJ�o.`�.>!Kڛ��OW�9��\n2����%�a��?إ�קa|�-��/8�\Z���Y��G�tlA�2��g\'5Q&,��1ɚ�;4߄\Z��8\\��=�!�:=��i��7�ʵ�g���Wl���6���q��)�M�??�֘��?Rqq��lr�l\n��{w�w~��=��>��R��|!3	�י�����#��S�9� 8ȇ��QR�0�o!\r�e�f6��E`$1�=��JZ�f�rd.�F������<\"`�)�%b�>N$��t�Q!?�^�s� ?s��C?&c�[�u�1�w̅)e�fEvi%��h����\'�A(n�8��f|�7i�u�f.��!{A�u��wa8��%���Ч?��#�\"ܠñua��s��_��Ϧ#4�N��ϗG1�O2?zɨ�����Fbrj/\'���ot?+�Wil/�2	[��d��mB[�6q�i�\'�v0n	�BE�oWI�_Ύ���ζ8V��0�K�A�~[+\'j�S��W��B�k�������\n���6�+m�/���f�SB<��x>}P��| �m��#�Q�up����&k;�~8J�=U7��6��^Xɨ;��\n>Xr�J�{D���7M�MH�;o���E��_���j�?�e:ք���VO��a\Z���?�\r}Jb��I�?�h���?7��@x�1Җ�N�1W\'j2�68��T�[��O7K��,���ւ���G�O�5������nAB�M�u��G?��|��a�\rЙdX��,0�>�� �\r%����S���c�t�!l�Sh�S�k?�t������χڒ�1�4]�z{h#�g�{G/<&�?N}�9\nz����pl�q��?��f�\'q4iֈZg�t�-��x\0q\0-���Y:?qY�,A�%��x�0d��]o����),xN�\Z\08j<��C��q��0�e��[Ҝ���m�����i�A��e��4�F�v�4�l��n�.}�����զ}��~�� �d��*����?ٹv;�s����:z���|��o���W�γ�d�z\0�����N�B��a�H��$�)\"iM?�A�;㕶��eO�d*�T�L��HR�L�%��	jS\r�\r\r��+w�?ܬ�K+2	Z\"�\'?�Wyq�?�c��~���NQ#���������/�{�h�xr<v���g�?̫?���T	sY/n	k�h(��Gol~�[4ֺ������<*�%�W?�f4�\n\0Ko��x>����ԇ������QX�q��9⛧�i��HeR��8��\'P�7\'KL����?=C��\\�r�W�z��H0>y�?^}�?��xr&��	i����0��S�?Sx��\0~�Gզ���;\nN�g}��I���Zz�[�Ûgl��,V���-�Q��$/�;��Vu��?�ث��4�)e=ծ��T`�N1��98�/��^\0b��cb�� 	����-	:̷E\Z�?�]�\r���?�3�dT�?=*��\'Q<��?1���,�G���d�E@�ձ�S�.��M|�8\nЃ�\\߱��/��g}�r�>Gޔ��?Q��5��+����:@=u�.��ZeȺ���J(�V7 ?1La�;oP�x+R�4LA��A��+��?wϛ���q66�K�����E�:����$�sH�D$��\Z�?9���غ��A{5��+�B��\0q�\ZH6�K�u�}$9�A�� �\0cr�0�l=����ܻ��[��`?a���z_�;����Xfm\\?!{���s?������{?7_�*�\Z_�.�0 �G�%8.�F��j�dtx�D�X@�\n�\n�zE�#�X.�)r���g�)Ayմg.���,�Y�֔�n��,Kk�h��=KӚ ��,Gk�lT��,Ek�P��gZS�OI��|Q~O�vK�]\"���kE6�?&M���d�#^�4͙����C��tLA�������`��e�d�k�r�HD���%�x�[��`$�1����i��x�(=vzej\'rQ�ڕ�e%����0\\4&XEL�HX��j�y���\'X4�JX*����%?`UQ�%�%�`�0��	K>�*�K\nK�U�X)���p��`Da�p))�C�JUm_Xv2��K��7<������\"��^�)�P��<��+�>��?�CxU\Z��\'!?�����q�d�ݻu�����.��N�T�ø���}�H%\Z~�s��N��3��?\Zݸ��h\n|f�%���?V7��X�P�, ���eu?43E\\ve�#��\n���|��t?_�i9b�����ob�KD9��&6w2����Դ�??!ͿQ�?8�O.�ɰ/�g�?�M�YQ���i٨&x�Ok�g���Ӛ�����;.����I	�@s\0��1 ��I�N�jƹ|�c�9�/��OU�}&ɧD�W.��r����?W諸|�j<��r*�\n��#_Uz��wP���K	H%x�����Þ���>n|r��P�}�w~7yG?QBwQu���	\Z��n�~��?\n�A��!�e��Q5w.nyIj�ѕ��IEVz�q��\'K!O�<i.�+ iJ�{��\nV_���\'迅`������i�\nD��`�!�d.���!�5�b�\Z�;F!zjO�?{�a�z�����τ?��,���G�{/�=��h�\'�?Ы�n�V���:�m��N+���������ơ�l_j|��*o+pN9 ʨ#\0����K��q(p��LZ�t<�9=�L����סvL�[Z)�n�6���l@x����E?��C�{a����?����aUN<��?�&?,�(���֋t������,\n�U���H�F,;�	c,�s*D�כ(\ZeS��A�D�������O^�<���R<��\0J���b���zzrj`�z�(^	bD���atFx��/?��E_v	��.)05�#�|(��\"� �%�V�&A�|�X\n?���Gbb�����)��:���? �ϔ!�wU�a�SK �L�oi��^�L�D{?#I�FR�p�1v���q�l�L��B���?.*�zR�~�����ĉs�n�V���?�����++?~����,�\r�����w�Jr�t���B�&j��gUH��� �?� >xO�04�`�i����3�4���WO�*���Dy/��\"�\0�x�~H.�����?��XaX�t��\r���C�[~��1����d�+Yz�I;Uub1Sb?��pS:��-���y�+��\'0ܞ��^5����Ί���oN_���h�ɸt���2	����ש��,��M�W\'����?#�FF��-�z��?{��E	i!�\"��)e@@�\n�(k��%�Y��C�O&�E&�h���f�OC����l[td���2}�*׬	ۚ�eou�\Z�\0��O��:*���)<\r�?KZ?�Fa���D��m0;�PC�$ğ<!����xH��S�@ �5��V1f�t��k<�Λf�9h��4;m��i��U��R�fp&M|��|c�u�\n��L��ca�l��p��<?e��>cH4�*fK�.m�i�;o�\rug{ef^�ԯ��W%����L|���U��?�4�/���6��V��}`D�LB�L O�,\"wpq[���O��X�/H�-!~�!ai��v�f�x_C\rS?�fx�TI�%Vh�����\'�(;e\rn�����So�|Oʷ�n(�!��:MX??�U�\'�,шNDR夲S~!s}%d�\0{rr�O$�>�	B��	�9���Ȭ���cd�\rGf���kG$.�-�!��R�U�_��*�w΅���\n�˕��\"���,-��hq���o	;dWKy��&�	���\"���8���[r���K��EI�D�É�x�ɿ�l�W�����U��*�~��O	r�*\0��	������J��S�=��#ӂ-���D��\r�JDd���$�{����r�w[��}7I�M�?�������HY��\0#�bzY��	W\"	r�2�/O����E�8���G�������r3\ZlW��_�	��cc�R5�ò���$C�(~���`?Ea@V�iLZ��~�<b�ᯋ3KFL�I�!�}��brK&X�g��d��?0�w\Z$����r#���R�E�[\0ęlMXpMZU��Ɉ\n��F�բ�&�w��D�~������!r�?��ʙ���(����b2�\0��{W\"�Orq̥�Q?��9q�l�md�瞱�K\n!�>ړ,垥�rO^?�.Q�K�gD���������{jv0B\Z�M%��.����,�|�\Z;`��4q3G�ĩ�q������h�io~�耿S�rs�?�H+F�n��O?���x+b��.�b铧v�ѿ,�ӧ.\r�I��?4�J8��*�ѹֳs�\'֬���r�Ҥ\n��ç��5εC(uz&ZߤZrH��\Z?L��z����io�f�8\"@�nM�k��A��(UTBq�[}�?1f*0�ޙ�����d��Q�H�zMh5fh_�\'o�ˬg�+�W��2��ke�a�i?�%?/`��X�aI(�E��<IĘU[Qj;{2��y�u(U��,-9g:��v��-�Y��c�&��d�H���Ȧ/�{�1�S�?8�ql7��DeK\"�%�UC,�H�ß(୧av=%�7I�i�\'Y��Y;���?��g�`|��s� �4ɀ����н�\"��K�Iu��?�z>@��<PA�(2�Uomx�r�1��$<;4ujTJ�O�@��Şi<��؇�H��i��y�	Dvr>\r,@�DlW�?�����OC�!Z�H�j�WúT�\"��?����6m6f_��f|\n;+J̆2�>C�$HI�/#�}R�k���}�v_����!^�J�\n����:>zQ?��w�?A	}b���}�?i�%�\n�8U�����p�,�5��,DqZĲ�d��[�\rwHOم��2\n��J!�}V�d�/7st���[�(#�\"�0����6&�s��b�;3�SA��>aWǅ|��!�����%hb��*<f�X�_���\\�p�:r�|�X��?�^L37�g�짯R��C���ai�+\"v?�8C�l�2J�Zr?��g�&?p��I�l���h#�j�|�Tّy��e�W� eE�6ھ�Q2(���m��`�U�����?��Pf��w �u�.;����E����E����$ɂ�s�8u�\'�����L�/h�7?pN�\n=@>�L[%F;T(����CY��?�jW5yU���?���3?�I)��WU=weH�����_��޲9�\n@dF�6�%�g�\n3X�ƙ�H1��	;�?��;�U��!��\r?O�_�y��L�M�X�&*yXY���\Z�)\'v����q?��2a\ZW��B8��?f%��s�r��0�?e�\0{��6v8̢�GRҬ��<muY/�����JG�KT��s,�	|5�X�0�ɻ�?\0��\r�6���?&e��e��)Ȳp4μ����y�?�娷��leh��	��}P��;@��\0���:�~Sl�.3�~�X�Dm�K�L�&�\r�ZѦ�� 괡?;$�*�ϴq�!﷪,���J�xj�]@�=::|Y�l�h%�j颣��(�c_�4�M��x壹�4k1#I�!ue�h\'7��n��2�>�B�lcg?��դ\0��Y�z�$�d��%2�H�H�X�6�Rm��rQ�i�*p��2��L8NS���~�<H#���a__[/,�3bG��,tD]��8.�fc[��{�B�_%\rt��ǫ�\\D���UN��W�\Z��I�`�1;�����-�=?��Z�̑�F�x�p\\?�ֲ}��X�MR�p��jeK?\nR\n1z>H��7���^9m,�\'�?P�?+����+z��������aԋP��)%�9��-���#*\Z�U&9��+�6Zi\'���_�Y�8?Nd�ɤ��ѹ� Mbv�\Z?�`��e$;V�P|�Ы5��t�vL��(\Zv8���8�FCX#X�������z�����-����i�a>�6P���a1y>�HF�l43�8:W�ՙ�i:K��S4?G}.�\rEũ�Tԭ�^f�x)1\r�C+� p�{��,?�?~S�%��K�V�.QE��}��g^�UFӖ�vrDW�(#�����>+6^E}]�= ���K�F�����O!��pWc+�T>�4�9G!��9��{?g�H�j#?~���)�x�R�~j��w:�\\����ؾ��G.�0����9_2�&t�5+���@;�RvYGq��H$���GSV��q�a��L�xK<��\'Q�N���b�?=�$�0:ׅc<;���0#��??�U�o3t�##+=*Ɠe��$<����`�\"�( /�I�\0=�QB�!Rۛ�4�(��⎠݆��S�=��?�ɽ]�e�\0K�U���[�+�	sCǣ-���yӻ\n����+����%�����2^Z]��y�I�9�]Z28b*F�vte?r>����N%�{Q�\r\'HƑ`G���4jM�-U�{Tt?)(-h��+^�,���[!�9���\069�&1My�Ws?[��Z����\"t���!�y5����<�+��1���t��9�) 4�o`T�\r�����(jp~U\\U\r�=��n\0�s��UC�@Y�ذD`A��?2��X_\\��\'mK����?לc�Z2\r���֠\0)�%1bX~.c��?]8$244�$��G� \ZOK���g�Xq��ܫW�cD��%>������s�\'L�\nZERj,Z�j.f5O�X�\"\\�O`mJ��&�1��U6�Wc�N?ElK���~B?dҜ�(U��Tbi֕�Bl:4�ff�T�޻�i��Ih�k{Bc,�\rRZ�K��n5��9ß����0Dn��â��С-<�utp�l���J�n�p�\\*s)e.�̥_����y����?,��Dݨ?ĽW�u�X�����댳֟�:�@J���|J�_|,��y&Y��y�̗-��񬿶_����P����dy�ZF�{]vS�;���FF�ɸb|�JC�Ӊ��3���@l�\\d\'��v�}0)�h�)?.1�z�?�y����	U�\'!|�P��0��!m��?rڋ~C#������<�}���k=O�+� ���ă��0|]\Z\0q�<���?��w�h?\\�?I��]n�8�&2_�Y����Uw�^�e	KI��H�_��*i��ҭ*�4�$?���	}>!�T��?3��wa8.#X�d?�!9\Z�r��,�cKI_%�V�q�2�WN�*;��I_��U.�-��<i��Va	��H[so7�J_�\n�;K_������_G��j#f	n�N3�q�ն�\"�/6�k\nO��\"F���3�}���<ԇ�S�yB����/�ϸ�}���t��׆t8-\nv-h�%rDx��+���BJ����E�u?74F��i�L�\\���AG?`$&?sE�q���?��2�c��Zi8�\rJ���O?S���,��zS?\'�n�m�Na�N�Q)�y`��xJ{��/�3����\Ze\'��*?&��h_�]�p�ة(��������y�8�!r��1�c&�k�*UW�-����0�w��;[�����a\Z��͎A87�����c�x,u�Wv��C�G�ȋ�Ѿ�Q~,�K��ºM�L�M�^+�l%w��IO��9��9��K�9�A�\"X��,��c:	%@9���L���8�?y뼄K�����2=��[��Z^���L%Ǯ-@��u���᭑rf\\�D�\ZK?J�ɳ(��a����b??���-|s�\ro���fq���E���X8�?�Q0�Fc���Å�\'���E+F!�?����U/L��k�3w�5�(�?���ӽg/O��>�7��L`km\0�{\\*�Kozٔ�%D97|��Q\nDq�$�m�\n0D�L���S\nCN�l�%l�\n N6~[��3�ٴ9s�K2� RL��U�lZ#ו<;JtE��*H���M$��L:��<��?��g��?v?ny��\'�,Qf�i|<��`��WFi;m�WB�e��X��4Kĺ8 �G�l� =\'�?!xgcq�Ǖm*�R�z�$/��gI���貾5N7�h��QQWVh[ū����\r0�H��&~X$_�?�L�Dy>�g���_;�?p�Ϧ�*�v�\0�,��\\VB\0)�o��e A�\0=\Z�0���0uh�� ��\Z�F|wLt��e%�!�y���b����h��sKs ��\'�?)��0�AF�w�`T!�??wa-�_�I\"Jm�l�h�����v���؆�@�jj�mk&�J��UZt\0?[�5�%W8��`O�dVt��N����<1<0\Zg��nS�3�p���?�qU����t0�$�QI�}/jV(����\0�_��YѳK�oVPw\Z�z���hQ�z��a!g����j�b?�)?B�U!pd�,�.�n��$� KgX�SX�Sc�k��G�r6���\0��2�?<���Dd�9�� ����B^TU����m4��\"?RNl���eן�q�rq��I~���W)\"?�[G��Ξ<��5FC?qȔ�j�,\0��\r	���j1�m�1,5��0���3��9D�Z-�up��F?F��<������ʸ\ZL�U\'�jm�-��s+�$f��sf�`I���dRE�]��C?�.e�%$�A��#��ͲK�q�}�PG��ep��q4��(શ(^��F���dKc%�Cq�R?����<���<�i�mk�/�B5��9�l&ŅQ���p2�X����?Ov��Tn\n��J��3�2�MX�1�uU4??�o�t�E÷��(�?�@E?L�1&_v\\���D<�1�9��X[3�a�G��?�0{�US\n*{3Uj��~�bFd\\�^Rwz�#��Fu?ro@�O�h̦�?\05�S4?q?^ӣF�7u��N儮����΀��\\@^�5����`���A_���3�\'7B\n4���-ͭ[��M�Υ��9����`��������\\?ƪ��4��ߔ���J?���?%?e���fт���R�GM*o?9�\"��8�\"��^��������a�h�X���&��c_�����,8�*\Z?���ܽ�?`B;�\Z��Zjr��r��8��0)�����#6�B+�����Lcր��?Y-8έV�*���Z����v!=���D�S��j\\��+%g�T��O8�����]%�9�_���\Z;�3Kl<���p�&d�=�W�\rM��W?�<}K���@�i���\'p�����Z���&?o�5j�߲�/�2�5��q!F���\'K/[S?���<�n�:���?l@s��l&	�<�R(Y7Ti�%�Ú��҅nx�?��1G�k�*h���to��w��u$T�-��~�m�Q(C�cn�+�r�0>c/���?Ap~_�p�dOz����;JH�nrP�O���U0?v�v46\na[=/�\rD�7�ؒ�R��^f-=,mP�1�?d��bU��`�>e;�>�׌Q�:4fwˠ�ʲmQ��2�Β9�,9H̸;N������7��!t$�|�E���Q�$��b���[?���?P/IE\':�q	�����\"Z������L��i*��fb�&z!zһx���HtY�\n�)v�Ο���M�0��q����b�|�׵�(>��[@�X�]v��D{Y�Q߶��[���h�^��~*��˳�MĖ ��#nV����\"<_�Ti���06 8୎��7?K���=����A_�A=�g/������Ib�tl���^������d�ЉسU��U?�(sȕ�v��V�V`.��BAR�F(`��!���%{���Wm��q����(:ޒp�h\\�0Zݫ�J�a84Q�/P<��������r_�C?w�Гa;�ʌ$2��C��4\ZΟ��\'��5H# !t��G�I�<y̰�	��?�<i����&�eNϥ�HI�ܑ�ĳ�60��?��&t,�S�q;\n1b�9[�&��ä�S��|�w�����$-<�|���#�;���C?��{fu\\or�o�V9�\r]��5A�;&� &�9\"e��C	�{	lM��1�dۃ3��?��cX�=�U���:�L�s�N;�EPp��	nH=���@j���L�Bb8k��6����@Z`�67�\"sXEFR1�|2Ⓤ��?�lVё�XxQAG�b����p�ZK\'��j�WT�4����#}��u�߄���K:�y��\';sᔒ�S�?���R\'��)5�����XF0^�R,\"��/�R�ͥ�E��KX��,\0b�?Oa6�(����4fs\"�<օ�|��]z�����\\�o�ocW?B��C���,Z�����ū\0\ny8�\\����c�q+KZ}4|���r?�\'��4J��?�C�7+�l��?t�̉?�?v����?��^��\\sbhx%N��M��_#�ʂ\0ׄSYlCW(6���+ۊ�lu\Z�UV��b�b����a�4�S_CC�Ң�����ݺ���?=Ԭ\"�BG%�I�>J��?l�h.���Y$�FB�\'���&��?S���t�^��~����̬ u�}]����OD>�S\'p�ɰ`��H�C<����Π�+yg�D,ЙW|`cX[�?Y�u�h	�I�q��M�`G�)4���3�wL�.&ř@���L=q%aN���������P�8pj[s������@k\Z����i���3oJ�\"��ݣl���q��;<\"?�6~�ܧF��y�(�|�M��S��cF&\n�������[\"t���T?B/6�ݻ��{M����K4���m���r�?�zR��������8^7!5dO��,� r?�?�!E�N;�:��+�M���6�?]GB%M3�>s�b��С�[R����7�-i��2Mk���E�B\\�L���%�e�0�<^�\'�	���\"V�	�g�3nʊ�aH_�.���\r�6�<��:\Z\'��4t���\"�|��q��� z���mu��*z�xc�o,q$�	IP�iw�X��?��?�k�\"�6��:z���E��d0]t�\'6g���{	I@	�k��z��6�eMϊ��D�[p�\\�C�����v��**J�:?��E=4�����A�#(2��X-�%�R`�?�I��y2I�!�԰,1��y��a�cr,����y�??��h����h?��\0CH}�=}h����(�mb����&�?���6�����σnȮ�@x(f7G] k��_��~�q\0�o��9�� �u��\Z	�o����Ay�A�Ȋ�����w,�)�j���Қ,�\r-���<��+qFe��N��|��kA�x�,1�Vg��\0���_˞n^S�+V#?���\\�ەW9fW�+������r?�\r����/���u�����;6��2\0h��/��r�Ì,�< �&_\n\n�;4 ��y��e�mᯆg|�\\g���-W;>;I���?S�J�#��?^?|���r�yHG.�0�KU=.��1�Z�>Y���E\\�2�ݸ��}pr��\'\'y\0HP��j�v���q�X�_R��_�q��j����ׯ�9ɧ0-�y�%��:�{�ӕ������[��[�g�Ӌ�h��}�66:?;�n������ѡ��n�o�llvno*���|�t6���;w�Cu>W�?.��R���-PY���-��[���d��o��x�(��\'�q�:[����z;�,�H�v���$�X�Zi$��s�pK�Ԏ_��^��#?*�`�j?��|T�Ex�\\��A���K�L�o��,o��_\\\\�/�1�<����T�5���\'�0N�]�k��&�\0�wl��C�P\rU�->��{�w�$7����,n�H�S���\riJ������?G3�?S�ڙ�Vju�\'�r�}J68es�\n��A�Ћ��/�ck\r�\n�)�?bh������������72����a��4��Y��r��|ς�$��x4?��\n�X[S���b�P9��I�������Q�X@6]�.U�R�/�{�=?a?�q{0i��^b�2&c�&��j�Q�?3��un�9i\\2�.p��!\'[�Oz��729?�3sO7�&��P���L���\n��o��R\r����=��i��gD��Q�?	%�U,a�(r��a#�b�XD��?�hq�mta�m�og&Ž�]\r�?rՌ;�$�#�>�#�����Y���Cg�s�0v#�����>�1��T�G��s|e�I8y�1���H����_�I2]<��2��{��ǜ��;?�G�O�4��!Ys!�aپ���M�g���|�uC�=�~�8K��i�G{?�# `�3�䢪��*?�����tz<�`MV`�.���rp.G#�ٞOG�J�Ay���u��fj\r�xTc�M\Z�PMU�w�k\r.���i���Y���^i�@��������chu�lk�Q??��������NQ?j>c?}Q���G��~�����e�.�\"/uDT���gTx�G��h[�mz?8�\"���X�|y��nr�^�9lC̮��Ƀ��y��)�3�)��?����k�Rg!-.Җ�ǙBC1VAӖp��;W~̶\0\r�pQgM;�:��Y��5|[�8Հ���;^���p*�aAj�G$��a���\Zf}T���H�Q7��u�B��Z�?�\'����Ó�FC��篞>�?R�\r� ?g�:��p����%�I\'����*�`���FMǶw�z�	���<���\Z�g;�}v?�\'��R�����r��󣑼>P\nB`��kY]��F78�\n�V�Yj=��?A��@�h>>���۶b��,��qc����f��h)��[�`��$j?��k5Y%�E�t@��A!MF�枂�ؙ�n�E:�p�\nq�N��喾a��C�WĪ��^ɣ{�����t����c;XJ{����X��\'�P6�U�� (��\Z�1�/�\\�1?��6???�F��AT��qiMZX���\0��$7vSM�9��n\Z��i���?愽�����I��:��-��7�b2�:�?�A�T���?4\Z\r��Xٮ�T\\�\\+X��IA�ىɯ	���:/?9ex����y�K\0����+�g� �H����?n\0Q�U�r�Yy0�B�\0��FO\0)X��Ă��3���1&��#�7� �p�E9?-\r�n\Z@c�`?p����։v�.b���Jq�C��nk��<��,�\\W:q�?9|α��g5��Vx^`a:���҄��#�Aǰ��aQ�~���(� K�VF���\"!6!۰zX�4�ǡ�m���\"Z?�ǡ�j����\n]�~�t|�/Y��5N.���l&~��5-ѣY��v}�s�nS	�r�TO��\'p?^�_f���=\n��Nd;��O��ˊ?����7��?f8!��8��m����;�ݾ���߹��U��[|�}�l�o��[;?�� �%��w{�����\'�����?m�|��=aR���g�u�r�oÿ\r���wd��$T??+I&Q�u4�v�\r�\'���x�p��No���ضf4B��&ax_v�KgiF��@^İ�RJ�+�|��p\n�������Çt�A�H;���<�x����h�[`����0�E��i��(fJkǆN�Y{���>ݑ7�2*��I|],^��;��:@A�\n)�qXPE��7|{n8�a��xÑ?qB�Ⱥ�^�;x���x���R���ܖ��e�,�q?X��}�)\'��D\nh�\n�C:A\'���1H�����tM�=����)����3�yiٟ�e?��h�G��\'?���wLbM\rk���R�?�\'�$z��L�yؔ�!W�}��k[gv�Ƹ�?��vx�c�q|F_A�~0J�o����e�Zݾ��c+?��+�V��n�?l��>։��Yt�i��B �?G�\rV�妔�A�_8k�T��BV� �\r����p>�{������#�����3����\07?�q��p��CǛz*��}\0{U���.�Bg6�?nx�[�lG?X���uj����LRj�o[O�w�4Kxos)H�@B	��*�f8�X��+�u�@�þ����	�C[��G�x����-�����:a\"?���N���}�nV�E��J~~��%ږ��6��mWr�]Ƨ:?%O�ly����\'�XY�\\�h� \\D;<�\0m�.�ʇ�>?�+?��=v�\r��\'q�.h󱖖m���s��n���,�G{�\0ը�\Z�t�D�n^Y�������;��m\0����Ϻ��\r��u�6`1��\r���D(?���G/�>;��ЫS�K����++��@ �����g�,A$��7�x-4����닰+_W���RHm��G�?B�$�@�g\r���\nL���u�YwFcami�=)�R�I2?i�h��9��L8�������y\\�ӉM��U݀�P�%�2�W���Ʀd�\n�~Q��#[�)?d^U��6ؖ��МwU�$�pK�X������e�o����9}??������9?�xU#\ZT���ÿG�t��͗�mS	�|C�A��dS�����gT��;�?zzX�\nD^��}e�|O?�ch��O\r�3��0MR�g���u����Hw�-���Ӵ�`*pp���c�[�S�K��Y���3�K����g?y=D�a�[+�~8Tkԇ�\"+�����7���}��&���776�l�\"���n����������RG~����=8<hx��b9���P�fd|�R�p��d��\0���k\n�+Xjp?tRG\n�L�i��0�c��\'��YS?\'�t�V�\0��QB�:�c��z},	Ktku\rAx&$Mf�v�I�?4\n��=?��0[�#]ǉ[ǡ ��/N����?�V7���>{�t_�tr��~��E\Zh�C9����A@7��:s�?�K��b�Ԕ�C�;$Ob�+RHX�r>�F[���C�7�Zѣ�S��h�%[�x���9G���ɥ����H[\\�Z߸� N>ܢ�;}����c5	�TD~{����A\Z���?,8��I�!����C�4I� Ӟ5��[XнǇ\nvLB?����|3�%-P�0{��&�V)n]4u�g�k���-���;�?כ�z+U\0OC��U�\nj}�}N&��3��o�3EU��|\r0���YY����ؚ�x��VC8}��V7�?��B��S���tp����~��S�/���/�M�${Fd�N�>��1LL�`q`\"\"\Z=N�\0�BV�a�Sz_{�z�$>g��3��Or}^��r�[�?҆`���MB<O)��a�8\n�LMo�U����Qí���7����?:w�K�iz.?��d�L=��\0�\r#�3��?��%9?n��Mk���\Z��0�<�/Z�g *\Z\'������h�����5�Rnu�V[�k��O���d��8� ���M����3Wn�;˭yQ��J�d��2�����K<�l�t�1ˋW\'t�HOH�ZL�ڈPM!d�?�׫ݧ�\'?��X~ i�	�o:-�T���?��d�Hq�����I5*�WĲ*�%�7�`��&=��N��Tg04�uʉ��IZs��1cn�!��(A���l��	��C��?I�����PѲ{��j�R�V�/I���M�r7��QlN߈�U�\\}��?;��X|�[���z���@>��.�\Z�!�6�#��d-JvL���ׂ@��?�FwJU�/T�:c\Z����v�a����D!���b����/���	z�c��D]�tw FX1�2-d\n%��5/�T%6���k4a�|�>���i��v�2���<:|����uLI��1�u�a�i��m����pQIA���\\����)`�f�9?}P��QK�߄���M)2� :�w�\'�P4���1���!ʨGld���\'����I�����Q�7�S���iP;�����@:���n�:��k��#�\'@���\0���]lͯ.\n��d�[`��#�i.Q��#�\'���Dt��%!�D�zK����\r=+T�\rO`bh;?~�*\n,.��P����p֘�լA��6,�f�!T!=50j _�?���4��?e�%5 >0�>m6# �	�\"f�t���4�DG���	���焨�)��4\\��r��m�t?�W\0�\Z�?$��E;��6���&��r������r�5�S*z����zG�u������m���9?\r)��^�֌��3T�h�|?�UZ��\Z���2��T\'G�̡�>\0�\0dB�@۩MV������\\7�bO�(����-�p�1P�p m�L�SD:�Tⴺ��\n>�F��SWӳ@�`NM�$�g�\\�e��!PD�c�5�n���8��F�dϭUl#4�`k�8k4�,)5�]5?,<�4&ID�R<��B����F��]R�!�Ʈ Qr��ήP�\ZW�w���v,˃�7_*#b���G��\'/���4F��ϩ�3�m8�����B=�Y�\'�\'%׼�?l�0���t�0�;@�f�|~��?�&L�|P9~�\n)4_�5;�w���\rf�ų&LB�Fg$[���Г��	>��?̵??��3K;�=�<X�.�V����RҰIT�r>\" �?�E����E��z�pK튺\ni/�@?��㲔D���Kq�\0QF�V)�$�(H�&�?���jQ�DLI��ﲒ\r���FZ��;s�ba���f?�L�������i#�b�*�/�lW�a^f*�ķ᰼��z���W�����r�/R�[��߲j����w�Ws��=?&�]t��5��3��>\r�����G�x��\Z�(�X%����E@���J�X���jP㟧�i0�t��\r��p	Dq����MS�\Z���+s-�I4v\r�sү�J$ʢ��p\"ݖ�r�2�������Bؾȇ+�M\'=�a����k���~���_*�P������8Gm��dE�A47��!����`�M�W*� ��������yb�\\9F8R�\0��+\n��uޥf?�j%eXs8�E�3��󋠂����7|?�+7<�ph������1�	yy|b��\"\r�D��zv��딭\r���D�\0�F��������k���}�ⴢ�	k�q\'\Zz���t��o�Qᗈ�\0�?�>��a�^Y9I	����\r�d�n?�T��\0F=H��8��iꕑZ}B<�ӽ�,��9���J?��هCKS�gS�GS���#�]�i�tU( n?v\"T9���VM����;U��\'\ZS����&���9���\'h�I�A� ����$�Xg��E?��:V9��wtZpʠ�#�>!���<���-IHT.S�8�t_N��:�n	`�В�;z�lQ\'��{MfE�\"�Ad@Xby?����\n1?�cN:F�<�P��m�$?t��c����l#��4�8��+-V�B�Z�l�����r��Q�[X)?�X�b�?���n?�%?��b1���ئȫ�{���s�?7G��_�^�\r���?0\'Pz�iH%X��M����s�0.�),}/r���0��d8��S4�P߫UWߥ�w��mJ�?<8ah��7Ǵo2㮺]�ܹ�ca2Q�tL.Q�a������X>>���xo�����̛3�jB6]���4����iv*���?�u�&Na�\rh�����?��ި����ǿ9U�缆���o�X\\48NA���Rn���=�I� �ziq��ٻk���{�??��������BCȼ��51o�䑌GN�R�K�d�M��K�LcLRJK�r6f*6���9�P��:qU��9�pٛ�j�?�+23���~�?��\\F�!Km8��n�Xh���\ry]���E=x�n5�5չ���٨�c����YR�s�?��>�X��m(�����\'J/��-{(?s���֠��|�;\0;�?	�2��k��@�?�XJ4���SB ���4�d���?*�2?76�Q�@���Y��a[\rш��@\nKV�[yq9YY.�򜂜�?4��1��h?/Z��<3ZT^���Lx=m�\\�uX�UA�\Z\rD���i�cͺ�v��?q�?j\Z��U:i�L\nX%bB4�V�l�t)77g�&?#�x\Z��u�E4#5�rb8�N��G�`R�nיN��?\\������$Ak��߮��o��~��e;C�����k�/�\nAx??�����ah��R�Cա�%�t���z\ZB�,lq���G�x�t�9�?�)�s4��n�.~�8fS^��tY����x��6)?�F�*�< .�~�t���h�k��~[�N>�^k����[��)gК�N�Y��淼�eq�/�A���V�3�?�w�X)gP�<��f�O�do��P� \n�\0�Y��z���y�eF�u��Pu���xFF�y���s���	�Bn�!bC�MiMp�0���i�\Z͜18��s4Ϟ���(��v>|������W�Ǉ�ϾR�:��P?��cN*ܷ����nпN�������=��,\n��P&��j�Dp�z:��\r1�nwb�3��^16�+�R3N�E_\n�Q*��\0��>i(���D@a��)1O�~�h�?k��iq?�apF�*(!\Z�}+�qA�ЋP��ѥg\"�\np��������K&ܥ�5J&^�H��!���d����w�	eh�c&=��U�F����R^�|?�E����_Aq��%�\"� wm��)AL�V�R���H�ec�r�`ND2�	�{�	�f4-\'+�8��N�h�;�G��I��)�h4�JW��$���d�����e[oJ�c�P8Ct�\'	yt|T��� ?I�Q��Ud�C@=�RF�a�gM��J��H\nC<cʨ�V��pq�z�O�v��P��)��¸��@��&ǴK㾉ވ��{ͳ�^n}�A��T �#��������\'���?D�tk6�(.z/Sj\"�(��&���o^a��X�s`[8��B��/��4��\"�«���pUܧ��(�$9���D{���8ǜ��<���<���u54A��\'\\����R.v��\"�}L��C9���߅	�9�᪘��)\n�GV�|G�zm�a���H�q�//Tթϻ��\n�M�i���4dR͒�9y��\\��!U?����`����y�D��q�92B�m��~/8�9��$ɬ0�ΡK��9�;�QCX���D{�Fk*�Ad���{��O��i��F���.AJX��Ĥ�次��Zd�NG�]���W`��w&Ơ4�+�<�B c�	�?N�]��Br�\rf�HR�g۔w:/k�w{\Z�f���Ȳ[(S�l��fŴb�B�\Z�P���}#� z$�IHYP�pVD�\ZE?�{��?;H5�]�p�&M��o{`DBڪ���Pz��\0�D�#\04^�`�YZ9Z�1����߇���)Z\Z�h���?\0�/I���������e��������V�������ڂ�$�l�Z�\0���ie�a�V?L���?��	;�JB�񟘫��5n3�@,2��<?�r�%4��4s�`��q���r?_F�ϟP�0�	;O<�,?.puCz�T\"U@��l����*�{�?ɥJ�uja�bC���ҿ;\r�F?F�Dy621A����4�¶]\0G6�8Hh���~?K��>?0Zܚ�Z_�&�[#�w���fV���ͅ>�VC��|�Y��7vh�����4/2���$��2�\'�F:s�r9�>n]�\0��~���?{y����w?�?;6�^=烀�o�c�Γ�O�1g���7�l�����v��FYQi�?�����ߤ�! ���Xk����a3(�p��XmBS$?8���{���L:�O%qc�O�}3n� \n藜�T0\"^6 �iL. P�H�����}�2�In���u��R�>2,��|!Q��I��%�\r2g~W�\n02\'N\0FqQVq�z��S\Z\'�>t!e1Oи�3�S3?Wwp�D	�1�eW��Kl�,��A���?*b[\"1JTfS��q���g�+fÄ4P��WY6��a����2|�\\O5��ʵ�ٯ4�����?2��(Y������Q�fԶ����yb��@3��H�_ ��b-\"�$d5������y7㰴�����\n����P���4�q��q�?��jm6l��΢Z�p��k�(��q������S� yn�[?ߓ\"�?p��VM����!n_�A���7�V{~�����3�o�����\\�������?��yҷ���ݙ��%�)����\'l�Y�;͒S�\n�?&�J�\rJ`�\\�V?�Oّ���FP��?$���8G4@=�p����?��;��	?�*���?�FW�w��XԔ2$��y</�yz��É�E�E��&TK�?>��J�&���-��i-��8��O��m�eG�e.�\"*�7:m<���2����h0��{V?�E�Cѡ��bޟ获��^>FD<�Jri\\�\'}h���I8��T����?R��m��hitd�k-<�y\nA�*�`�P\0Mǘ�_�Co��,P�Z�2Ew�Ow�>�h��\"h�?c�5嬟q�I��?2�1)�$*�VM2�O�)T��?h�&<\rF�������c�M���++�&�\'�-^׼�&�� L\0��4�P�\\��1l�٫����\".q�L�Q�b\\?R)\0׉i�M$RN�`\0���R���+�ep����� ��7^\0?~�`�#�.����h?HH����t��9���}�\0\0|_~��ДP��\0�����O?��\r��@\r�?���OO_�=�}����I����P�.���By֓\0\n���mN\n5>����2��/���7;���*�;E�«��w��W�H{������v��R(��r@x.\Z�Q�/Ӫ�����V��%�մ��BΔ�;!�+E	?���0@�\ZjT!�<�����OB��\Z�5\"_/�ny�[D��JTeW��M�vw�����S��*0��>0��5�0w+���ɕ�I�Yt/��t	���.���R��#�6R\Z��I=lꗜi��j|���vr$�.;ùV���s�R\\4�cC]�$s<��Dt��v�k$�_�J,�b:fΗ���s{��F�4�`�\Zu�#�$Η�b��$b�TM\r���դ�(�7s~s��L�3pM���n&Ax{W��z���k���4^ti�iDz��c�!��x���I��\'L�!�\\�?F��QQ�},�⣤?�H��B�w-�*o��1���I��DF]a^���� ��T���u�ou4�H�v�A��Ut�uP?�m�?#D�??3�5����\0$�W���mW03`�s>��/�t?���f�6���M5�v\'W��J���vO_ab�/K���VQ��Q�9~�ӕh.A�W)�\r�I�KF��P��>aN��07����Va�T�r�?-ëM�Q�I����m�?�U��M��mo_j�i���?��Hp:�L�~k�P�n�S��nW;T\"Ei�Bh�63h��(�X\"� 9v��1� ?�y��˰7͌b�f���Z��L�8�YK���8���bƵ���(�I���Az����ƴ��J�?��t���\'�~I�N��F�\\�.�n,&)Hl;!ίPF|w�H�_��<w\n��V?3e�x��\"g��#q�����������1?����6���m|���5��o�Y_��g?�dr���O �#ٕ�ӗ�p�?\\���y��A,�����/�iQ! �\\�+��#���(���(�ν\'�#xǨ\'{v�����M�(s�\'X�D\'j2��W]ZE����x��S0����\Z��W��^<}qt��ھ�ӧ��&Pg��a��H�j�Ŀ�N�����\\?U�X\0����~�q�ܾ��?�?^/��L��)FV\"�s��0$^����rO��ui��lΚ[��hh���P]��?�3&�&1�ԡ��W�����V�3�x[@��u���uv6�?�i�x�L	AA6\"l�\r�f�(�K�\'S�]���O�v����}�|������tl�s�����N��B�=,��S,�\"?��?��-`Bu�*.*Ԟ�K� �av?�о����?_���i�hw:T0��(AY�@�m�s�\n\"�s��6� 2ڰ�?(`�?�1����&Q=e�jFo6LL<�I��&ߓ�����GQ��UݙG�������b��=yB\'~��Qz8G�xB�6�z��h8��v�)\"��b4��ٔld��{��>gMU��#4d���\ZyW�(�J ?���6�]����.%5�c6	��:,�Y�N&��R����/25���3`�05��-���C�k�L*?�U}65Po\rD^W�L5S?ԥ�\0���c�T��S[Q�=���4���?�n�{�����s[�W�xT�Z��J[��,��r��YmM�6==��\\�!Q���dX��$y��N?0�š�!�z�o�������(-y�*����j�u��\\�N��\Z�4z�$p�Y1�ǌ��A�R��D�ʃ?�#��K�W��J����0(�Dν��(b򴱨Uj:q��\'\Z-�B��\"���*��α���uJq5Ʈ����\'���lp����=+fJ&@/B1-?��f�Ĉ9�\r_Q6�V�Ux�#vyJu΄h<�?ʫ���]Ŝ��v��{\r�q��w-��:���Yԛ$�EӦ:�{��κ@b\"�(@��?��tU�</?�ԸDM�~�=�NY7�f�����OFST���x�����#��@�>}���G��O�?M?�����_��6�Dl�7o�{w�;�w��ݭ��֭�+�F���>�ջ�tf9$�M��&�5�s�h��\0	gM��iO\"��MeZ��0껰��|<I�Y?5�5L?�SLv���{\ZA�?��^�Xݣ���4�ڢ�����*S�W}&V��LtØ��b)B����б�sAM��Zo>�q?���Iꅔ�4�����Lm��Ɍ�?m��\Z���cz?�һ8����\\���;�M���R}�Ǻh4-t<�� QZ�5?�9��^����W3����=��?E�+��e?�V�>?-vD~z�X�?S�L6��b��s6%�x\"QBG7��fyln�خ��?{y��c�#4����\0�s��Sb]��?�������?��]7OU�^�#�Z$��e���}����S&�黩S<a?�I�ٯ�?�Eh�?!�1z�w�׷���g�?Y;6?�Dݩ=1�&��3Z6	�8�ON�=����M~�~Ҙ_,���8 ��m@׾ݸ�y8��j�^���.��&\\jG]�v?��$�j���?�����*?k>�oT�Dg���,wm,��b��v�?\0�p���z]��۪�P�Y?aont\Z�Tia\r?�A���_��r��6���pg4T�@�|ݸ@0^K?�\r��?82I\0cl ���]ϡ�&�����(���N���Y�AX����B��\\�n�l�?�����]u8K����_���C�T��\0�wM��*}w@�Rt^�g�ݔ�I���,D�r��o�f�y�g����:��S����@��d7�,��+���P�R�\'�.��6��Je�W,|�t�?A�-���\'l�`U��ay��2�d�M`[�j�R�=Q������3\'hD���w����@p��eg�P;�5?�]�΅wm ��ܡ7q�.CD�#����n�����0��cX��\"�vN��{��M�3�lF3�2���l�tc�N�b�<a/N.��oY�����&\r]�þ�V*ࡷ8�@?�͡���z�n�\r����;\r:߿z��? %gЙ���]�9aN����?&��tV�e�{?��A�_� jW�q�\Z�kP��&��f�ea��\'aX6f�-��\n0Eg։Wj�e��2ajR��E��[-^I%���\"ב�鮤,dհJ�r�YKsu���C��Z�o�˼<\0���S�?�Ƙ?M���L\",�߇ح��	Bf�\n�Q����Bl`yz��H&��S�x?\n�?�\'B.�t߰���̓�A�xgܙ��}4-�[��ζ��+L�?|�@(<�|�)����#��0@��=�4ۚzk�ق%�]��t�%�>�t�j0?�\\�*2ڲ|-�;!�	����cS~��/6j�Sk�N]mH�m~K�����q��t�Q�?�����\\y�������N8	VAv�!���f?�?*:�����e=��f(6ߨ�\0U����/���gM��e[�\0Y	����w>0�\"=p����)>c4��|��B��?&�;��,y�V�a��Y\0�u\"�q>�8=�)�c\\t?�����)�3��j�OE6�O�uwո��;��5�N���̰10���F\'���?�\'���@3�5b1��������GZ���ŖoT�t#�`�����B���ѯ�?���C�̓�3�Ĵ�d��Z�àWӱ�y��n1%�&���%�)��9B��L��\"?m�H�f%\0:sj\"\"6�bI���b2�N)��hU��8UgӀ�㵭�0��QѲ�܃��?�u�o�?5�t��?Bޛ�!��%�Tn�l�+,�?�v_������n��++�9��@lG.��%u��\Z�Ŀ��n4|3C:����*F֦>lK#H4�NS[?�-���ɔ�,A\Z�-���a��0�[\"�\0�>?�E;�rK?i��i;��M\0���g�?Y��\ZJ�䦘��)gSW��Ρ�o,z�0�cf��G\Z=b墸��&�Tw�a�o�(9r������Ϫ�Yl�Tf60��5����IV��)�����_��BF�����gh�*���1�.���R:�QO��P�B�\\#]�8�}�����\"��_�m\\�;���z���IF��\"��Z�z�=K���#�`J�R?���j*N��i=��N�>1�؜\"��!ւ�Q7Q4�100�?װ}0R�(�?�bn�W�x6�&Ê���\r�X�(	l$��]�w���5g���?\"b�%EM���O=ć�c*\Z���Z�̵z�{��U٧˵�5�Q��<�G���\\J^\"Y����ê��\'��Ӥ�$\\h���r^�x݈��/ޑ������Y^��F?�扗?bG��ر��A��$�:(Tp��?�J��\r��g�����g9�R�Ҫd4�6�po�i�v\Z��Vv+<c9	��?zq�!�[����B�?}��B^�ɯ|�?WhP^�Su��?�&Hx�6E�J �`xU6��\r�2��������Yw�Cy�wgd��o�C�)&���	?c���>&�`)4x�G�K:���N˘.��nkpF�g\Z,]���;�jN��^ߗ�����B(����KO�#\ZbS��{��ٶ	}�dx�2���ҥ��dL�L��+��0M��2���L�!��?�z`^Sj,�8,�!#U�#?\"��?��`����?��玃�y�!̟���������Z4?�e���5gm)=�Bu7��Q��{J��8�.��M����\"��={�I�Ls�ʜ/��:�X�RL�ԧ���\r�e������\\�\"ړ���sX�!�A�\'��)[��S:��n?�����~��z�K_�\n��:`���hO�vk�K�?N/��Y�\Z?���.`�Q��&�æ\Zc�\Z�C��w�c,�Z\r^��\r��?2`\'��l	�Z�--�������W�(�H.���]YRЕ��.�	[S�Й�@V�!����8�ޠi�A�8����t�)!�,W�̣���,Y���#-S�{�%��Td������?�!��7�ƈiЫ?)?��V�@��9�52?3��i(m�C�y� �?;�_L%�<�qw��;���C�U�_	\'l]���rci];�֠��HL��Q��=�0��Zmt%�X#(�cA����0���M0	u��-O�YK�k�1e]E_�{o�� ��y�b(���7�]m�L�y�w\r��7�KN�(�=k��~�\rw��}��{����C�w�{g��Hȭ���p����?Z��]Y��y�7|7�D��������]{	��C�mѶ�.�ƽ�?{Y�q	�l��?�-�К����bI=ל�4�7?Q*��8�\\I|�?�?��ΠX?\n�͎�����)��t��g�[Dƥ|a��aV�\r�QeS]c�rAe�(�\\����f$�?\n�c	v;��	��f8�K!�ҴƳQ��(�	�?��)��4�$&Gbt�\"\"��@@�?�7ϧ��?M��?GIv�6?�^�t`�&�3�;�o�;ӷ,�l�\0D������Ç�e���&���Y\0?]�F��=D�\ZN��bԪ2���ȶ�h���$���?{9d�؞N\n�;�J�?_\"�A|�)!�&F�|%�t[�C�j��O)�V�i�\Z��^��K�k_;3�qD8SD.�����m�t��-�we\'����\Z\Z��_�h�f)������#�K)����i����[�\0aEq�E�m��9w]V�L�9�ǀO��=�~Mji�	?��0�hR5�Um?`�)�]��TsE.6��2W����d\Zי�:��=�z�}8S�07s�k�{1�S��7�׬�?�o \r�4#,)@��=�4�3SZrz�H��_��H���En?C��I�2�$���T�؊^��0����cX�:�\"=~��F?���?[\r���?N?�?_<}uB�ܽ�\ro��ݠ�]	�[�E��754�I��[S�?��7�?D-Eg��|�ˊ^�\n����\0�7�m��h-<D{Fg?f`�&Ә�[��4�Y*&IF1h�Ӕ:X�/L����m������u���hHr�XQ�ט���+4]߼ӾӠ?\'�Ӿ����!y����bS2<2K�q?��F�����9}�-�\ZM�CSI9������Z��+��Ǿ�qW���6�*5�w!��d�x#���|A�&�ɫ�4d�,����<Ѷ��J0�z�?�a�������F���wC��D��?[TuV����U\\�jq�Sw�P��ۭ��b��/FI����^*/8�Ja\"��D�0x4#<�TZ�mIs�f�9��z��g-�5Ղ�ю���&*}��q�η���X����Z�\'7�~dH��%����+�s{�0X�0�?÷@E�κG�k�m2���!qFi��j�{��Z�*�T+1����H[k�FG;gf}M�I�`���F؂��0��.r����X����+woߖ3M7v���@?�;�rU�j�0����?m�[Te�s�+�d\n�C��ANԣ�==�QY��Y����fu��5�1Fg�ރ[�)��U@а=σ�E�\Z�.ȂwA`n�ٲw1�cm�VG��@\Zd��u��?L�>�v���\0����x����p�>}?��Io�m0�vZ?��?{���m*�hT<Sή?Y�͙g3�eظ�Q��yhq�H0�q�جjrycȎmH��\0�{%�6F]z�pK�����?z���tx��m�T\ZM�Y�5v�N�������t\'�N&#��1�_\0�ɡZǛ&�sX3\Z:j\"I�̊0�#L1w�X�������!�uC_��Q�>4(�!i�Pt��Mh?bxC���I�lL��nz���?+��JM�?4s�L�?�\0�01$���Cn참\n_��18��q��q�9?7��z8�4p��I,҅��y\nX%�^�\"k�����q;2�4��~)9�t����vfS	Q�@���?j���FH�]��O8��E��ܤ?�k?p�h�v.����?�Y��?:�`���xʑjx��!������l=?[���P�%�P�D^��a8ȸ0/ �K9��˒qC���m�&|�^ܘfK0 9���?��fR@�^2� ��)Cݸ��ܢe@���g����2�%�4�4�(:K&&{���Tp�>�M���Çh���K�	�>���\Z#�l��d=N	��C�?��l������bȨޚ�9�y�K��X��.W��P�FH�y9\r���K��,�Gʺ����GV�c�9?MK�+�hP��u�}N��FJ�e��߬�;P=J֑��A�[ge;d�_���;��N1�M��+!H�d���TX2����N�O��\"��\n�\nZh�\nTߩ�i+��-l�f�nU�@KUl�veR!��?�Y�h��Yʷ�k����[�d0�8@)�b��1��w��s�6yI���wNh?��s�#�[T���zJT>\rmj��qU1�ȈN�2��5�_���D��/r~�Gu���|�GF�|?��[|*�:�m�Cu��qk���M\'T��ͣ�G�K�#�l��<\\߸�i7��X�����{3����[��?�e�/tA�¢�_�\r��J�^�V�hR+��xp?�W�[�^7\n��g�*�x��[�~��!��?6/?��?��;o�~pI��ܒ�?������7����w>��%%W(#r�u������.|��	�XG�6��4���]e-��DdB��:����9&���N��b0?\Z?so[	�_�$9���9�H����頣ςw!GL��ZU@0z4G]�p0�z�����[\'V�>�3��p$à�N�}&�WzN�����VmrwKN6x�|�(!଒�r?�O\0�%m�?��?�������W������Ϛ���;��4	I�m��ǽ-�X\\Q�{�J �*�괷W$�^�5@��m�&�F�ֽNc�\r�W6�������E�æXG��a��6X�acCB���?y�z[�<yJ�X4�W��^<\"����P	���?���<Z���xC\0r`�c�ea6	&��N���d�?�)�Q?�n������A�/BN7K6�硵�uO��nw�V�k�ov��f���K���Rߗ*����2�Z��?9eR��?:\'�h/QGE\n�A$-Ft���8DP��+�WF��$j�_�����4�?������p$���)�Y{��f��jtJ�m�QSe��	�#>�B��/������YS�� �?E����6��S�)L�M��Na�nn�Tm��궻C(���v�QHs�hD���A��c�h0��p�뫹��s/��Gʲ\0S��{��eK�V�a���l����R d���D!��_�Vț�w�����9��G���\r�H�IyZ\'C,:�y��z>Ծ��c����h����(��7���������{����ښ��pk�[=E�e��R�_7իXg	�X�|aM�o�w�j�#!Y�@Z�w_�o���8K��6�9�l�B1�U�����R#\\�	�P��qN�!INYh�p)]�����:M`/�:�鄽����@��`�X=�`NGu�->��{�w��\'>XAk��a�aW	5���3��-� �<rH�_�<�?0<������IM��g�\"#jW;7d�������]E����]L�H���:���Q\"%A@N)���Q��^�����?�Zi���Ԩ��`�qݨ�M���q����P@�?��tRf����a�\Zk^�g�u��2�V��b�dJE�ڙ�p�s\r������?�I�?^sj�?!���?;��1��?���xϓ�Jt���ijPPi�D?�C����F?k��|�>m�bCGB��\n��qX?Q+��u!?\r�?s����0�-��������;���ؖb��U�	��w;ʥtu��Й��xZ\\З��z��H��E��Թ�8;�u�L�)���DYv�$�tb�-\"t%�kN�u�4I�qZh\r�?��$�`���d�Q��t����h�9�?V�+�թ��c<\Z$x������K�Y�Бu��T���v�Z�`#����03�lPM��+V���j�3�\'�c� ��?����k\0���ї��?���7kfS�b1r�Q�����V���ղ-��y���Q.�&��<�/ī����u5]�y?.lj�7f4f��hz��;�c�8�1�6�Ђ�(A\n\"��k`?^���+�9����E��\\�˹[x�:�A[3È1�1Ӡ��FɎt1�k�1k\\��6�F����u��$/��hh\\+n�l�N�kG��-�����/\Z��0����Ѓ���+9���]nOJa��\Z?`M�\n���KQ��Nvn�r��9�_5�+�(�ߕ��܎����>����vi[���)�q�\r9��n+��4��vM�\\q�����uW\'6fґgӘ4Ɗ����io?�	{v�\\T@1��3?J�?��D�(�cѷ?�ax��g��xW�q�<���X?ND+M5FOj����V��O�m�iS�꒦O��9�Ԗ�c�A��`綑Z)e}A�b��$�ȯ��!������%%wTk��g�s7�R��Wj��#�U�N�]\'�{����s������^�p\Z\0���|f�?׼��c��T�#z�{���^<?>9z�w���5�ﰫ�������w��]l�O\\�{��w��M���|9б��Wj�:�?����6פ.O*yͪ���bQ.ĥ$�����\0D��5��h�!�8}���8�}�tl/�$��Ow����x�me??��\Zζ���<t��?XZڑp�c?�QR��9K)�EdJ��g$���p�gD�emQ?�0��S�p8lJxsT�a�(�s���)^����j�<��%?���ڭ�H���E[�(ג�M	�X�ƌ��?Jl`�&���\n���)��D\Z�#�.��j?t΢^��X�DA�u��\n+\"*�ү�{�B_�D��\n{�	����dw�A��*脗�:?�R�n��/S���U��Kf(�pH��+������\"��������Pq3��+��lY�<����aggPJ����?�(���ܵ,ͱ�*�*�D��ry�Y\Z?�?�&�	{�k��~ñ����d��\nX�jqo}�*�^\'�����E3��s�uZ��e\n�C�J��+`(�6�k�0����#B-�c��<��LS��&�E?�&D��$N\'�+k������[C���T�\nkE��R$Mot/0�+�p{�?0?w�������V�X�\0��H����{�p8.9�aX#\'\'{$�!P��6�)���c���-��U[��e����\Zf�*o\'��F�+J8�v��R?�DȌ��5�\n�S�o*]�7�x�Z�H7s�h9�:�|��4M�Ǻm��\0����U��1%�#]En����s���=I��B����#\0o�juBWr�~�\r�$jٯ����`�4�5}l��Ya�{D\Z0���19|�X>�}����w�.��:R�a�-l�T/h�ѫg/�5?2�O�xuR֬ü0�rMS`A3n\r��\r³R�;�sI��E���矿?�Xh���s�w�������|�����?��Ě���D�X��A\Z�Ľ&��\r��_T���U��I8��ׂF��R�l?��O?{|���`��Ҍ���l�G�^zř���*��fs�\n�<����C�vj8�DJ�T�zd�US��531�4�5+�͌Z�?���k��\nG�{9I��z��I5�W���G\\� ����+��mS\r�\\�a����S�ۥ��л�Y⼴^V*�B�����O���)g���\n6�r�\nM����?�ǵ��T�_�?����w?�y���?���7�\\)v��(#u\"{բ&��?JQ���.�h��������#��{�\"��S�f�x�?�Q6�h�@�c�?�I�P��/NQ��=W�J3��h��?}�ӹ��X���\'\'�a���U�q>?�\\}J�7�-�uL�1Q|Ʀ�ѳ0} Rm����o�/˷y��L���ۘ:??6���뤱�/\"q?����c��I8��vH^�/u\'�F. i��Y?�4�R�&[��ּ&?����& �\\��\'y?I��?h���ɳݗ�����l?ff03��6�@*�M�nn�z��\r�o�\\��B��L�SbNr���g��1������\'���0\Z���3xy�R���c8���$�?N�s�F 8?(�\"6y1I`�R�Dݜ?&ũ?�v�9�*�&gZr����#�E ���4r��&bA?�$A�fmԯ>O@�AL*A�Q�b�ӻ��d���z\r�8L2X�.N��HGN\'-D�w�F�:9z�o����c�p���R}CO����4��4Ի?�������L��^�b�zιfВ��ބJ?v��C�yK8��%��6مv{�vrr��aO��~�Q#M�Hyr��R�R�`I3�߹\0�(�T-�������hH�.�q(=�$�O̮�����:�u���V2�����p�g\Z��	�Y�?5???>c�Z$�椉�\">��AI���3o�~�E7k����rW(<fio��\ZD���L;���\\sRT��l�Gf��|���lȽK�?~���D2������\'��F��0&�)��8O/G(�]����3�^�RL]�Rq�?�=;&��S*\r-^�Kv})miV���\'�.@K:�gmG扚��-U\r�����g��`����*��6��\n�Q��;\n�1?�u��\'\Zmז�b���=�l����/?���Y�J|���?���-��A@)-�B�S�g��60��i�b���J�(���+.L0��\'7�J�}���NUR���#t�H��e-#W�� ��Gɕ��3|VH\"��MD��@1�1]��K��F�7|��?y�\'��v�?�g\"�	�9\ZO���D�����^2�q�V�doܻ�]������z�&I:\Z2��t��?�_�	$6? Ұ\r�}��R�Q��|\nE3�b%��\'!FX�D]��)z����$p�??���>�?R/��ӧ����r��Ǧ{{�[�/�ov\"6ڛ�ս��??�ͻj��Vgs��M�2���{�+�%�f��|`z�)�,���%��y����>?��O?�����cL<�?�Pi�f8LL����������FP	w/T9��w?�H\Z�8�7dzk\'t,�Cl(e�2�>x<i2?�\0©`\r��Wx���?�W+����PB�\0/ &��[�%l��(b�r�$���+u8(�һ\rв?\0z����Q�]s���\0�`�΃1FHS���\\DiȖs<!=�p��\\�g|O,��\r-]c	�)���{�΢̕�MN����?l��0?�tHl>3&,Bn�I�?sVXgʢ+7��h\n�uB.�m�}�y�a�9{�dƹ[ϓ8������=��ND�K|D��5���8��f�;I�o���J�\ZEU�ǋ� �^���,L[�?��bE�Y;6�̌ȄVK��7Nk������ɳ����f�$FF1�D������m�׾ݸ�ݶ�O�rw�^�٢���HJd2F�v��kbY�����?���ol4�������NP}s[E꾺�-��Ⱥv�!�D\r�\0��k<�����u��=��1��?�%�2-�!p>�U��BC�(ɭ��z��6�+R��TN�?�Ė��ω��k�U<I\0{l ��ȡ�&���\\�X��>j��\Zc�n�i^n?�v�QGDf�k;��!R����T呂1Z�J�$>��m���2Fn���M���)�0ګg5ڼ�3ǔ5��( ܇i��W�z��m6(?\'֕��^�j(?d�r��ɪ9W�����IN�ß����x���_lЖMm�F�˺��72��b�a�{��Nr�?��NEC4��Ɇ5�MbC�_�ö8Ք�\\�����T�ܡ�q��K3��6X���*�?��N#�M�\09�4�79�+\'��יY;+���y����38%hT]��r�jr�N.��hY,�y���|\r��.��(?�^�u�u��*FP��=�q@f��%�v��BMŮ?���e\0�oNG)˵�Y�U�m��Aa�:3���i?p��r�%������U9��a�pUa]`^<��.�ҋ��E��$OG�����n�Wm�j�n�W�j �C�ӹ�wť�`5.��\0�|�â�?f�K�\0�<���cZ+���������]^!���9�O��	���!ަbz�	G$�74��#�d6�7�)��VF�.��G�IA�w8h1|GS~�&�F�%1��v۹�D�?��h��:?�I۱2g�Y�a;�Y�;ɒ>*�q>���?4WG�0���E)k?_\r�yi<�a�z��NM�ĔV~0A��5̾*W~�Θ~�K��e%�������� m��J�:8�?�KRs�2��	�j�c�j]�)��)�����f��7M&qJ��e[\Zy�x�1a#g�6�x6i����\rN���=�y��c�z��$�s5MO/?�R�ى�W^�1�ߕ00sF��E���>���k�PSy[��,ްI��>��;�|M�ϓL����&S�9?0��:;)C&��M*QV	M����t�:MY�ث<b�t�/��O!��	���=a��\r���y����%���^��Ah��s��ѥ�L�v�����f����0o���;2w�4\r����[��[e=�(e��}�?���\"�}YW=Sz0�X̤3�\0��-�K1\rXI?d1��~h)�?�/#�?8���l!�?J\'ͦ��8��&��P$�.@����H��\0��Lo�;K�[p?ϫ#2M�k��z�w�U��N�uE�h1$�ǎ���#��#t�0��ƨF�P�/5�DVUao>�$�?4�?�\"�2�dJA�q.�N9���٨�y!�`6����ł�]M���v�%7?�\\\"�έ:kC��	Nd6����`����8�O��j=�*ݔ��I}�,��v����U*�(gdQ�Nn�oB��|�ʷMa���H����k�AR��ԧ�|�gc��<�}cVjv�C��C�~>��AփU�b蔗���f^4l��|�V��T(����	]>@|�vh�;�\\�2���|��f�q%�u/]��=��6�<���$-\\_.d�?�ǣ?�8��4���Q�b�1bB�4f�,}\"W6�s5���\\�~V1Kn�?^�ʉY�]��W2��\\�e�[H�r�e-9�̧�?d~�?�GU����*����w�PӒ��c?e�b�?�$�%K���g)�M��\'�����*�Zr�	or�#u����.y�?�3��\ng�\'Й?~�Pak\"vi�~�Qj�{2��BI�[�.�jKճL���1��� �!�?g�2m[��*��s�����B�rRʯ�ݧ����D�sf\not��i�\n�!�j@=9|~b }?�(]��3a8v#1\'�y3Ջ6��rsD4C��?p��y#)�y��7�U-+t�ٌ�#�;6)7����ڳ��?/��?`E&�yu�9^9�7���ACQ3���<�ʺm\rO?#�y���7�>���Uf�Xh��M�CS�)5Lc�8�P��a?xB�ǉ��w?(Ш�y�ܷ/���eՙ�����XKa�����̔X1���ci�M2/G~w�A�Xl���4��z�lP�NuC�7y�z�dP4�E�o�χk|[ݖ�=��n�ߙ3?e�3?>|XM�=ho?��i�k4��[��?7\rS=Љ����qI�YY���M�����wN������q�:*���35Ĭ?n�K\r�A���=A)q��u��\0\Z	���LB+�������Q?˹u�C��\0�?�\Z[2����J/�|HM��9�F���9�\r��86@�F#�C�{c���Î��v�EYX9�	#����M��{?%LF7″\Z�(���_S@k���5e��l\0�@2���\"�s��� ��|�D(�v�M�X�6}+��䲹�KH%��3\"W6cbkH���D-���\'k-i��ӧM�i��G�rL�I��~k?K����(���5���/>�]���.4k��*\"|0[���amI3fw���Pĵ�1�\0�L�/A����;3#X�}�=\"\0��Y)^��5�#��-R2��)\'JyQ�#�π�l�j�����%��u���5���B���	T�A�Y�?�B�3ߚ}�c�qG��U�m��u���8��R��+Uh����\\��&�??*��E4�g|�k_@�VDZ劜��B�a$�-RL~�\r�B��B�H�S�a��;W�*�?7���+O	��и�*���3̽�]H?�\'��WnI|�$,&��섛�F�y&�IϠ3˸����}=0�)?ͨ��|�m�#2V�ó�\\�L��|����`�\"���p&9�6�9;�E��X\n�b=.�x�Rz���Y��ԅك)o=�@��O�3L�\Z_t�� �h�,8����tѮ�\0��`<IH@k�#t??�=���!R{42���\n�J�1��sj�1��R����2 �c�a�A?J�\"�r��*��@��\0�6Wt�A�@l2���v0�0�:��<�B����F��9��:?�&��W��pٜ塬Ib�&=}�0qw\rM��譡i��cL�j��t>\0��fS�6?���)?\"%nB����t2	5�:�뜡�Bv\'�l����g��W~�n�;��G}��e-?e�ߌ��Cv��r���?����߃59��0n��U�?��-����|\"�T9B�>�RZm=?���?�ʢ?>�dkژ���?��K\\Jhk�;\'� ��d��x��V3�o�޶�m�=�m�?z�\Zu9ڔBi?�r\0=��Ĭ�{�?X�%���^㚱�������\n9~M��?���ymG�i�w\r?\'t?X�V�������|�b��M1\r�t`G��?��{	�r=����\\�妤GT{h.|���$�U�\r�5����Lo��mO^�S�\Zo%w���hm�0:S��>��g�?W�zx�<Z��yd�� V�X	Ц������:\ng??�����v2	0���x�]/�QJ��i�������m4^�\'����8��Q<hunnv�m�ӷ)?Z_�,�wV/ir4�e��k??�L�8�&b5�\\��?H�l�B@02}ƞ�l%��Q�K���]$����\\���x:�W0{a?=Y����ٔ��]�%4�o�7�d�l��[�\r�D�ɂxGq��ƿ|\n§ {�XI�r��~�P��\"�z��L�Q �\r^�ս3�1h2?��/ /,?O��P�M��cGW�UM�|q?�O\"��	�F���S�j&���9��T���j�B�!iM�����>\nX�l\0�$\"����~�Krh0��\n�o�r��H���?77q+ܹ�nN771(Q]�5������i� �y@fs���#�8�Aj;ZD�@�� 5�P_{\r���I�#���藴�+E��,���a�?�b0TyVZ��f�V#Y�IB�����H��WV�BJg��%�h��D?��\"�5)�W��au)xrK�n�$��B1?����l�nb�}�ôo7��9x,���%�	ܯ�¬��>�3��HV����?y���?{���52l�+\0_��?t1�����ޟ���?ͻ?�omu�a��Y0�����X��`J��]b0����&G�\'�T�Ү�%��e��Ԍ��\Zd����7?]�|�]2Vװf�t�L���9�<9^\Z�׆8Į�ٗ�6�L�O��K�[H�\'1G�?g���v�_���~�P�Y�a?��#j�\r��{�X�B���X�}JxDG�?NN/w:M�;ÿ�!���3t�v�\nM=����|m��\r���#1����\"��S86E܈��v?��۶�E5H�+�7�ߵ7��`/(�}0�ʞ��2?�8\Z���q�S�&q<�~ru�CK�T���o5�ˢVS���re��VT֯q%1V1�-�hH�����H�V�5Ir���b��Ⱥ�ɧ\\����B�\\���X��	¥KqO2A��[�bd����d�=��s�0t͸	�j?Ps���aB[���d;�ϗ�h[��!���xv++5sr�����6�Q?K�Baݤ| \"��t?�����X^�,6�M�[M%�A������IϹ�vI�u9���V|*?��>�,��Y&v���5\"�\"�a��\':��;��o-�;����Ë!E3*��� ?g��]~ĲL����8.�A-�3�.�X�?Z���F1���B�L�*G�\\n�\\��LX��	ǰ�6�[W���u��?LY?�����\"��j�&R?�&h����5V�^��g�J�������G?��\rF�Zvm�SB�&h�J?h���.�?�@Hxq4\r�d��L?E��%`z�姾�w�LZCI�h_d[fB�p;@�Hͼ�p:�Զ���\"�������H�@��2k(�?ֶc`���Cq�\Zd�m�\'IFvL�9�?A6��.I�y;;\Z��s4Tg�u�vvR^�3)o�Ⱥy;;��E�o�χ�>�_��J�R>�N������r~r�i�R`G�@1�(�8��B�`���]��֢7Z�6��ẗ����S�$蹥?8�?�\"5���5�+�<�o��8��q,�w`�������8�c�\Z��?}w+���?ͯ�~�O1р��7����d���g�S@4Y��B��V����?���1�\\�LQ�\"�I(������O�%�y2I*?��x��ҼӮ��fD�p���Q�(�����6�y��#��}��%q�?�y��I�ib�b�6(	���9#�E#�ro�8^����b�!&.�z��&�]�/0����ԙC]�It���R���j�űU�C��բ�V��hiSm��S�����f�^?)�dj�v��91��yL��*?����x8�����\\o��^��lc���]��Nf)S҈�	�	?�P!����\\k���2�^*W{2�o�C���E�R:�l&�<�,S?�pe�R�?fj+e�ʋ}o�$:������ уAR7�U �ǰ����`:I>z\\�)��`=�`�k;�\\~��?���1I�� &RҔq\0I~X�]d�ј�\"(�{��?��������������,����}���ŧ��;��~y�u����{��٣�ǛG�?�����p}�n���s�\\6g�^=Pu�����[���b�/tA�¢�_�\r��J�N�CP���z�<��߫\\��\\	���3[zF<�^��\\	��?�?x�hu	b7�s���������-���?�\r|��?�|����?YRҤ��\'F<Z�?�6?��� ��ǫN�\'��Ǯ�)�=ےT�\0�����֚y?iuR�Y%�e�s��3�ܡ�\n�+̡?ςw!G-ǜU@FPJ��!�����A�3�,�P�sY�M���;z��;P�,���W~ۘbz�/�:g3`�b8X�Ţ;�@dI[��������������U�5{;���*�??%(t�����ni��E�+��Y�4�uou���I_h<Ѻ�)	f+-���i:�h_Q�K��~�p�m�����:%�Z?9Y��6�y�\rd�{����ދG���hCO*A\"�%�L)����Y����`��7 \'�8�^�h	��(�g�v?韟�̙��-�d��o��h����遲����_b\"�Kg�h��G�|U�� �`�Yd������#�{?I� ����WA�������8l4%��4\rӪ�x��9���y9Ħ�`I�FM痸�)_0:�dk��p�[���4]�kZ}��4���&��v��K`���;>ܶa\"�\'7] ��B6K����;���٘���?�2-}�˯#S�?ze~��?������D$�2}�1�Y?��d�|HH��;\0ͫ�?�-E�5�B����\r��4��4�Dg?Q���>z�g�S���2/?�l�����.��������cV?t�1�-,;aA<>���ǲИ�o!�WsV�,\\tW�?\'f��p\Z���%��?>��������F9=(W����V��H������7�$��(s���:��8�vNq,Z�_\"G��ϗ��/bF�{h���X ���|�ߛ?[7������oֻ�f��++����M��7Wz磤��s�=��ڟ������Ƣ���?;�O����o�Ѣ��GO����?:>}b�7�}O��g\ZG�a��y�=�\08���G\\�p2:�S�c�b����\Z1p-�l[T��K��귚r}©�(c��fY�E�G��L?q�XY��\ZZ�|��K�&`?(N���\r\Z��\Z��y\n��e����ݾ�?��������������������������������?�?�\n��\0x\0','ross',0,0,0.00,'','','','n');
INSERT INTO tiki_files VALUES (2,1,'test','Adding an entry to test the full text search function.\r\n\r\nHere are some search terms:\r\n\r\nJobHunting\r\ntest\r\ntiki\r\n',1040868439,'license.txt',26430,'text/plain','		  GNU LESSER GENERAL PUBLIC LICENSE\n		       Version 2.1, February 1999\n\n Copyright (C) 1991, 1999 Free Software Foundation, Inc.\n     59 Temple Place, Suite 330, Boston, MA  02111-1307  USA\n Everyone is permitted to copy and distribute verbatim copies\n of this license document, but changing it is not allowed.\n\n[This is the first released version of the Lesser GPL.  It also counts\n as the successor of the GNU Library Public License, version 2, hence\n the version number 2.1.]\n\n			    Preamble\n\n  The licenses for most software are designed to take away your\nfreedom to share and change it.  By contrast, the GNU General Public\nLicenses are intended to guarantee your freedom to share and change\nfree software--to make sure the software is free for all its users.\n\n  This license, the Lesser General Public License, applies to some\nspecially designated software packages--typically libraries--of the\nFree Software Foundation and other authors who decide to use it.  You\ncan use it too, but we suggest you first think carefully about whether\nthis license or the ordinary General Public License is the better\nstrategy to use in any particular case, based on the explanations below.\n\n  When we speak of free software, we are referring to freedom of use,\nnot price.  Our General Public Licenses are designed to make sure that\nyou have the freedom to distribute copies of free software (and charge\nfor this service if you wish); that you receive source code or can get\nit if you want it; that you can change the software and use pieces of\nit in new free programs; and that you are informed that you can do\nthese things.\n\n  To protect your rights, we need to make restrictions that forbid\ndistributors to deny you these rights or to ask you to surrender these\nrights.  These restrictions translate to certain responsibilities for\nyou if you distribute copies of the library or if you modify it.\n\n  For example, if you distribute copies of the library, whether gratis\nor for a fee, you must give the recipients all the rights that we gave\nyou.  You must make sure that they, too, receive or can get the source\ncode.  If you link other code with the library, you must provide\ncomplete object files to the recipients, so that they can relink them\nwith the library after making changes to the library and recompiling\nit.  And you must show them these terms so they know their rights.\n\n  We protect your rights with a two-step method: (1) we copyright the\nlibrary, and (2) we offer you this license, which gives you legal\npermission to copy, distribute and/or modify the library.\n\n  To protect each distributor, we want to make it very clear that\nthere is no warranty for the free library.  Also, if the library is\nmodified by someone else and passed on, the recipients should know\nthat what they have is not the original version, so that the original\nauthor\'s reputation will not be affected by problems that might be\nintroduced by others.\n\n  Finally, software patents pose a constant threat to the existence of\nany free program.  We wish to make sure that a company cannot\neffectively restrict the users of a free program by obtaining a\nrestrictive license from a patent holder.  Therefore, we insist that\nany patent license obtained for a version of the library must be\nconsistent with the full freedom of use specified in this license.\n\n  Most GNU software, including some libraries, is covered by the\nordinary GNU General Public License.  This license, the GNU Lesser\nGeneral Public License, applies to certain designated libraries, and\nis quite different from the ordinary General Public License.  We use\nthis license for certain libraries in order to permit linking those\nlibraries into non-free programs.\n\n  When a program is linked with a library, whether statically or using\na shared library, the combination of the two is legally speaking a\ncombined work, a derivative of the original library.  The ordinary\nGeneral Public License therefore permits such linking only if the\nentire combination fits its criteria of freedom.  The Lesser General\nPublic License permits more lax criteria for linking other code with\nthe library.\n\n  We call this license the \"Lesser\" General Public License because it\ndoes Less to protect the user\'s freedom than the ordinary General\nPublic License.  It also provides other free software developers Less\nof an advantage over competing non-free programs.  These disadvantages\nare the reason we use the ordinary General Public License for many\nlibraries.  However, the Lesser license provides advantages in certain\nspecial circumstances.\n\n  For example, on rare occasions, there may be a special need to\nencourage the widest possible use of a certain library, so that it becomes\na de-facto standard.  To achieve this, non-free programs must be\nallowed to use the library.  A more frequent case is that a free\nlibrary does the same job as widely used non-free libraries.  In this\ncase, there is little to gain by limiting the free library to free\nsoftware only, so we use the Lesser General Public License.\n\n  In other cases, permission to use a particular library in non-free\nprograms enables a greater number of people to use a large body of\nfree software.  For example, permission to use the GNU C Library in\nnon-free programs enables many more people to use the whole GNU\noperating system, as well as its variant, the GNU/Linux operating\nsystem.\n\n  Although the Lesser General Public License is Less protective of the\nusers\' freedom, it does ensure that the user of a program that is\nlinked with the Library has the freedom and the wherewithal to run\nthat program using a modified version of the Library.\n\n  The precise terms and conditions for copying, distribution and\nmodification follow.  Pay close attention to the difference between a\n\"work based on the library\" and a \"work that uses the library\".  The\nformer contains code derived from the library, whereas the latter must\nbe combined with the library in order to run.\n\n		  GNU LESSER GENERAL PUBLIC LICENSE\n   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION\n\n  0. This License Agreement applies to any software library or other\nprogram which contains a notice placed by the copyright holder or\nother authorized party saying it may be distributed under the terms of\nthis Lesser General Public License (also called \"this License\").\nEach licensee is addressed as \"you\".\n\n  A \"library\" means a collection of software functions and/or data\nprepared so as to be conveniently linked with application programs\n(which use some of those functions and data) to form executables.\n\n  The \"Library\", below, refers to any such software library or work\nwhich has been distributed under these terms.  A \"work based on the\nLibrary\" means either the Library or any derivative work under\ncopyright law: that is to say, a work containing the Library or a\nportion of it, either verbatim or with modifications and/or translated\nstraightforwardly into another language.  (Hereinafter, translation is\nincluded without limitation in the term \"modification\".)\n\n  \"Source code\" for a work means the preferred form of the work for\nmaking modifications to it.  For a library, complete source code means\nall the source code for all modules it contains, plus any associated\ninterface definition files, plus the scripts used to control compilation\nand installation of the library.\n\n  Activities other than copying, distribution and modification are not\ncovered by this License; they are outside its scope.  The act of\nrunning a program using the Library is not restricted, and output from\nsuch a program is covered only if its contents constitute a work based\non the Library (independent of the use of the Library in a tool for\nwriting it).  Whether that is true depends on what the Library does\nand what the program that uses the Library does.\n  \n  1. You may copy and distribute verbatim copies of the Library\'s\ncomplete source code as you receive it, in any medium, provided that\nyou conspicuously and appropriately publish on each copy an\nappropriate copyright notice and disclaimer of warranty; keep intact\nall the notices that refer to this License and to the absence of any\nwarranty; and distribute a copy of this License along with the\nLibrary.\n\n  You may charge a fee for the physical act of transferring a copy,\nand you may at your option offer warranty protection in exchange for a\nfee.\n\n  2. You may modify your copy or copies of the Library or any portion\nof it, thus forming a work based on the Library, and copy and\ndistribute such modifications or work under the terms of Section 1\nabove, provided that you also meet all of these conditions:\n\n    a) The modified work must itself be a software library.\n\n    b) You must cause the files modified to carry prominent notices\n    stating that you changed the files and the date of any change.\n\n    c) You must cause the whole of the work to be licensed at no\n    charge to all third parties under the terms of this License.\n\n    d) If a facility in the modified Library refers to a function or a\n    table of data to be supplied by an application program that uses\n    the facility, other than as an argument passed when the facility\n    is invoked, then you must make a good faith effort to ensure that,\n    in the event an application does not supply such function or\n    table, the facility still operates, and performs whatever part of\n    its purpose remains meaningful.\n\n    (For example, a function in a library to compute square roots has\n    a purpose that is entirely well-defined independent of the\n    application.  Therefore, Subsection 2d requires that any\n    application-supplied function or table used by this function must\n    be optional: if the application does not supply it, the square\n    root function must still compute square roots.)\n\nThese requirements apply to the modified work as a whole.  If\nidentifiable sections of that work are not derived from the Library,\nand can be reasonably considered independent and separate works in\nthemselves, then this License, and its terms, do not apply to those\nsections when you distribute them as separate works.  But when you\ndistribute the same sections as part of a whole which is a work based\non the Library, the distribution of the whole must be on the terms of\nthis License, whose permissions for other licensees extend to the\nentire whole, and thus to each and every part regardless of who wrote\nit.\n\nThus, it is not the intent of this section to claim rights or contest\nyour rights to work written entirely by you; rather, the intent is to\nexercise the right to control the distribution of derivative or\ncollective works based on the Library.\n\nIn addition, mere aggregation of another work not based on the Library\nwith the Library (or with a work based on the Library) on a volume of\na storage or distribution medium does not bring the other work under\nthe scope of this License.\n\n  3. You may opt to apply the terms of the ordinary GNU General Public\nLicense instead of this License to a given copy of the Library.  To do\nthis, you must alter all the notices that refer to this License, so\nthat they refer to the ordinary GNU General Public License, version 2,\ninstead of to this License.  (If a newer version than version 2 of the\nordinary GNU General Public License has appeared, then you can specify\nthat version instead if you wish.)  Do not make any other change in\nthese notices.\n\n  Once this change is made in a given copy, it is irreversible for\nthat copy, so the ordinary GNU General Public License applies to all\nsubsequent copies and derivative works made from that copy.\n\n  This option is useful when you wish to copy part of the code of\nthe Library into a program that is not a library.\n\n  4. You may copy and distribute the Library (or a portion or\nderivative of it, under Section 2) in object code or executable form\nunder the terms of Sections 1 and 2 above provided that you accompany\nit with the complete corresponding machine-readable source code, which\nmust be distributed under the terms of Sections 1 and 2 above on a\nmedium customarily used for software interchange.\n\n  If distribution of object code is made by offering access to copy\nfrom a designated place, then offering equivalent access to copy the\nsource code from the same place satisfies the requirement to\ndistribute the source code, even though third parties are not\ncompelled to copy the source along with the object code.\n\n  5. A program that contains no derivative of any portion of the\nLibrary, but is designed to work with the Library by being compiled or\nlinked with it, is called a \"work that uses the Library\".  Such a\nwork, in isolation, is not a derivative work of the Library, and\ntherefore falls outside the scope of this License.\n\n  However, linking a \"work that uses the Library\" with the Library\ncreates an executable that is a derivative of the Library (because it\ncontains portions of the Library), rather than a \"work that uses the\nlibrary\".  The executable is therefore covered by this License.\nSection 6 states terms for distribution of such executables.\n\n  When a \"work that uses the Library\" uses material from a header file\nthat is part of the Library, the object code for the work may be a\nderivative work of the Library even though the source code is not.\nWhether this is true is especially significant if the work can be\nlinked without the Library, or if the work is itself a library.  The\nthreshold for this to be true is not precisely defined by law.\n\n  If such an object file uses only numerical parameters, data\nstructure layouts and accessors, and small macros and small inline\nfunctions (ten lines or less in length), then the use of the object\nfile is unrestricted, regardless of whether it is legally a derivative\nwork.  (Executables containing this object code plus portions of the\nLibrary will still fall under Section 6.)\n\n  Otherwise, if the work is a derivative of the Library, you may\ndistribute the object code for the work under the terms of Section 6.\nAny executables containing that work also fall under Section 6,\nwhether or not they are linked directly with the Library itself.\n\n  6. As an exception to the Sections above, you may also combine or\nlink a \"work that uses the Library\" with the Library to produce a\nwork containing portions of the Library, and distribute that work\nunder terms of your choice, provided that the terms permit\nmodification of the work for the customer\'s own use and reverse\nengineering for debugging such modifications.\n\n  You must give prominent notice with each copy of the work that the\nLibrary is used in it and that the Library and its use are covered by\nthis License.  You must supply a copy of this License.  If the work\nduring execution displays copyright notices, you must include the\ncopyright notice for the Library among them, as well as a reference\ndirecting the user to the copy of this License.  Also, you must do one\nof these things:\n\n    a) Accompany the work with the complete corresponding\n    machine-readable source code for the Library including whatever\n    changes were used in the work (which must be distributed under\n    Sections 1 and 2 above); and, if the work is an executable linked\n    with the Library, with the complete machine-readable \"work that\n    uses the Library\", as object code and/or source code, so that the\n    user can modify the Library and then relink to produce a modified\n    executable containing the modified Library.  (It is understood\n    that the user who changes the contents of definitions files in the\n    Library will not necessarily be able to recompile the application\n    to use the modified definitions.)\n\n    b) Use a suitable shared library mechanism for linking with the\n    Library.  A suitable mechanism is one that (1) uses at run time a\n    copy of the library already present on the user\'s computer system,\n    rather than copying library functions into the executable, and (2)\n    will operate properly with a modified version of the library, if\n    the user installs one, as long as the modified version is\n    interface-compatible with the version that the work was made with.\n\n    c) Accompany the work with a written offer, valid for at\n    least three years, to give the same user the materials\n    specified in Subsection 6a, above, for a charge no more\n    than the cost of performing this distribution.\n\n    d) If distribution of the work is made by offering access to copy\n    from a designated place, offer equivalent access to copy the above\n    specified materials from the same place.\n\n    e) Verify that the user has already received a copy of these\n    materials or that you have already sent this user a copy.\n\n  For an executable, the required form of the \"work that uses the\nLibrary\" must include any data and utility programs needed for\nreproducing the executable from it.  However, as a special exception,\nthe materials to be distributed need not include anything that is\nnormally distributed (in either source or binary form) with the major\ncomponents (compiler, kernel, and so on) of the operating system on\nwhich the executable runs, unless that component itself accompanies\nthe executable.\n\n  It may happen that this requirement contradicts the license\nrestrictions of other proprietary libraries that do not normally\naccompany the operating system.  Such a contradiction means you cannot\nuse both them and the Library together in an executable that you\ndistribute.\n\n  7. You may place library facilities that are a work based on the\nLibrary side-by-side in a single library together with other library\nfacilities not covered by this License, and distribute such a combined\nlibrary, provided that the separate distribution of the work based on\nthe Library and of the other library facilities is otherwise\npermitted, and provided that you do these two things:\n\n    a) Accompany the combined library with a copy of the same work\n    based on the Library, uncombined with any other library\n    facilities.  This must be distributed under the terms of the\n    Sections above.\n\n    b) Give prominent notice with the combined library of the fact\n    that part of it is a work based on the Library, and explaining\n    where to find the accompanying uncombined form of the same work.\n\n  8. You may not copy, modify, sublicense, link with, or distribute\nthe Library except as expressly provided under this License.  Any\nattempt otherwise to copy, modify, sublicense, link with, or\ndistribute the Library is void, and will automatically terminate your\nrights under this License.  However, parties who have received copies,\nor rights, from you under this License will not have their licenses\nterminated so long as such parties remain in full compliance.\n\n  9. You are not required to accept this License, since you have not\nsigned it.  However, nothing else grants you permission to modify or\ndistribute the Library or its derivative works.  These actions are\nprohibited by law if you do not accept this License.  Therefore, by\nmodifying or distributing the Library (or any work based on the\nLibrary), you indicate your acceptance of this License to do so, and\nall its terms and conditions for copying, distributing or modifying\nthe Library or works based on it.\n\n  10. Each time you redistribute the Library (or any work based on the\nLibrary), the recipient automatically receives a license from the\noriginal licensor to copy, distribute, link with or modify the Library\nsubject to these terms and conditions.  You may not impose any further\nrestrictions on the recipients\' exercise of the rights granted herein.\nYou are not responsible for enforcing compliance by third parties with\nthis License.\n\n  11. If, as a consequence of a court judgment or allegation of patent\ninfringement or for any other reason (not limited to patent issues),\nconditions are imposed on you (whether by court order, agreement or\notherwise) that contradict the conditions of this License, they do not\nexcuse you from the conditions of this License.  If you cannot\ndistribute so as to satisfy simultaneously your obligations under this\nLicense and any other pertinent obligations, then as a consequence you\nmay not distribute the Library at all.  For example, if a patent\nlicense would not permit royalty-free redistribution of the Library by\nall those who receive copies directly or indirectly through you, then\nthe only way you could satisfy both it and this License would be to\nrefrain entirely from distribution of the Library.\n\nIf any portion of this section is held invalid or unenforceable under any\nparticular circumstance, the balance of the section is intended to apply,\nand the section as a whole is intended to apply in other circumstances.\n\nIt is not the purpose of this section to induce you to infringe any\npatents or other property right claims or to contest validity of any\nsuch claims; this section has the sole purpose of protecting the\nintegrity of the free software distribution system which is\nimplemented by public license practices.  Many people have made\ngenerous contributions to the wide range of software distributed\nthrough that system in reliance on consistent application of that\nsystem; it is up to the author/donor to decide if he or she is willing\nto distribute software through any other system and a licensee cannot\nimpose that choice.\n\nThis section is intended to make thoroughly clear what is believed to\nbe a consequence of the rest of this License.\n\n  12. If the distribution and/or use of the Library is restricted in\ncertain countries either by patents or by copyrighted interfaces, the\noriginal copyright holder who places the Library under this License may add\nan explicit geographical distribution limitation excluding those countries,\nso that distribution is permitted only in or among countries not thus\nexcluded.  In such case, this License incorporates the limitation as if\nwritten in the body of this License.\n\n  13. The Free Software Foundation may publish revised and/or new\nversions of the Lesser General Public License from time to time.\nSuch new versions will be similar in spirit to the present version,\nbut may differ in detail to address new problems or concerns.\n\nEach version is given a distinguishing version number.  If the Library\nspecifies a version number of this License which applies to it and\n\"any later version\", you have the option of following the terms and\nconditions either of that version or of any later version published by\nthe Free Software Foundation.  If the Library does not specify a\nlicense version number, you may choose any version ever published by\nthe Free Software Foundation.\n\n  14. If you wish to incorporate parts of the Library into other free\nprograms whose distribution conditions are incompatible with these,\nwrite to the author to ask for permission.  For software which is\ncopyrighted by the Free Software Foundation, write to the Free\nSoftware Foundation; we sometimes make exceptions for this.  Our\ndecision will be guided by the two goals of preserving the free status\nof all derivatives of our free software and of promoting the sharing\nand reuse of software generally.\n\n			    NO WARRANTY\n\n  15. BECAUSE THE LIBRARY IS LICENSED FREE OF CHARGE, THERE IS NO\nWARRANTY FOR THE LIBRARY, TO THE EXTENT PERMITTED BY APPLICABLE LAW.\nEXCEPT WHEN OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR\nOTHER PARTIES PROVIDE THE LIBRARY \"AS IS\" WITHOUT WARRANTY OF ANY\nKIND, EITHER EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE\nIMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR\nPURPOSE.  THE ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE\nLIBRARY IS WITH YOU.  SHOULD THE LIBRARY PROVE DEFECTIVE, YOU ASSUME\nTHE COST OF ALL NECESSARY SERVICING, REPAIR OR CORRECTION.\n\n  16. IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN\nWRITING WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY\nAND/OR REDISTRIBUTE THE LIBRARY AS PERMITTED ABOVE, BE LIABLE TO YOU\nFOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL OR\nCONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE THE\nLIBRARY (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING\nRENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A\nFAILURE OF THE LIBRARY TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF\nSUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH\nDAMAGES.\n\n		     END OF TERMS AND CONDITIONS\n\n           How to Apply These Terms to Your New Libraries\n\n  If you develop a new library, and you want it to be of the greatest\npossible use to the public, we recommend making it free software that\neveryone can redistribute and change.  You can do so by permitting\nredistribution under these terms (or, alternatively, under the terms of the\nordinary General Public License).\n\n  To apply these terms, attach the following notices to the library.  It is\nsafest to attach them to the start of each source file to most effectively\nconvey the exclusion of warranty; and each file should have at least the\n\"copyright\" line and a pointer to where the full notice is found.\n\n    <one line to give the library\'s name and a brief idea of what it does.>\n    Copyright (C) <year>  <name of author>\n\n    This library is free software; you can redistribute it and/or\n    modify it under the terms of the GNU Lesser General Public\n    License as published by the Free Software Foundation; either\n    version 2.1 of the License, or (at your option) any later version.\n\n    This library is distributed in the hope that it will be useful,\n    but WITHOUT ANY WARRANTY; without even the implied warranty of\n    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU\n    Lesser General Public License for more details.\n\n    You should have received a copy of the GNU Lesser General Public\n    License along with this library; if not, write to the Free Software\n    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA\n\nAlso add information on how to contact you by electronic and paper mail.\n\nYou should also get your employer (if you work as a programmer) or your\nschool, if any, to sign a \"copyright disclaimer\" for the library, if\nnecessary.  Here is a sample; alter the names:\n\n  Yoyodyne, Inc., hereby disclaims all copyright interest in the\n  library `Frob\' (a library for tweaking knobs) written by James Random Hacker.\n\n  <signature of Ty Coon>, 1 April 1990\n  Ty Coon, President of Vice\n\nThat\'s all there is to it!\n\n\n','ross',0,0,0.00,'','','','n');





CREATE TABLE tiki_forum_attachments (
"attId" integer NOT NULL default nextval('tiki_forum_attachments_seq') unique not null,
"threadId" integer NOT NULL default '0',
"qId" integer NOT NULL default '0',
"forumId" integer NOT NULL default '0',
"filename" varchar(250) NOT NULL default '',
"filetype" varchar(250) NOT NULL default '',
"filesize" integer NOT NULL default '0',
"data" text,
"dir" varchar(200) NOT NULL default '',
"created" integer NOT NULL default '0',
"path" varchar(250) NOT NULL default '',
PRIMARY KEY ("attId")
) ;











CREATE TABLE tiki_forum_reads (
"user" varchar(200) NOT NULL default '',
"threadId" integer NOT NULL default '0',
"forumId" integer NOT NULL default '0',
"timestamp" integer NOT NULL default '0',
PRIMARY KEY ("threadId","user")
) ;











CREATE TABLE tiki_forums (
"forumId" integer NOT NULL default nextval('tiki_forums_seq') unique not null,
"name" varchar(200) NOT NULL default '',
"description" text NOT NULL,
"created" integer NOT NULL default '0',
"lastPost" integer NOT NULL default '0',
"threads" integer NOT NULL default '0',
"comments" integer NOT NULL default '0',
"controlFlood" varchar(1) NOT NULL default '',
"floodInterval" integer NOT NULL default '0',
"moderator" varchar(200) NOT NULL default '',
"hits" integer NOT NULL default '0',
"mail" varchar(200) NOT NULL default '',
"useMail" varchar(1) NOT NULL default '',
"usePruneUnreplied" varchar(1) NOT NULL default '',
"pruneUnrepliedAge" integer NOT NULL default '0',
"usePruneOld" varchar(1) NOT NULL default '',
"pruneMaxAge" integer NOT NULL default '0',
"topicsPerPage" integer NOT NULL default '0',
"topicOrdering" varchar(100) NOT NULL default '',
"threadOrdering" varchar(100) NOT NULL default '',
"section" varchar(200) NOT NULL default '',
"topics_list_replies" varchar(1) NOT NULL default '',
"topics_list_reads" varchar(1) NOT NULL default '',
"topics_list_pts" varchar(1) NOT NULL default '',
"topics_list_lastpost" varchar(1) NOT NULL default '',
"topics_list_author" varchar(1) NOT NULL default '',
"vote_threads" varchar(1) NOT NULL default '',
"moderator_group" varchar(200) NOT NULL default '',
"approval_type" varchar(20) NOT NULL default '',
"outbound_address" varchar(1) NOT NULL default '',
"outbound_from" varchar(1) NOT NULL default '',
"inbound_address" varchar(1) NOT NULL default '',
"topic_smileys" varchar(1) NOT NULL default '',
"ui_avatar" varchar(1) NOT NULL default '',
"ui_flag" varchar(1) NOT NULL default '',
"ui_posts" varchar(1) NOT NULL default '',
"ui_email" varchar(1) NOT NULL default '',
"ui_online" varchar(1) NOT NULL default '',
"topic_summary" varchar(1) NOT NULL default '',
"show_description" varchar(1) NOT NULL default '',
"att" varchar(80) NOT NULL default '',
"att_store" varchar(4) NOT NULL default '',
"att_store_dir" varchar(250) NOT NULL default '',
"att_max_size" integer NOT NULL default '0',
"ui_level" varchar(1) NOT NULL default '',
"forum_password" varchar(32) NOT NULL default '',
"forum_use_password" varchar(1) NOT NULL default '',
"inbound_pop_server" varchar(250) NOT NULL default '',
"inbound_pop_port" integer NOT NULL default '0',
"inbound_pop_user" varchar(200) NOT NULL default '',
"inbound_pop_password" varchar(80) NOT NULL default '',
PRIMARY KEY ("forumId")
) ;






INSERT INTO tiki_forums VALUES (1,'Test Forum','Test Forum',1038717239,1044982298,2,4,'n',120,'ross',16,'','n','n',2592000,'n',2592000,20,'commentDate_desc','commentDate_desc','','y','y','y','y','y','y','','all_posted','','','n','y','y','n','n','y','n','y','att_no','','',1000000,'n','','n','',0,'','');





CREATE TABLE tiki_forums_queue (
"qId" integer NOT NULL default nextval('tiki_forums_queue_seq') unique not null,
"object" varchar(32) NOT NULL default '',
"parentId" integer NOT NULL default '0',
"forumId" integer NOT NULL default '0',
"timestamp" integer NOT NULL default '0',
"user" varchar(200) NOT NULL default '',
"title" varchar(240) NOT NULL default '',
"data" text NOT NULL,
"type" varchar(60) NOT NULL default '',
"hash" varchar(32) NOT NULL default '',
"topic_smiley" varchar(80) NOT NULL default '',
"topic_title" varchar(240) NOT NULL default '',
"summary" varchar(240) NOT NULL default '',
PRIMARY KEY ("qId")
) ;











CREATE TABLE tiki_forums_reported (
"threadId" integer NOT NULL default '0',
"forumId" integer NOT NULL default '0',
"parentId" integer NOT NULL default '0',
"user" varchar(200) NOT NULL default '',
"timestamp" integer NOT NULL default '0',
"reason" varchar(250) NOT NULL default '',
PRIMARY KEY ("threadId")
) ;











CREATE TABLE tiki_galleries (
"galleryId" integer NOT NULL default nextval('tiki_galleries_seq') unique not null,
"name" varchar(80) NOT NULL default '',
"description" text NOT NULL,
"created" integer NOT NULL default '0',
"lastModif" integer NOT NULL default '0',
"visible" varchar(1) NOT NULL default '',
"theme" varchar(60) NOT NULL default '',
"user" varchar(200) NOT NULL default '',
"hits" integer NOT NULL default '0',
"maxRows" integer NOT NULL default '0',
"rowImages" integer NOT NULL default '0',
"thumbSizeX" integer NOT NULL default '0',
"thumbSizeY" integer NOT NULL default '0',
"public" varchar(1) NOT NULL default '',
PRIMARY KEY ("galleryId")




) ;






INSERT INTO tiki_galleries VALUES (1,'A Test Image Gallery','A Test Image Gallery',1040549893,1040868478,'y','','ross',3,10,6,80,80,'n');





CREATE TABLE tiki_galleries_scales (
"galleryId" integer NOT NULL default '0',
"xsize" integer NOT NULL default '0',
"ysize" integer NOT NULL default '0',
PRIMARY KEY ("xsize","galleryId","ysize")
) ;











CREATE TABLE tiki_games (
"gameName" varchar(200) NOT NULL default '',
"hits" integer NOT NULL default '0',
"votes" integer NOT NULL default '0',
"points" integer NOT NULL default '0',
PRIMARY KEY ("gameName")
) ;











CREATE TABLE tiki_group_inclusion (
"groupName" varchar(30) NOT NULL default '',
"includeGroup" varchar(30) NOT NULL default '',
PRIMARY KEY ("includeGroup","groupName")
) ;











CREATE TABLE tiki_history (
"pageName" varchar(160) NOT NULL default '',
"version" integer NOT NULL default '0',
"lastModif" integer NOT NULL default '0',
"user" varchar(200) NOT NULL default '',
"ip" varchar(15) NOT NULL default '',
"comment" varchar(200) NOT NULL default '',
"data" text,
"description" varchar(200) NOT NULL default '',
PRIMARY KEY ("pageName","version")
) ;






INSERT INTO tiki_history VALUES ('HomePage',1,1038712078,'system','0.0.0.0','Tiki initialization','','');
INSERT INTO tiki_history VALUES ('HomePage',2,1038793725,'ross','192.168.1.2','','LisasPage : About Lisa Walford, my honey.','');
INSERT INTO tiki_history VALUES ('HomePage',3,1038793754,'ross','192.168.1.2','','LisasPage : About Lisa Walford, my honey.\r\n\r\nNoHTMLCodeIsNeeded','');
INSERT INTO tiki_history VALUES ('HomePage',4,1038794026,'ross','192.168.1.2','','LisasPage : About Lisa Walford, my honey.\r\n\r\n((NoHTMLCodeIsNeeded))','');
INSERT INTO tiki_history VALUES ('HomePage',5,1038794132,'ross','192.168.1.2','','LisasPage : About Lisa Walford, my honey.\r\n\r\n((NoHTMLCodeIsNeeded))','');
INSERT INTO tiki_history VALUES ('HomePage',6,1038940707,'ross','192.168.1.2','','((LisasPage)) : About Lisa Walford, my honey.\r\n\r\n((NoHTMLCodeIsNeeded))','');
INSERT INTO tiki_history VALUES ('HomePage',7,1038971383,'ross','192.168.1.2','','((LisasPage)) : About Lisa Walford, my honey.\r\n\r\n((JobHunting))','');
INSERT INTO tiki_history VALUES ('HomePage',8,1038974004,'ross','192.168.1.2','','((JobHunting))','');
INSERT INTO tiki_history VALUES ('HomePage',9,1039232946,'ross','192.168.1.2','','((JobHunting))\r\n\r\n||row1-col1|row1-col2|row1-col3||row2-col1|row2-col2|row3-col3||','');
INSERT INTO tiki_history VALUES ('HomePage',10,1039233364,'ross','192.168.1.2','','((JobHunting))\r\n\r\n||row1-col1|row1-col2|row1-col3||row2-col1|row2-col2|row3-col3||\r\n\r\n||r1-c1|r1-c2||r2c1c2||r3-c1|r3-c2|r3c3||\r\n','');
INSERT INTO tiki_history VALUES ('HomePage',11,1039234052,'ross','192.168.1.2','','((JobHunting))\r\n\r\n||row1-col1|row1-col2|row1-col3||row2-col1|row2-col2|row3-col3||\r\n\r\n||r1-c1|r1-c2||r2c1c2||r3-c1|r3-c2|r3c3||\r\n','');
INSERT INTO tiki_history VALUES ('HomePage',12,1039617016,'ross','192.168.1.2','','((JobHunting))\r\n\r\n||row1-col1|row1-col2|row1-col3||row2-col1|row2-col2|row3-col3||\r\n\r\n||r1-c1|r1-c2||r2c1c2||r3-c1|r3-c2|r3c3||\r\n\r\nTestWiki','');
INSERT INTO tiki_history VALUES ('HomePage',13,1039617624,'ross','192.168.1.2','','((JobHunting))\r\n\r\n||row1-col1|row1-col2|row1-col3||row2-col1|row2-col2|row3-col3||\r\n\r\n||r1-c1|r1-c2||r2c1c2||r3-c1|r3-c2|r3c3||\r\n\r\n((Where\'sTheSearchBox?))','');
INSERT INTO tiki_history VALUES ('HomePage',14,1039617646,'ross','192.168.1.2','','((JobHunting))\r\n\r\n||row1-col1|row1-col2|row1-col3||row2-col1|row2-col2|row3-col3||\r\n\r\n||r1-c1|r1-c2||r2c1c2||r3-c1|r3-c2|r3c3||\r\n\r\n((Where\'sTheSearchBox))','');
INSERT INTO tiki_history VALUES ('HomePage',15,1039617668,'ross','192.168.1.2','','((JobHunting))\r\n\r\n||row1-col1|row1-col2|row1-col3||row2-col1|row2-col2|row3-col3||\r\n\r\n||r1-c1|r1-c2||r2c1c2||r3-c1|r3-c2|r3c3||\r\n\r\n((WhereIsTheSearchBox))','');
INSERT INTO tiki_history VALUES ('HomePage',16,1039618839,'ross','192.168.1.2','','OK, so where\'s the damn search dialog box!\r\n\r\n[http://research.salutia.com/tiki/] has it, so why don\'t I?\r\n\r\nI\'ve turned it on in admin, but no go!\r\n\r\nTable test:\r\n\r\n||row1-col1|row1-col2|row1-col3||row2-col1|row2-col2|row3-col3||\r\n\r\n||r1-c1|r1-c2||r2c1c2||r3-c1|r3-c2|r3c3||\r\n\r\n((JobHunting))\r\n','');
INSERT INTO tiki_history VALUES ('HomePage',17,1039739934,'ross','192.168.1.2','','OK, so where\'s the damn search dialog box!\r\n\r\n[http://research.salutia.com/tiki/] has it, so why don\'t I?\r\n\r\nI\'ve turned it on in admin, but no go!\r\n\r\nTable test:\r\n\r\n||esta es|una prubea||lala||1|2|3||\r\n\r\n||row1-col1|row1-col2|row1-col3||row2-col1|row2-col2|row3-col3||\r\n\r\n||r1-c1|r1-c2||r2c1c2||r3-c1|r3-c2|r3c3||\r\n\r\n((JobHunting))\r\n','');
INSERT INTO tiki_history VALUES ('HomePage',18,1039748495,'ross','192.168.1.2','','OK, so where\'s the damn search box!\r\n\r\n[http://research.salutia.com/tiki/] has it, so why don\'t I?\r\n\r\nI\'ve turned it on in admin, but no go!\r\n\r\nTable test:\r\n\r\n||esta es|una prubea||lala||1|2|3||\r\n\r\n||row1-col1|row1-col2|row1-col3||row2-col1|row2-col2|row3-col3||\r\n\r\n||r1-c1|r1-c2||r2c1c2||r3-c1|r3-c2|r3c3||\r\n\r\n((JobHunting))\r\n','');
INSERT INTO tiki_history VALUES ('HomePage',19,1039768550,'ross','192.168.1.2','','OK, so where\'s the damn search box!\r\n\r\n[http://research.salutia.com/tiki/] has it, so why don\'t I?\r\n\r\nI\'ve turned it on in admin, but no go!\r\n\r\nTable test:\r\n\r\n||esta es|una prubea||lala||1|2|3||\r\n\r\n||row1-col1|row1-col2|row1-col3||row2-col1|row2-col2|row3-col3||\r\n\r\n||r1-c1|r1-c2||r2c1c2||r3-c1|r3-c2|r3c3||\r\n\r\n((JobHunting))\r\n\r\nStem the Tide!','');
INSERT INTO tiki_history VALUES ('JobHunting',1,1038971411,'ross','192.168.1.2','','[http://losangeles.craigslist.org/eng/]','');
INSERT INTO tiki_history VALUES ('HomePage',20,1039947392,'ross','192.168.1.2','','Search \"Entire Site\" now works.\r\n\r\nBut the results are in section, then reverse chron order.\r\n\r\nThe results really should be in relevency order across all sections.\r\n\r\n\r\nTable test:\r\n\r\n||esta es|una prubea||lala||1|2|3||\r\n\r\n||row1-col1|row1-col2|row1-col3||row2-col1|row2-col2|row3-col3||\r\n\r\n||r1-c1|r1-c2||r2c1c2||r3-c1|r3-c2|r3c3||\r\n\r\n((JobHunting))\r\n\r\nStem the Tide!','');
INSERT INTO tiki_history VALUES ('HomePage',21,1040866181,'ross','192.168.1.2','','Search \"Entire Site\" now works.\r\n\r\nBut the results are in section, then reverse chron order.\r\n\r\nThe results really should be in relevency order across all sections.\r\n\r\n\r\nTable test:\r\n\r\n||esta es|una prubea||lala||1|2|3||\r\n\r\n||row1-col1|row1-col2|row1-col3||row2-col1|row2-col2|row3-col3||\r\n\r\n||r1-c1|r1-c2||r2c1c2||r3-c1|r3-c2|r3c3||\r\n\r\n((JobHunting))\r\n\r\nStem the Tide!\r\n\r\nAdding an entry to test the full text search function.\r\n\r\nHere are some search terms:\r\n\r\nJobHunting\r\ntest\r\ntiki\r\n','');
INSERT INTO tiki_history VALUES ('HomePage',22,1040866201,'ross','192.168.1.2','','Search \"Entire Site\" now works.\r\n\r\nBut the results are in section, then reverse chron order.\r\n\r\nThe results really should be in relevency order across all sections.\r\n\r\n\r\nTable test:\r\n\r\n||esta es|una prubea||lala||1|2|3||\r\n\r\n||row1-col1|row1-col2|row1-col3||row2-col1|row2-col2|row3-col3||\r\n\r\n||r1-c1|r1-c2||r2c1c2||r3-c1|r3-c2|r3c3||\r\n\r\n((JobHunting))\r\n\r\nStem the Tide!\r\n\r\nAdding an entry to test the full text search function.\r\n\r\nHere are some search terms:\r\n\r\nJobHunting\r\ntest\r\ntiki\r\n\r\nNewPage\r\n','');
INSERT INTO tiki_history VALUES ('HomePage',23,1041569358,'luis','192.168.1.2','','Dates and times are now localized!\r\n\r\nTiki rocks!\r\n\r\n((JobHunting))\r\n','');
INSERT INTO tiki_history VALUES ('HomePage',24,1041800610,'ross','192.168.1.2','','Dates and times are now localized!\r\n\r\nTiki rocks!\r\n\r\n((JobHunting))\r\n\r\ndate test','');
INSERT INTO tiki_history VALUES ('HomePage',25,1041822095,'ross','192.168.1.2','','Dates and times are now localized!\r\n\r\nTiki rocks!\r\n\r\n((JobHunting))\r\n\r\ntest','');
INSERT INTO tiki_history VALUES ('HomePage',26,1042143529,'ross','192.168.1.2','','Dates and times are now localized!\r\n\r\nTiki rocks!\r\n\r\nJobHunting\r\n','');
INSERT INTO tiki_history VALUES ('HomePage',27,1042143584,'ross','192.168.1.2','','Dates and times are now localized!\r\n\r\nThis server is running in PST, but is reporting time in EST.\r\n\r\nJobHunting\r\n','');
INSERT INTO tiki_history VALUES ('HomePage',28,1044981129,'ross','192.168.1.2','','Dates and times are now localized!\r\n\r\nThis server is running in PST, but is reporting time in EST.\r\n\r\nJobHunting\r\n\r\nLast edited at 8:30AM PST','');
INSERT INTO tiki_history VALUES ('HomePage',29,1045204033,'ross','192.168.1.2','','Dates and times are now localized!\r\n\r\nThis server is running in PST, but is reporting time in EST.\r\n\r\nJobHunting\r\n\r\nLast edited at 8:30AM PST\r\n\r\n[http://seedcuisine.com/|Seedcuisine] rocks!\r\n\r\n','');
INSERT INTO tiki_history VALUES ('HomePage',30,1045204274,'ross','192.168.1.2','','Dates and times are now localized!\r\n\r\nThis server is running in PST, but is reporting time in EST.\r\n\r\nJobHunting\r\n\r\nLast edited at 8:30AM PST\r\n\r\n[http://seedcuisine.com/|Seedcuisine] rocks!\r\n\r\n__text__\'\'text\'\'===text===||r1c1|r1c2||r2c1|r2c2||[http://example.com|desc]((page))\r\n\r\n__This will be bold__','');





CREATE TABLE tiki_hotwords (
"word" varchar(40) NOT NULL default '',
"url" varchar(255) NOT NULL default '',
PRIMARY KEY ("word")
) ;











CREATE TABLE tiki_html_pages (
"pageName" varchar(40) NOT NULL default '',
"content" text,
"refresh" integer NOT NULL default '0',
"type" varchar(1) NOT NULL default '',
"created" integer NOT NULL default '0',
PRIMARY KEY ("pageName")
) ;











CREATE TABLE tiki_html_pages_dynamic_zones (
"pageName" varchar(40) NOT NULL default '',
"zone" varchar(80) NOT NULL default '',
"type" varchar(2) NOT NULL default '',
"content" text NOT NULL,
PRIMARY KEY ("zone","pageName")
) ;











CREATE TABLE tiki_images (
"imageId" integer NOT NULL default nextval('tiki_images_seq') unique not null,
"galleryId" integer NOT NULL default '0',
"name" varchar(40) NOT NULL default '',
"description" text NOT NULL,
"created" integer NOT NULL default '0',
"user" varchar(200) NOT NULL default '',
"hits" integer NOT NULL default '0',
"path" varchar(255) NOT NULL default '',
PRIMARY KEY ("imageId")





) ;






INSERT INTO tiki_images VALUES (1,1,'Google logo','http://www.google.com/logos/Logo_40wht.gif',1040549952,'ross',3,'');
INSERT INTO tiki_images VALUES (2,1,'test','Adding an entry to test the full text search function.\r\n\r\nHere are some search terms:\r\n\r\nJobHunting\r\ntest\r\ntiki\r\n',1040868478,'ross',1,'');





CREATE TABLE tiki_images_data (
"imageId" integer NOT NULL default '0',
"xsize" integer NOT NULL default '0',
"ysize" integer NOT NULL default '0',
"type" varchar(1) NOT NULL default '',
"filesize" integer NOT NULL default '0',
"filetype" varchar(80) NOT NULL default '',
"filename" varchar(80) NOT NULL default '',
"data" text,
PRIMARY KEY ("imageId","xsize","type","ysize")

) ;






INSERT INTO tiki_images_data VALUES (1,0,0,'o',3845,'image/gif','Logo_40wht.gif','GIF89a�\05\0��\0������������������������\"j���\0>�\0/�,?(�<�6�&s1� B�;z/Q�������G�E�P�\nF�M�F�S�#X�+T�8b�<U�e}�Tg�o}�z�����������������������W�Z�;m�M|�Uy�l�Ă��h�e�(h�-r�?��\\��?�Х�ʥ��������������P��^��g��p��y�݊�圸㦻ٺ�������פ����������������������������������������������������������������Y|e-p-v�vPuP�Ҙ?�?q�q�ϯ���������������������������������������jm(�\'7�6>�=I�Hg�f��W�V����������������ބ�ʩ��-��W����?��������ƚ�	��\r��ի˭>ư^��K��i��������ߤ�k��{`�u/��������쮢��������������͹��ڵ������������¼������������訛����Q9�lW�zϡ�ั�������%�-�1�8!�>$ʌ��?�ͭ�͹���ͽ�!��%�0�3�:)�E8�WI�bW�}v�`[�yu��Ӳ\0�\0�\r��?\"�2&}1*?F=r\r������fff��������������������������������������������������������������������������Ļ��\0\0\0\0\0\0\0\0\0\0\0\0!�\0\0�\0,\0\0\0\0�\05\0\0�\0�	H����*\\Ȱ�Ç#J�H��ŋ3j�ȱ��? C�I��ɓ(S�\\ɲ��?���4G�͌��J�.�/4m�<����^��y�\\�5h���cf!s-czI�DɑH�(�E�tJ�|\r >e�d�fʘ�y\"�_\\�RI\0�Ko���eK\Z?c�(�\nV���8b���%�B�C1��`/������u���ɣƊ�v�.�4����`���@<y)JhpЀ�\0�������c=j��s�N7I�?�h�(A?��x����.=L�������ƞ�ޖ�&��Fp��v� ;[�S?#$0;��u����F�#�H稃���<d�� �3�:���\0�C�}\ru�QJ?X?LF�NR�DNL3��Z�y��];Wؕ�QG��9�� �$�q@=d\0!@�D�Y�<�|?@���-x��\0頓$?9?��\"���� ?�I$Xd�ţ,\0�`��l�1�2?SK*y�(P�\Z?�J�ىTp���C׈��N\0Y���,��.�0�L3��b.���Pt�3�\"�PR	%�$�#�|�NZ��3�EA9���3lA�|`�i;���-�,�����e��*9�PA�0q?=�3gAZ]�Z?ʂK3�|�8�D�K0�c&!Jy!�\"�0\"�)�8b�$�L�;����/Ȱ�1�p�1X����.�V������1��R4����)!���D���\Z `�\0\"�$MZ��2�\0��c\04����*[(��&�P�H<l��-N%�HB�+v(k�\r3���`�<��3t���s\n.ǰr=����/�L��:WU��Ap���U:�Y\0���\r*���pc��*�dq�!�`R�<��S�#�H�\'����A<��<��c< ?���qy�ȓ0�̣>�wS?7޴b� �T�N\0E��!;�x�^?e��G9�?�Ȱ�4�D(��@���@�ʭ�y�(?l0?1!o(A�\0�\0q����qe��\0���<�Q�gx��0�;������E�?\ZP� ��L.la\rR�)�p���\n`��\Z��#��N�bLhG\0��z�b���%��!l`\\��<\nP\0z��h@	� \07\\. �-�����x�3���VX�XG\'B�+�a7�\0Hp?�AQIMʉ:\\?�`\\��̤O�A�����`�\"&�UX?�XM:P�;\0����?&��:\00\0?���l�aa#�(�0l��h�C\0pd�\0P?N^�;�A0.У�@�����`a@\05n�kL#����!o���\"\"�	R�+7�HG;�2H|3�?(+p����?A��������,)���Y�m�\n*?(B�,��p@3\r��<!	C�A�0�������c�C��C#��bBSY�\'?�F$£�`�.���k�\0�0?}X������jH��$<��t��~\0�2�?��\0	k�@̡#�@3�\r`z�#�`�C=BTs�cŠ�7�@��q����&\0� \"�\0,`Q8�0@���L���G�a����%���v�J RD6?l�\nx@gq�sxA�Gn@�&�\n���1^)�w+�H�R{\rn�bpD�>FkU�n��&`�?}P`x\0��`<���\\L����4�Qx�hT�HF�Q(��8eR��\0�U\02|?h`�B�I;ޘ�n��\0+�u#(�	R��0A	B?8?ƴ68�4�@6�PF�~�.E\\�x$�x�|?ɫ�\nP/��}���X�6�qO����Ȇ�\nJDB�V\0�c2�B\\���]ߛ�@�������RQzi��clt����L���A��x�0�?��H�&�m�\0���\n��F5�qk�̲��+�}?��D=��?�r�>��8 0�B`WL��B��+���86���qd��0�.v�∸�:hB�\0\\ I�B\0��u�;p\0��k�����F5�a?Ƃˈn��`?;���$,!��bʠ���;��:@H�\Z�z���C� �3\\9�Eʫ��g���\0�u����x��\"@qx\09�;@�??���<vǊip�\Z�p4��a�C\0��ڴ�\nL��?��%*Q�P�A\0�k�:�J\0�`˱�,;�!\r?8���7��\0}�7�q\rk\\��`Ǿz��}\\\0��H0�H@\0?f�����,rO~V#\Z�x�)��C\n�?m���� �U?����M�y\08A\n9�A8 ?T�\ZhB@��C�� ��0�`��0P8�%g��?�zap�0\0�a��6n�C�S�}d\0�? ��Gñ�\'�@#`P�?`�����Q@3�|=?\0��#Pq\n@?<��x��`��@Vp�p�D�\Z���1L�6�W��q�(� �?�@�\0[\0� ���F�:\0�P�!\0MԵq\'A@= �:a��@y�\0?���G����Y�A0�@\n����1A\0pR�6\'���`t��\" �)WЉY��?��\'q6Y[����q\0�\0�5�8d�x\0����\0#``����WP���i8�� Vq���3R��X�_?�g�%���0\0\0\0��0�2\r##�x�h�W�Fp\r`/Da�@\0/h\'��x``�ҌC$W??��\'\r�Z�2#�&8E�9YW�$4aW@A�-�a��ylD�LT�Y�Q�FD��Hc�k)�QT\0T�@��0@��*��wO�H	(�%��%P��kRs�����j�Qv`\0��g2?e�OJ0�� `�줕L0qu$0m�/����#�Sli^��@V`@|!0\"`)�7���� Y}�\0>Vp�w?Cȃ�Y�,��-q�Ԅ���@�7�d�B��_\0!�(?{h��Ț7a^�\0\0����]@ံ�9!�C?1�l�$ʉ��y\0;');
INSERT INTO tiki_images_data VALUES (2,700,500,'o',3317,'image/x-png','background.png','�PNG\r\n\Z\n\0\0\0\rIHDR\0\0�\0\0�\0\0\0P;i�\0\0\0bKGD\0�\0�\0�����\0\0\0	pHYs\0\0\0\0��~�\0\0\0tIME�!(�Y=�\0\0�IDATx���Qn#7EQM��/5;�?��l?���,���?/d����_>\0`?���v�\0\0��}���?��\0�D\0\r\0@D4\0\0�\0\0Dޞk�\0vt���A��4�8;\r0�����^�h\0�TzzB\0�\0\0DD\0\r\0@D4\0\0�\0\0D,BB��F����1��4����i�\0��\0 \"\Z\0��h\0\0\"�\0��\0 b܉+�h�NWR�P��� \Z\0n�����\0 \"\Z\0��h\0\0\"�\0��\0 \"\Z\0��q\'��Ӏj�����D@IO�{�4\0\0�\0\0DD\0\r\0@D4\0\0�\0\0D�;M�u8\03��0!%=\r7\r@z\ZJ���h\0�֮�i!��h\0\0\"�\0��yZ���Y:\0������Y:|BO�/�;�|r��|@�/|���%=\r\r�+�4���i�\0\0í��N.��h\0\0\"�\0��\0 \"\Z\0�H�q�5�Y\0`Z}O.���MOg�\r@IOCIO \Z\0�?��CH\0 \"\Z\0��h\0\0\"�\0��\0 2p��5\0�l�ɥk(�i`v\Z�lz\ZJz��\0�-�t?B\0�\0\0DD\0\r\0@D4\0\0�\0\0D.BB#��f�?=ie(�i�\"\Z\0�IO�o\Z\0��h\0\0\"�\0��\0 \"\Z\0��h\0\0\"�?���p���i`�Jz������i&�M\0\r\0@D4\0\0�\0\0DD\0\r\0@ĸ_p ���4�A	%=ͦD���4��\0��\0 \"\Z\0��h\0\0\"�\0��\0 bܩ��\0��NC/\nJz\Z� \Z��i(\r�i�\0\0�\Z��B\0�\0\0DD\0\r\0@D4\0\0�N�s ��\\�NuAIO�jDp=\r��=-\Z\0�J?{�CH\0 \"\Z\0��h\0\0\"�\0��\0 ��S�k\0�֒\'��e��?�,\r@IOCIO�D\0���)!��h\0\0\"�\0��\0 \"\Z\0��5�N�Y\0��kN.]�@IO?�i��i(��I�\0f��\'�!$\0\r\0@D4\0\0�\0\0DD\0\r\0@�EHh�?8@�N�#����\r\0D�4�4\0\0�\0\0D�V���?�\0`���4,�C�\n=\r�t4\0%=\r%=��\0\0?�COϸ��\0S�M�ӵP��\\M4\04����?\0 \"\Z\0��h\0\0\"�\0��\0 \"\Z\0��q\'�q �;\r�5���Y�h\0HO�2o\Z\0��h\0\0\"�\0��\0 \"\Z\0��h\0\0\"�?��:�s�iX������aD�6=\r�#=-\Z\0`CGz�CH\0 \"\Z\0��h\0\0\"�\0��\0 b��<��X����1(�i�J4\0��Pj�Ӣ\0fР�=�\0\"�\0��\0 \"\Z\0��h\0\0\"�?;58h�9�vr�U!ANO��-\Z�������?h\0�����x	\0DD\0\r\0@D4\0\0�\0\0Dnwr�\0=�~r�Jz\Z����\0��4���?D\0?��;y	\0DD\0\r\0@D4\0\0�\0\0D�q\'-\0�{�ɥ�(�i`kv\Z �����w!\Z\0x��ޅ�?\0@D4\0\0�\0\0DD\0\r\0@D4\0\0�r�pp;\r�&y���9�h\0X?���4\0\0�\0\0DD\0\r\0@D4\0\0�\0\0D�;1��p�e�i`,\r\n%=�\nD��4+�\0��\0 \"\Z\0��h\0\0\"�\0��\0 b�i��N�t!��4<G4\0���P���E\0�O{�CH\0 \"\Z\0��h\0\0\"�\0��\0 b��������-�\Z��4LM4\0���P���E\0Ln���\0��M�/�Y��X�O�\n�%=�8�`iz�q�i\0\0\"�?~�\0|ſ\'~OP���D�5=\r�{Z4\0�;���?\0@D4\0\0�\0\0DD\0\r\0@d�q��Y\0`Z3�\\N[3p/=\r�c�h\0Jz\ZJz�t��5���y	\0DD\0\r\0@D4\0\0�\0\0D�wr�\0�z���A��4�>;\r0�����^�h\0�<zz)B\0�\0\0DD\0\r\0@D4\0\0�\0\0D�]��.\\�f�?U�a(�i�\r\0[���M\0\r\0@D4\0\0�\0\0DD\0\r\0@ĸ�qЛ?.#O���iC4\0�KOӆ7\r\0@D4\0\0�\0\0DD\0\r\0@D4\0\0�N�s @�N��$#��4D�Gz\Z\n�4\0\0�\0\0DD\0\r\0@D4\0\0�\0\0D�;��u8\0���0\r%=\r�\r@z\ZJ���h\0��.�i!��h\0\0\"�\0��\0 \"\Z\0��q��q\0pr�UP�Ӱ�\0����lO�\0kٞ�\0��\0 \"\Z\0��h\0\0\"�\0�4wZ��\0����c���4p���\0��4��������1<�\0\"�\0��\0 \"\Z\0��h\0\0\"��?\\�\0��F?\\�f?���a�N�����[\r\0\\OO��!$\0\r\0@D4\0\0�\0\0DD\0\r\0@d�\"$4�@�;\rlH(CIO�\r�\0���4�x�K2;��|�0=U%=\r�\r@Oz\ZJg��h\0�����v\Z\0��h\0\0\"�?�?\'m\0\rx���+��4s\r\0����ś\0 \"\Z\0��h\0\0\"�\0��\0 \"\Z\0��q\'>�@���i�3jJz�}����i��M\0\r\0@D4\0\0�\0\0DD\0\r\0@ĸS#����?�F���4\\D4\0��i(?�i�\0\0K\Z��B\0�\0\0DD\0\r\0@D4\0\0�N�p�F�\\�BoAIOÚD0���R��\r\0p?�=�!$\0\r\0@D4\0\0�\0\0DD\0Yoܩ�A\0�i����\ZF����֋������� \Z\0ؙ�~��?\0@D4\0\0�\0\0DD\0\r\0@�q\'�,\0��N.]�@IO��i���i(��y�\0�����!$\0\r\0@D4\0\0�\0\0DD\0\r\0@�EHh�?8���4��44��4?�h\0 ��y<�i\0\0B�\0��\0 \"\Z\0��h\0\0\"�\0�wbr��fa�?ɉZ(�in \Z\0:�����\0 \"\Z\0��h\0\0\"�\0��\0 \"\Z\0��q\'p �#;\r 4���Y�h\0EO�8o\Z\0��h\0\0\"�\0��\0 \"\Z\0��h\0\0\"�?��:���iX�򃒞��D�0=\r��=-\Z\0`7{�CH\0 \"\Z\0��h\0\0\"�\0��\0 b��$��X?�˓H1(�ih�ힿn>7`Sz\ZJ=�.��M��\r(���\0���wѿ\'`&=>7�rzz�����98�\0\"�\0��\0 �ո��4\0p�V!��#x��\"[EP��P���\0(���<�\0\"�\0��\0 \"\Z\0��h\0\0\"��;�f�6�=�t�%=\r��NLHOCIO�L4\0Ѕ����?\0@D4\0\0�\0\0DD\0\r\0@�㸓�\0�����A��4�;;\r��P��\r\0�BOo�CH\0 \"\Z\0��h\0\0\"�\0��\0 \"\Z\0���EH��u8���4Зޅ���,�`1z��x�\0\0DD\0\r\0@D4\0\0�\0\0DD\01��@��Vf�??(��4�\r\0g��,\0 \"\Z\0��h\0\0\"�\0��\0 ����;�lug\0\0\0\0IEND�B`�');
INSERT INTO tiki_images_data VALUES (1,0,0,'t',3845,'','Logo_40wht.gif','');
INSERT INTO tiki_images_data VALUES (2,700,500,'t',3317,'image/jpg','background.png','����\0JFIF\0\0\0\0\0\0��\0>CREATOR: gd-jpeg v1.0 (using IJG JPEG v62), default quality\n��\0C\0		\n\r\Z\Z $.\' \",#(7),01444\'9=82<.342��\0C			\r\r2!!22222222222222222222222222222222222222222222222222��\0\09\0P\"\0��\0\0\0\0\0\0\0\0\0\0\0	\n��\0�\0\0\0}\0!1AQa\"q2?��#B��R��$3br�	\n\Z%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz���������������������������������������������������������������������������\0\0\0\0\0\0\0\0	\n��\0�\0\0w\0!1AQaq\"2?B����	#3R�br�\n$4�%�\Z&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz��������������������������������������������������������������������������\0\0\0?\0��?QFG����/�>�r��z�2=EEEZ}���#�Q��**(�������?QQQG֟`�%��dz���>��(QE�PQE\0QE\0QE\0QE\0QE\0QE\0QE\0QE\0QE\0QE\0QE\0QE\0QE\0QE��');





CREATE TABLE tiki_images_old (
"imageId" integer NOT NULL default nextval('tiki_images_old_seq') unique not null,
"galleryId" integer NOT NULL default '0',
"name" varchar(40) NOT NULL default '',
"description" text NOT NULL,
"created" integer NOT NULL default '0',
"filename" varchar(80) NOT NULL default '',
"filetype" varchar(80) NOT NULL default '',
"filesize" integer NOT NULL default '0',
"data" text,
"xsize" integer NOT NULL default '0',
"ysize" integer NOT NULL default '0',
"user" varchar(200) NOT NULL default '',
"t_data" text,
"t_type" varchar(30) NOT NULL default '',
"hits" integer NOT NULL default '0',
"path" varchar(255) NOT NULL default '',
PRIMARY KEY ("imageId")




) ;






INSERT INTO tiki_images_old VALUES (1,1,'Google logo','http://www.google.com/logos/Logo_40wht.gif',1040549952,'Logo_40wht.gif','image/gif',3845,'GIF89a�\05\0��\0������������������������\"j���\0>�\0/�,?(�<�6�&s1� B�;z/Q�������G�E�P�\nF�M�F�S�#X�+T�8b�<U�e}�Tg�o}�z�����������������������W�Z�;m�M|�Uy�l�Ă��h�e�(h�-r�?��\\��?�Х�ʥ��������������P��^��g��p��y�݊�圸㦻ٺ�������פ����������������������������������������������������������������Y|e-p-v�vPuP�Ҙ?�?q�q�ϯ���������������������������������������jm(�\'7�6>�=I�Hg�f��W�V����������������ބ�ʩ��-��W����?��������ƚ�	��\r��ի˭>ư^��K��i��������ߤ�k��{`�u/��������쮢��������������͹��ڵ������������¼������������訛����Q9�lW�zϡ�ั�������%�-�1�8!�>$ʌ��?�ͭ�͹���ͽ�!��%�0�3�:)�E8�WI�bW�}v�`[�yu��Ӳ\0�\0�\r��?\"�2&}1*?F=r\r������fff��������������������������������������������������������������������������Ļ��\0\0\0\0\0\0\0\0\0\0\0\0!�\0\0�\0,\0\0\0\0�\05\0\0�\0�	H����*\\Ȱ�Ç#J�H��ŋ3j�ȱ��? C�I��ɓ(S�\\ɲ��?���4G�͌��J�.�/4m�<����^��y�\\�5h���cf!s-czI�DɑH�(�E�tJ�|\r >e�d�fʘ�y\"�_\\�RI\0�Ko���eK\Z?c�(�\nV���8b���%�B�C1��`/������u���ɣƊ�v�.�4����`���@<y)JhpЀ�\0�������c=j��s�N7I�?�h�(A?��x����.=L�������ƞ�ޖ�&��Fp��v� ;[�S?#$0;��u����F�#�H稃���<d�� �3�:���\0�C�}\ru�QJ?X?LF�NR�DNL3��Z�y��];Wؕ�QG��9�� �$�q@=d\0!@�D�Y�<�|?@���-x��\0頓$?9?��\"���� ?�I$Xd�ţ,\0�`��l�1�2?SK*y�(P�\Z?�J�ىTp���C׈��N\0Y���,��.�0�L3��b.���Pt�3�\"�PR	%�$�#�|�NZ��3�EA9���3lA�|`�i;���-�,�����e��*9�PA�0q?=�3gAZ]�Z?ʂK3�|�8�D�K0�c&!Jy!�\"�0\"�)�8b�$�L�;����/Ȱ�1�p�1X����.�V������1��R4����)!���D���\Z `�\0\"�$MZ��2�\0��c\04����*[(��&�P�H<l��-N%�HB�+v(k�\r3���`�<��3t���s\n.ǰr=����/�L��:WU��Ap���U:�Y\0���\r*���pc��*�dq�!�`R�<��S�#�H�\'����A<��<��c< ?���qy�ȓ0�̣>�wS?7޴b� �T�N\0E��!;�x�^?e��G9�?�Ȱ�4�D(��@���@�ʭ�y�(?l0?1!o(A�\0�\0q����qe��\0���<�Q�gx��0�;������E�?\ZP� ��L.la\rR�)�p���\n`��\Z��#��N�bLhG\0��z�b���%��!l`\\��<\nP\0z��h@	� \07\\. �-�����x�3���VX�XG\'B�+�a7�\0Hp?�AQIMʉ:\\?�`\\��̤O�A�����`�\"&�UX?�XM:P�;\0����?&��:\00\0?���l�aa#�(�0l��h�C\0pd�\0P?N^�;�A0.У�@�����`a@\05n�kL#����!o���\"\"�	R�+7�HG;�2H|3�?(+p����?A��������,)���Y�m�\n*?(B�,��p@3\r��<!	C�A�0�������c�C��C#��bBSY�\'?�F$£�`�.���k�\0�0?}X������jH��$<��t��~\0�2�?��\0	k�@̡#�@3�\r`z�#�`�C=BTs�cŠ�7�@��q����&\0� \"�\0,`Q8�0@���L���G�a����%���v�J RD6?l�\nx@gq�sxA�Gn@�&�\n���1^)�w+�H�R{\rn�bpD�>FkU�n��&`�?}P`x\0��`<���\\L����4�Qx�hT�HF�Q(��8eR��\0�U\02|?h`�B�I;ޘ�n��\0+�u#(�	R��0A	B?8?ƴ68�4�@6�PF�~�.E\\�x$�x�|?ɫ�\nP/��}���X�6�qO����Ȇ�\nJDB�V\0�c2�B\\���]ߛ�@�������RQzi��clt����L���A��x�0�?��H�&�m�\0���\n��F5�qk�̲��+�}?��D=��?�r�>��8 0�B`WL��B��+���86���qd��0�.v�∸�:hB�\0\\ I�B\0��u�;p\0��k�����F5�a?Ƃˈn��`?;���$,!��bʠ���;��:@H�\Z�z���C� �3\\9�Eʫ��g���\0�u����x��\"@qx\09�;@�??���<vǊip�\Z�p4��a�C\0��ڴ�\nL��?��%*Q�P�A\0�k�:�J\0�`˱�,;�!\r?8���7��\0}�7�q\rk\\��`Ǿz��}\\\0��H0�H@\0?f�����,rO~V#\Z�x�)��C\n�?m���� �U?����M�y\08A\n9�A8 ?T�\ZhB@��C�� ��0�`��0P8�%g��?�zap�0\0�a��6n�C�S�}d\0�? ��Gñ�\'�@#`P�?`�����Q@3�|=?\0��#Pq\n@?<��x��`��@Vp�p�D�\Z���1L�6�W��q�(� �?�@�\0[\0� ���F�:\0�P�!\0MԵq\'A@= �:a��@y�\0?���G����Y�A0�@\n����1A\0pR�6\'���`t��\" �)WЉY��?��\'q6Y[����q\0�\0�5�8d�x\0����\0#``����WP���i8�� Vq���3R��X�_?�g�%���0\0\0\0��0�2\r##�x�h�W�Fp\r`/Da�@\0/h\'��x``�ҌC$W??��\'\r�Z�2#�&8E�9YW�$4aW@A�-�a��ylD�LT�Y�Q�FD��Hc�k)�QT\0T�@��0@��*��wO�H	(�%��%P��kRs�����j�Qv`\0��g2?e�OJ0�� `�줕L0qu$0m�/����#�Sli^��@V`@|!0\"`)�7���� Y}�\0>Vp�w?Cȃ�Y�,��-q�Ԅ���@�7�d�B��_\0!�(?{h��Ț7a^�\0\0����]@ံ�9!�C?1�l�$ʉ��y\0;',0,0,'ross','','',3,'');
INSERT INTO tiki_images_old VALUES (2,1,'test','Adding an entry to test the full text search function.\r\n\r\nHere are some search terms:\r\n\r\nJobHunting\r\ntest\r\ntiki\r\n',1040868478,'background.png','image/x-png',3317,'�PNG\r\n\Z\n\0\0\0\rIHDR\0\0�\0\0�\0\0\0P;i�\0\0\0bKGD\0�\0�\0�����\0\0\0	pHYs\0\0\0\0��~�\0\0\0tIME�!(�Y=�\0\0�IDATx���Qn#7EQM��/5;�?��l?���,���?/d����_>\0`?���v�\0\0��}���?��\0�D\0\r\0@D4\0\0�\0\0Dޞk�\0vt���A��4�8;\r0�����^�h\0�TzzB\0�\0\0DD\0\r\0@D4\0\0�\0\0D,BB��F����1��4����i�\0��\0 \"\Z\0��h\0\0\"�\0��\0 b܉+�h�NWR�P��� \Z\0n�����\0 \"\Z\0��h\0\0\"�\0��\0 \"\Z\0��q\'��Ӏj�����D@IO�{�4\0\0�\0\0DD\0\r\0@D4\0\0�\0\0D�;M�u8\03��0!%=\r7\r@z\ZJ���h\0�֮�i!��h\0\0\"�\0��yZ���Y:\0������Y:|BO�/�;�|r��|@�/|���%=\r\r�+�4���i�\0\0í��N.��h\0\0\"�\0��\0 \"\Z\0�H�q�5�Y\0`Z}O.���MOg�\r@IOCIO \Z\0�?��CH\0 \"\Z\0��h\0\0\"�\0��\0 2p��5\0�l�ɥk(�i`v\Z�lz\ZJz��\0�-�t?B\0�\0\0DD\0\r\0@D4\0\0�\0\0D.BB#��f�?=ie(�i�\"\Z\0�IO�o\Z\0��h\0\0\"�\0��\0 \"\Z\0��h\0\0\"�?���p���i`�Jz������i&�M\0\r\0@D4\0\0�\0\0DD\0\r\0@ĸ_p ���4�A	%=ͦD���4��\0��\0 \"\Z\0��h\0\0\"�\0��\0 bܩ��\0��NC/\nJz\Z� \Z��i(\r�i�\0\0�\Z��B\0�\0\0DD\0\r\0@D4\0\0�N�s ��\\�NuAIO�jDp=\r��=-\Z\0�J?{�CH\0 \"\Z\0��h\0\0\"�\0��\0 ��S�k\0�֒\'��e��?�,\r@IOCIO�D\0���)!��h\0\0\"�\0��\0 \"\Z\0��5�N�Y\0��kN.]�@IO?�i��i(��I�\0f��\'�!$\0\r\0@D4\0\0�\0\0DD\0\r\0@�EHh�?8@�N�#����\r\0D�4�4\0\0�\0\0D�V���?�\0`���4,�C�\n=\r�t4\0%=\r%=��\0\0?�COϸ��\0S�M�ӵP��\\M4\04����?\0 \"\Z\0��h\0\0\"�\0��\0 \"\Z\0��q\'�q �;\r�5���Y�h\0HO�2o\Z\0��h\0\0\"�\0��\0 \"\Z\0��h\0\0\"�?��:�s�iX������aD�6=\r�#=-\Z\0`CGz�CH\0 \"\Z\0��h\0\0\"�\0��\0 b��<��X����1(�i�J4\0��Pj�Ӣ\0fР�=�\0\"�\0��\0 \"\Z\0��h\0\0\"�?;58h�9�vr�U!ANO��-\Z�������?h\0�����x	\0DD\0\r\0@D4\0\0�\0\0Dnwr�\0=�~r�Jz\Z����\0��4���?D\0?��;y	\0DD\0\r\0@D4\0\0�\0\0D�q\'-\0�{�ɥ�(�i`kv\Z �����w!\Z\0x��ޅ�?\0@D4\0\0�\0\0DD\0\r\0@D4\0\0�r�pp;\r�&y���9�h\0X?���4\0\0�\0\0DD\0\r\0@D4\0\0�\0\0D�;1��p�e�i`,\r\n%=�\nD��4+�\0��\0 \"\Z\0��h\0\0\"�\0��\0 b�i��N�t!��4<G4\0���P���E\0�O{�CH\0 \"\Z\0��h\0\0\"�\0��\0 b��������-�\Z��4LM4\0���P���E\0Ln���\0��M�/�Y��X�O�\n�%=�8�`iz�q�i\0\0\"�?~�\0|ſ\'~OP���D�5=\r�{Z4\0�;���?\0@D4\0\0�\0\0DD\0\r\0@d�q��Y\0`Z3�\\N[3p/=\r�c�h\0Jz\ZJz�t��5���y	\0DD\0\r\0@D4\0\0�\0\0D�wr�\0�z���A��4�>;\r0�����^�h\0�<zz)B\0�\0\0DD\0\r\0@D4\0\0�\0\0D�]��.\\�f�?U�a(�i�\r\0[���M\0\r\0@D4\0\0�\0\0DD\0\r\0@ĸ�qЛ?.#O���iC4\0�KOӆ7\r\0@D4\0\0�\0\0DD\0\r\0@D4\0\0�N�s @�N��$#��4D�Gz\Z\n�4\0\0�\0\0DD\0\r\0@D4\0\0�\0\0D�;��u8\0���0\r%=\r�\r@z\ZJ���h\0��.�i!��h\0\0\"�\0��\0 \"\Z\0��q��q\0pr�UP�Ӱ�\0����lO�\0kٞ�\0��\0 \"\Z\0��h\0\0\"�\0�4wZ��\0����c���4p���\0��4��������1<�\0\"�\0��\0 \"\Z\0��h\0\0\"��?\\�\0��F?\\�f?���a�N�����[\r\0\\OO��!$\0\r\0@D4\0\0�\0\0DD\0\r\0@d�\"$4�@�;\rlH(CIO�\r�\0���4�x�K2;��|�0=U%=\r�\r@Oz\ZJg��h\0�����v\Z\0��h\0\0\"�?�?\'m\0\rx���+��4s\r\0����ś\0 \"\Z\0��h\0\0\"�\0��\0 \"\Z\0��q\'>�@���i�3jJz�}����i��M\0\r\0@D4\0\0�\0\0DD\0\r\0@ĸS#����?�F���4\\D4\0��i(?�i�\0\0K\Z��B\0�\0\0DD\0\r\0@D4\0\0�N�p�F�\\�BoAIOÚD0���R��\r\0p?�=�!$\0\r\0@D4\0\0�\0\0DD\0Yoܩ�A\0�i����\ZF����֋������� \Z\0ؙ�~��?\0@D4\0\0�\0\0DD\0\r\0@�q\'�,\0��N.]�@IO��i���i(��y�\0�����!$\0\r\0@D4\0\0�\0\0DD\0\r\0@�EHh�?8���4��44��4?�h\0 ��y<�i\0\0B�\0��\0 \"\Z\0��h\0\0\"�\0�wbr��fa�?ɉZ(�in \Z\0:�����\0 \"\Z\0��h\0\0\"�\0��\0 \"\Z\0��q\'p �#;\r 4���Y�h\0EO�8o\Z\0��h\0\0\"�\0��\0 \"\Z\0��h\0\0\"�?��:���iX�򃒞��D�0=\r��=-\Z\0`7{�CH\0 \"\Z\0��h\0\0\"�\0��\0 b��$��X?�˓H1(�ih�ힿn>7`Sz\ZJ=�.��M��\r(���\0���wѿ\'`&=>7�rzz�����98�\0\"�\0��\0 �ո��4\0p�V!��#x��\"[EP��P���\0(���<�\0\"�\0��\0 \"\Z\0��h\0\0\"��;�f�6�=�t�%=\r��NLHOCIO�L4\0Ѕ����?\0@D4\0\0�\0\0DD\0\r\0@�㸓�\0�����A��4�;;\r��P��\r\0�BOo�CH\0 \"\Z\0��h\0\0\"�\0��\0 \"\Z\0���EH��u8���4Зޅ���,�`1z��x�\0\0DD\0\r\0@D4\0\0�\0\0DD\01��@��Vf�??(��4�\r\0g��,\0 \"\Z\0��h\0\0\"�\0��\0 ����;�lug\0\0\0\0IEND�B`�',700,500,'ross','����\0JFIF\0\0\0\0\0\0��\0>CREATOR: gd-jpeg v1.0 (using IJG JPEG v62), default quality\n��\0C\0		\n\r\Z\Z $.\' \",#(7),01444\'9=82<.342��\0C			\r\r2!!22222222222222222222222222222222222222222222222222��\0\09\0P\"\0��\0\0\0\0\0\0\0\0\0\0\0	\n��\0�\0\0\0}\0!1AQa\"q2?��#B��R��$3br�	\n\Z%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz���������������������������������������������������������������������������\0\0\0\0\0\0\0\0	\n��\0�\0\0w\0!1AQaq\"2?B����	#3R�br�\n$4�%�\Z&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz��������������������������������������������������������������������������\0\0\0?\0��?QFG����/�>�r��z�2=EEEZ}���#�Q��**(�������?QQQG֟`�%��dz���>��(QE�PQE\0QE\0QE\0QE\0QE\0QE\0QE\0QE\0QE\0QE\0QE\0QE\0QE\0QE��','image/jpg',1,'');





CREATE TABLE tiki_language (
"source" text NOT NULL,
"lang" varchar(2) NOT NULL default '',
"tran" text,
PRIMARY KEY ("lang","source")
) ;











CREATE TABLE tiki_languages (
"lang" varchar(2) NOT NULL default '',
"language" varchar(255) NOT NULL default '',
PRIMARY KEY ("lang")
) ;






INSERT INTO tiki_languages VALUES ('en','English');





CREATE TABLE tiki_link_cache (
"cacheId" integer NOT NULL default nextval('tiki_link_cache_seq') unique not null,
"url" varchar(250) NOT NULL default '',
"data" text,
"refresh" integer NOT NULL default '0',
PRIMARY KEY ("cacheId")
) ;






INSERT INTO tiki_link_cache VALUES (1,'http://www.uni-koeln.de/phil-fak/indologie/tamil/mwd_search.html','<HTML>\r\n<HEAD>\r\n<TITLE>IITS - Cologne Digital Sanskrit Lexicon</TITLE>\r\n</HEAD>\r\n<BODY LINK=\"Blue\" VLINK=\"Green\" ALINK=\"Green\"\r\nBACKGROUND=\"./graphics/verl01.gif\">\r\n\r\n<CENTER><H2>\r\nCologne Digital Sanskrit Lexicon</H2></CENTER>\r\n\r\n<FORM METHOD=\"POST\" ACTION=\"/cgi-bin/SFgate\" ENCTYPE=\"x-www-form-encoded\">\r\n<INPUT NAME=\"database\" TYPE=\"hidden\"\r\nVALUE=\"local//vol/info/wais/db/tamil2/mwd\">\r\n<INPUT TYPE=\"hidden\" NAME=\"application\"\r\nVALUE=\"/phil-fak/indologie/tamil/mwd\">\r\n<INPUT TYPE=\"hidden\" NAME=\"tieinternal\" VALUE=\"und\">\r\n<INPUT TYPE=\"hidden\" NAME=\"convert\" VALUE=\"Tabelle\">\r\n<INPUT TYPE=\"hidden\" NAME=\"verbose\" VALUE=\"0\">\r\n<INPUT TYPE=\"hidden\" NAME=\"multiple\" VALUE=\"1\">\r\n<INPUT TYPE=\"hidden\" NAME=\"qu_tie\" VALUE=\"und\">\r\n<!--INPUT TYPE=\"hidden\" NAME=\"qu_name\" VALUE=\"alle\"-->\r\n\r\n<TABLE BORDER=\"0\" ALIGN=\"BLEEDLEFT\" CELLPADDING=\"5\" CELLSPACING=\"5\">\r\n<TR>\r\n<TD><FONT SIZE=\"+1\">Sanskrit : </FONT></TD>\r\n<TD><INPUT TYPE=\"text\" NAME=\"st\" SIZE=\"40\"></TD>\r\n<TD><INPUT TYPE=\"submit\" VALUE=\"Start search\"></TD>\r\n</TR>\r\n<TR>\r\n<TD><FONT SIZE=\"+1\"> English: </FONT></TD>\r\n<TD><INPUT TYPE=\"text\" NAME=\"en\" SIZE=\"40\"></TD>\r\n<TD><INPUT TYPE=\"submit\" VALUE=\"Start search\"></TD>\r\n</TR>\r\n<TR>\r\n<TD><FONT SIZE=\"+1\">Maximum Output: </FONT></TD>\r\n<TD>\r\n<SELECT NAME=\"maxhits\">\r\n<OPTION VALUE=\"\">20</OPTION>\r\n<OPTION SELECTED=\"SELECTED\" VALUE=\"\">50</OPTION>\r\n<OPTION VALUE=\"\">100</OPTION>\r\n<OPTION VALUE=\"\">200</OPTION>\r\n<OPTION VALUE=\"\">500</OPTION>\r\n<OPTION VALUE=\"\">1000</OPTION></SELECT>\r\n<INPUT TYPE=\"reset\" VALUE=\"New search\"></TD></TR>\r\n</TABLE>\r\n</FORM>\r\n\r\n<BLOCKQUOTE>At present the Cologne Digital Sanskrit\r\nLexicon contains Monier-Williams\' \'Sanskrit-English\r\nDictionary\' with approx. 160.000 main entries.<BR>\r\nYou can either search for one of the Sanskrit main entries\r\nunder <B>Sanskrit </B> or under <B>English</B>\r\nfor a translation, grammatical and any other information listed in the MW.\r\n<BR>The transliteration is based on the Harvard-Kyoto (HK)\r\n convention as follows:\r\n<CENTER><P><TT>\r\na A i I u U R RR lR lRR e ai o au M H<BR>\r\nk kh g gh G c ch j jh J<BR>\r\nT Th D Dh N t th d dh n<BR>\r\np ph b bh m y r l v z S s h</TT></CENTER><P>\r\nNote: WAIS search is not case sensitive.\r\nFor further information see:\r\n<A HREF=\"http://www.uni-koeln.de/phil-fak/indologie/tamil/mwreport.html\">\r\nReport on the Cologne Digital Sanskrit Lexicon Project</A>\r\n<A HREF=\"http://www.uni-koeln.de/phil-fak/indologie/tamil/mon-add.tif\">\r\n+ Appendix</A>\r\n\r\n<P>Suggestions and comments to:\r\n<A HREF=\"mailto:th.malten@uni-koeln.de\">\r\nIITS-lexicon@uni-koeln.de</A></BLOCKQUOTE>\r\n\r\n<P>&nbsp;\r\n<CENTER>\r\n<A HREF=\"http://www.uni-koeln.de/phil-fak/indologie/index.e.html\">\r\n<IMG SRC=\"./graphics/back.gif\" BORDER=0 HEIGHT=59 WIDTH=50><P>\r\n</A>\r\n<A HREF=\"http://www.uni-koeln.de/phil-fak/indologie/index.e.html\">\r\nHOME</A><BR>\r\n\r\n<FONT SIZE=-1>\r\nWebmasters: <A HREF=\"mailto:ar.zeini@uni-koeln.de\">A.\r\nZeini </A>&amp; <A HREF=\"mailto:grotebev@uni-koeln.de\">T.\r\nGrote-Beverborg</A>.</FONT></CENTER>\r\n<CENTER>This page has been accessed <a href=\"/cgi-bin/count3/i/CDSL\"><img src=\"/cgi-bin/count3.gif/CDSL\" width=44 height=10></a> times</CENTER>\r\n</BODY>\r\n</HTML>\r\n',1038940749);
INSERT INTO tiki_link_cache VALUES (2,'http://losangeles.craigslist.org/eng/','<META http-equiv=\"Cache-Control\" content=\"max-age=900\">\n<META http-equiv=\"Cache-Control\" content=\"public\">\n<META http-equiv=\"Expires\" content=\"Wed, 04 Dec 2002 03:16:58 GMT\">\n<html><head>\n<title>craigslist | internet engineering jobs in los angeles </title>\n</head>\n<body bgcolor=white>\n<FORM Action=/cgi-bin/search Method=GET>\n<table width=100%><TR><TD><h3><a href=/>craigslist</a> &gt; <a href=/>los angeles</a> &gt; <a href=/eng>internet engineering jobs</a></h3>\n</TD><TD align=center valign=top width=30%>[<B> <a href=\'/cgi-bin/posting.cgi?areaID=7&subAreaID=0&categoryID=14&group=J\'>post</a> </b>]</table>\n<input type=hidden name=areaID value=7>\n<input type=hidden name=subAreaID value=0>\n<input type=hidden name=catAbbreviation value=eng>\n<input type=hidden name=cat value=14>\n<input type=hidden name=group value=J>\n<input type=hidden name=type_search value=>\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;keywords:\n<input name=query size=30 maxsize=30 value=\"\">\n&nbsp;<select name=new_cat>\n<option value=\'all\' >ALL\n<option value=tec >all computer jobs\n<option value=esc >all engineering / science\n<option value=lgg >all legal / government\n<option value=35 >activity partners\n<option value=60 >apts broker fee\n<option value=85 >apts broker no fee\n<option value=86 >apts by owner\n<option value=1 >apts for rent\n<option value=2 >apts wanted\n<option value=70 >artists\n<option value=53 >artists / musicians\n<option value=42 >barter\n<option value=68 >bicycles\n<option value=12 >business jobs\n<option value=6 >cars / trucks\n<option value=62 >casual encounters\n<option value=56 >childcare\n<option value=3 >community\n<option value=7 >computer / tech\n<option value=76 >computer services\n<option value=77 >creative services\n<option value=43 >cycles\n<option value=57 >education jobs\n<option value=48 >engineering jobs\n<option value=78 >erotic services\n<option value=15 >etcetera jobs\n<option value=66 >event calendar\n<option value=79 >event services\n<option value=23 >finance jobs\n<option value=5 >for sale\n<option value=64 >furniture\n<option value=73 >garage sales\n<option value=61 >government jobs\n<option value=26 >healthcare jobs\n<option value=80 >household services\n<option value=65 >housing swap\n<option value=54 >human resource jobs\n<option value=14  selected>internet engineering jobs\n<option value=82 >labor / moving\n<option value=47 >legal jobs\n<option value=81 >lesson / tutoring\n<option value=13 >marketing jobs\n<option value=25 >media jobs\n<option value=33 >men seeking men\n<option value=32 >men seeking women\n<option value=63 >missed connections\n<option value=69 >motorcycles/scooters\n<option value=71 >musicians\n<option value=51 >network jobs\n<option value=28 >nonprofit jobs\n<option value=40 >office\n<option value=24 >office jobs\n<option value=41 >parking\n<option value=37 >pets\n<option value=72 >real estate for sale\n<option value=10 >resumes\n<option value=27 >retail jobs\n<option value=36 >rideshare\n<option value=18 >rooms / shares\n<option value=19 >rooms wanted\n<option value=49 >sales jobs\n<option value=75 >science jobs\n<option value=83 >skilled trade services\n<option value=59 >skilled trades jobs\n<option value=4 >small biz ads\n<option value=21 >software jobs\n<option value=58 >sublet/temp wanted\n<option value=39 >sublets / temporary\n<option value=74 >summer sublets\n<option value=50 >sys admin jobs\n<option value=55 >tech support jobs\n<option value=84 >therapeutic services\n<option value=44 >tickets\n<option value=52 >tv video radio jobs\n<option value=29 >volunteers\n<option value=20 >wanted\n<option value=11 >web design jobs\n<option value=31 >women seeking men\n<option value=30 >women seeking women\n<option value=16 >writing jobs\n</select>&nbsp;<input type=submit value=search><BR>\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=checkbox name=addOne value=telecommuting >telecommute\n<input type=checkbox name=addTwo value=contract >contract\n<input type=checkbox name=addThree value=internship >internship\n<input type=checkbox name=addFour value=part-time >part-time\n<input type=checkbox name=addFive value=non-profit >non-profit\n</FORM>\n<blockquote>\n<table width=100% border=0><tr><td><font size=2>Tue Dec  3 19:01 - refresh / reload to see new posts</font></td><td align=right><font size=2>&nbsp;\n</td></tr></table>\n<p><table width=90%><tr><td bgcolor=#cccccc>&nbsp;Tue Dec 3rd</td></tr></table><p>\n<p>&nbsp;<a href=/lax/eng/7159809.html>Seeking Freelance ASP.NET Web App Developer: </a>  (Woodland Hills)\n<p><table width=90%><tr><td bgcolor=#cccccc>&nbsp;Mon Dec 2nd</td></tr></table><p>\n<p>&nbsp;<a href=/lax/eng/7144107.html>Database and Web Site Developer </a>  (El Segundo)\n<p>&nbsp;<a href=/lax/eng/7144031.html>Code HTML from scratch & Tech Support </a>  (Santa Monica, CA)\n<p><table width=90%><tr><td bgcolor=#cccccc>&nbsp;Tue Nov 26th</td></tr></table><p>\n<p>&nbsp;<a href=/lax/eng/7052320.html>Application Developer - Clarify eSupport </a>  (Los Angeles)\n<p>&nbsp;<a href=/lax/eng/7052174.html>Siebel  Configuration Consultant </a>  (Los Angeles)\n<p>&nbsp;<a href=/lax/eng/7050649.html>Wireless Communication Systems Engineer/Analyst </a>  (Tarzana)\n<p>&nbsp;<a href=/lax/eng/7050009.html>Programmer </a>  (Los Angeles)\n<p>&nbsp;<a href=/lax/eng/7047077.html>WEB Developer - JavaScript </a>  (Los Angeles)\n<p>&nbsp;<a href=/lax/eng/7047016.html>WEB Developer - Perl/CGI </a>  (Los Angeles)\n<p>&nbsp;<a href=/lax/eng/7046464.html>Flash Expert </a>  (Los Angeles, CA)\n<p>&nbsp;<a href=/lax/eng/7045073.html>UI Designer </a>  (West Los Angeles)\n<p><table width=90%><tr><td bgcolor=#cccccc>&nbsp;Mon Nov 25th</td></tr></table><p>\n<p>&nbsp;<a href=/lax/eng/7031238.html>SAP Basis Administrator </a>  (Los Angeles)\n<p>&nbsp;<a href=/lax/eng/7031215.html>I need a DHTML guru!! </a>  (Los Angeles)\n<p>&nbsp;<a href=/lax/eng/7031128.html>E-mail List Developer </a>  (Los Angeles)\n<p>&nbsp;<a href=/lax/eng/7030601.html>Web Architect </a>  (Los Angeles)\n<p>&nbsp;<a href=/lax/eng/7029487.html>Interactive Traffic Manager </a>  (Palos Verdes (Los Angeles South Bay))\n<p>&nbsp;<a href=/lax/eng/7028318.html>Senior RF Analog Engineer </a>  (Camarillo)\n<p>&nbsp;<a href=/lax/eng/7027332.html>SAP Network Admin. </a>  (Los Angeles)\n<p>&nbsp;<a href=/lax/eng/7022196.html>B2C web programmer � ASP �Access - SQL � JS - HTML </a>  (Glendale / Burbank)\n<p>&nbsp;<a href=/lax/eng/7018489.html>WEB Developer - JavaScript </a>  (Los Angeles)\n<p><table width=90%><tr><td bgcolor=#cccccc>&nbsp;Sun Nov 24th</td></tr></table><p>\n<p>&nbsp;<a href=/lax/eng/7014187.html>linux c++ software engineer </a>  (los angeles)\n<p><table width=90%><tr><td bgcolor=#cccccc>&nbsp;Sat Nov 23rd</td></tr></table><p>\n<p>&nbsp;<a href=/lax/eng/6997526.html>Web site  developer </a>  (Glendora, CA)\n<p>&nbsp;<a href=/lax/eng/6995599.html>Need Web Designer by Artist/Musician </a>  (Virtual)\n<p><table width=90%><tr><td bgcolor=#cccccc>&nbsp;Fri Nov 22nd</td></tr></table><p>\n<p>&nbsp;<a href=/lax/eng/6984277.html>Web Programmer wanted at profitable internet company </a>  (Los Angeles)\n<p>&nbsp;<a href=/lax/eng/6980513.html>Electronic Fund Transfer Technical lead/Architect </a>  (Los Angeles)\n<p>&nbsp;<a href=/lax/eng/6975403.html>Siebel Analytics </a>  (SF valley)\n<p>&nbsp;<a href=/lax/eng/6974645.html>Web Help! </a>  (Marina Del Rey)\n<p><table width=90%><tr><td bgcolor=#cccccc>&nbsp;Thu Nov 21st</td></tr></table><p>\n<p>&nbsp;<a href=/lax/eng/6959744.html>Sr. Java Developer </a>  (SF Valley)\n<p>&nbsp;<a href=/lax/eng/6952856.html>WANTED  - DB/WEB Engineer </a>  (Los Angeles)\n<p><table width=90%><tr><td bgcolor=#cccccc>&nbsp;Wed Nov 20th</td></tr></table><p>\n<p>&nbsp;<a href=/lax/eng/6939558.html>Full-time Photoshop Pro and Wide Format Printer Needed </a>  (Hawthorne)\n<p>&nbsp;<a href=/lax/eng/6938949.html>Senior Server Engineer - Team Lead </a>  (Los Angeles)\n<p>&nbsp;<a href=/lax/eng/6927436.html>Looking for PHP, CFM or ASP programmer </a>  (Los Angeles (Burbank))\n<p><table width=90%><tr><td bgcolor=#cccccc>&nbsp;Tue Nov 19th</td></tr></table><p>\n<p>&nbsp;<a href=/lax/eng/6925177.html>Web Developer </a>  (Los Angeles)\n<p>&nbsp;<a href=/lax/eng/6925139.html>Siebel Configuration Specialist </a>  (South Bay)\n<p>&nbsp;<a href=/lax/eng/6916548.html>System Analysts - 4 Positions (Loan Origination Experience) </a>  (S.F. Valley)\n<p>&nbsp;<a href=/lax/eng/6915646.html>PL/SQL Developer </a>  (Los Angeles)\n<p>&nbsp;<a href=/lax/eng/6911564.html>Copywriter (freelance) </a>  (Los Angeles)\n<p>&nbsp;<a href=/lax/eng/6910787.html>Oracle Developer - 75k </a>  (Los Angeles)\n<p>&nbsp;<a href=/lax/eng/6909292.html>Web Software Engineer </a>  (Chatsworth, CA)\n<p><table width=90%><tr><td bgcolor=#cccccc>&nbsp;Mon Nov 18th</td></tr></table><p>\n<p>&nbsp;<a href=/lax/eng/6893428.html>Network Engineer preferably with MCSE </a>  (Woodland Hills)\n<p>&nbsp;<a href=/lax/eng/6890617.html>entry level web person </a>  (marina del rey)\n<p><table width=90%><tr><td bgcolor=#cccccc>&nbsp;Sun Nov 17th</td></tr></table><p>\n<p>&nbsp;<a href=/lax/eng/6881780.html>PHP Programmer </a>  (Kuala Lumpur, Malaysia)\n<p><table width=90%><tr><td bgcolor=#cccccc>&nbsp;Sat Nov 16th</td></tr></table><p>\n<p>&nbsp;<a href=/lax/eng/6866897.html>Webmaster and HTML Programmer in Venice </a>  (Venice, CA)\n<p>&nbsp;<a href=/lax/eng/6864480.html>Analog/Digital/Mixed mode/microprocessor designer </a>  (Pasadena area)\n<p>&nbsp;<a href=/lax/eng/6855540.html>Experienced WEB DESIGNERS </a>  (Glendale)\n<p><table width=90%><tr><td bgcolor=#cccccc>&nbsp;Fri Nov 15th</td></tr></table><p>\n<p>&nbsp;<a href=/lax/eng/6851371.html>Part Time Webmaster/Editor Needed For Adult Sites! </a>  (Orange County/Los Angeles)\n<p>&nbsp;<a href=/lax/eng/6849414.html>Integrator </a>  (Long Beach, CA)\n<p>&nbsp;<a href=/lax/eng/6848512.html>Senior Web Developer </a>  (Covina, CA)\n<p>&nbsp;<a href=/lax/eng/6845542.html>Are you a technical guru? </a>  (Santa Monica)\n<p>&nbsp;<a href=/lax/eng/6840568.html>configure quick php news manager on server </a>  (Los Angeles)\n<p>&nbsp;<a href=/lax/eng/6839622.html>Graphic/web designer </a>  (City of Industry, CA)\n<p><table width=90%><tr><td bgcolor=#cccccc>&nbsp;Thu Nov 14th</td></tr></table><p>\n<p>&nbsp;<a href=/lax/eng/6834810.html>Product Manager </a>  (Northern California)\n<p>&nbsp;<a href=/lax/eng/6827212.html>Senior Designer </a>  (Venice, CA)\n<p>&nbsp;<a href=/lax/eng/6824532.html>Lead Programmer </a>  (Los Angeles area)\n<p>&nbsp;<a href=/lax/eng/6819083.html>Web Developer </a>  (Los Angeles)\n<p>&nbsp;<a href=/lax/eng/6815148.html>ASP - Sequel Server Guru with E-Commerce Experience </a>  (Marina Del Rey)\n<p><table width=90%><tr><td bgcolor=#cccccc>&nbsp;Wed Nov 13th</td></tr></table><p>\n<p>&nbsp;<a href=/lax/eng/6807085.html>Need to Liquidate a Linux server - need help by linux expert - share $ </a>  (Studio City)\n<p>&nbsp;<a href=/lax/eng/6806989.html>SOFTWARE DEVELOPMENT & QA POSITIONS--InfoGenesis </a>  (Santa Barbara)\n<p>&nbsp;<a href=/lax/eng/6804712.html>J2EE Architect/Developer </a>  (Santa Barbara)\n<p>&nbsp;<a href=/lax/eng/6804453.html>PC TECH & WEB ADMINSTRATOR & VIDEO EDITING </a>  (LOS ANGELES)\n<p>&nbsp;<a href=/lax/eng/6803727.html>Computer Systems Validation Engineer </a>  (Irvine)\n<p><table width=90%><tr><td bgcolor=#cccccc>&nbsp;Tue Nov 12th</td></tr></table><p>\n<p>&nbsp;<a href=/lax/eng/6787463.html>PC Test Technician </a>  (Orange County)\n<p>&nbsp;<a href=/lax/eng/6786758.html>Webmaster & HTML Programmer </a>  (Santa Monica, CA)\n<p>&nbsp;<a href=/lax/eng/6779162.html>Web Developer Sought to Build Site </a>  (Los Angeles)\n<p>&nbsp;<a href=/lax/eng/6776410.html>HTML/PhotoShop Part-Time Work </a>  (Santa Monica)\n<p><table width=90%><tr><td bgcolor=#cccccc>&nbsp;Mon Nov 11th</td></tr></table><p>\n<p>&nbsp;<a href=/lax/eng/6771680.html>Oracle 11i Developer/DBA </a>  (SANFRANCISCO & LOS ANGELES)\n<p>&nbsp;<a href=/lax/eng/6771412.html>SQL database programming needed </a>  (Santa Barbara ONLY)\n<p>&nbsp;<a href=/lax/eng/6769124.html>Web developer with strong design experience wanted </a>  (Los Angeles, CA)\n<p>&nbsp;<a href=/lax/eng/6761922.html>web programmer/developer </a>  (Glendale)\n<p>&nbsp;<a href=/lax/eng/6759014.html>Web Developer </a>  (Los Angeles)\n<p><table width=90%><tr><td bgcolor=#cccccc>&nbsp;Sat Nov 9th</td></tr></table><p>\n<p>&nbsp;<a href=/lax/eng/6723774.html>  SQL database Programmer Wanted </a>  (Southern Calif.)\n<p><table width=90%><tr><td bgcolor=#cccccc>&nbsp;Fri Nov 8th</td></tr></table><p>\n<p>&nbsp;<a href=/lax/eng/6718814.html>Junior/Mid Level Web Programmer </a>  (West Los Angeles)\n<p>&nbsp;<a href=/lax/eng/6714309.html>SAP SD w/ Variant </a>  (Palo Alto, CA)\n<p>&nbsp;<a href=/lax/eng/6711230.html>Technology Director, Los Angeles </a>  (West Hollywood)\n<p>&nbsp;<a href=/lax/eng/6709573.html>C++/CORBA/Messaging Developer </a>  (Los Angeles)\n<p>&nbsp;<a href=/lax/eng/6709416.html>Help Desk Supervisor - �50% supervising and 50% hand-on technical </a>  (Santa Monica)\n<p><table width=90%><tr><td bgcolor=#cccccc>&nbsp;Thu Nov 7th</td></tr></table><p>\n<p>&nbsp;<a href=/lax/eng/6698162.html>QA Test Lead </a>  (S.F.Valley)\n<p>&nbsp;<a href=/lax/eng/6694161.html>Telemarketing Closers Wanted !!!! </a>  (SFV)\n<p><table width=90%><tr><td bgcolor=#cccccc>&nbsp;Wed Nov 6th</td></tr></table><p>\n<p>&nbsp;<a href=/lax/eng/6680410.html>Web designer/programmer wanted for Splash Spa </a>  (Los Angeles)\n<p>&nbsp;<a href=/lax/eng/6680390.html>Web designer/programmer needed for InMagazine </a>  (Los Angeles)\n<p>&nbsp;<a href=/lax/eng/6678222.html>QA Engineer </a>  (Los Angeles/Santa Monica)\n<p>&nbsp;<a href=/lax/eng/6675268.html>INSIDE SALES PEOPLE WANTED </a>  (Sherman Oaks)\n<p>&nbsp;<a href=/lax/eng/6674794.html>Analytics Configurator - Technical Lead ($50 to $55 / hr) W2 </a>  (SFV)\n<p>&nbsp;<a href=/lax/eng/6672388.html>SAS Pre/Post Sales Support Engineers </a>  (Los Angeles)\n<p>&nbsp;<a href=/lax/eng/6672280.html>SAS Pre/Post Sales Support Engineers </a>  (San Diego)\n<p>&nbsp;<a href=/lax/eng/6670127.html>admin support. and help desk </a>  (beverly hills)\n<p>&nbsp;<a href=/lax/eng/6665588.html>Java/cgi programmer to update scripts </a>  (Telecommute)\n<p><table width=90%><tr><td bgcolor=#cccccc>&nbsp;Tue Nov 5th</td></tr></table><p>\n<p>&nbsp;<a href=/lax/eng/6654272.html>JD Edwards Guru/Consultant </a>  (San Fernando Valley)\n<p>&nbsp;<a href=/lax/eng/6654191.html>Network Administrator </a>  (San Fernando Valley)\n<p>&nbsp;<a href=/lax/eng/6652699.html>Need local freelance creative web designer! </a>  (Los Angeles)\n<p>&nbsp;<a href=/lax/eng/6650296.html>HIPPA Consultants </a>  (O.C.)\n<p>&nbsp;<a href=/lax/eng/6644384.html>Customer Support, Technical Support, Recruiting </a>  (Los Angeles)\n<p>&nbsp;<a href=/lax/eng/6644292.html>E-Commerce and Web Programmer </a>  (Los Angeles)\n<p>&nbsp;<a href=/lax/eng/6641798.html>Computer Help Needed </a>  (Tarzana)\n<p><table width=90%><tr><td bgcolor=#cccccc>&nbsp;Mon Nov 4th</td></tr></table><p>\n<p>&nbsp;<a href=/lax/eng/6634713.html>software integration engineer </a>  (Santa Monica, CA)\n<p>&nbsp;<a href=/lax/eng/6632202.html>Senior Server Engineer </a>  (Los Angeles)\n<p>&nbsp;<a href=/lax/eng/6632183.html>Pre/Post Sales Engineer </a>  (Los Angeles)\n<p>&nbsp;<a href=/lax/eng/6632151.html>Software Quality Assurance Engineer </a>  (Los Angeles)\n<p>&nbsp;<a href=/lax/eng/6630703.html>Adult Search Engine Optimization Expert </a>  (United States)\n</table>\n</blockquote>\n<p align=center><font size=4><a href=index100.html>next 100 postings</a></font><br><hr><br>Copyright &copy; 2002 craigslist<br><br></body>\n</html>\n',1038971411);
INSERT INTO tiki_link_cache VALUES (3,'http://tikiwiki.sf.net/','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1DTD/xhtml1-transitional.dtd\">\r\n<html>\r\n<head>\r\n	<title>tikiwiki :: open source excellence, one line at a time</title>\r\n\r\n	<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />\r\n	<meta name=\"keywords\" content=\"tiki, wiki, tikiwiki, open source, osi, php, lamp, cms, articles, image, file, gallery, ldap\" />\r\n	<meta name=\"description\" content=\"An open source web application providing a full article, wiki, local/LDAP user/group management, file and image galleries, and more.\" />\r\n\r\n	<link rel=\"stylesheet\" href=\"mozilla.css\" type=\"text/css\" media=\"screen\" />\r\n\r\n	<script src=\"utils.js\" type=\"text/javascript\"></script>\r\n	<script src=\"viewport.js\" type=\"text/javascript\"></script>\r\n	<script src=\"global.js\" type=\"text/javascript\"></script>\r\n	<script src=\"cookie.js\" type=\"text/javascript\"></script>\r\n	<script src=\"tabs.js\" type=\"text/javascript\"></script>\r\n\r\n	<script type=\"text/javascript\">\r\n	// <![CDATA[\r\n	\r\n	function chooseStyle( newstyle )\r\n	{\r\n		var expdate = new Date();\r\n		expdate.setTime(expdate.getTime() + (1000*3600*24*365));\r\n		document.cookie = \'style=\' + newstyle + \'; expires=\' + expdate.toGMTString() + \'; path=/\';\r\n		self.location = self.location;\r\n	}	\r\n\r\n	if( document.cookie.indexOf( \'style=1\' ) >= 0 )\r\n		document.write( \'<link rel=\"stylesheet\" type=\"text/css\" href=\"winxp.css\">\\n\' );\r\n	else if( document.cookie.indexOf( \'style=2\' ) >= 0 )\r\n		document.write( \'<link rel=\"stylesheet\" type=\"text/css\" href=\"aqua.css\">\\n\' );\r\n	else document.write( \'<link rel=\"stylesheet\" type=\"text/css\" href=\"mozilla.css\">\\n\' );\r\n\r\n	/*\r\n	 * TabParams        Change these to customize behavior.\r\n	 *\r\n	 * useClone         If true, uses a clone of the tabs beneath the contents.\r\n	 *\r\n	 * alwaysShowClone  If true, the clone will be visible at all times.\r\n	 *                  Otherwise, the clone will be visible only when the active \r\n	 *                  content div\'s girth extends beyond the viewport height.\r\n	 * \r\n	 * eventType        The event that triggers a tab. mouseover, mousedown, mouseup.\r\n	 *\r\n	 * tabTagName       Speeds performance. Use \"*\" for multiple types.\r\n	 *\r\n	 */\r\n\r\n	TabParams = {\r\n		useClone         : false,\r\n		alwaysShowClone  : false,\r\n		eventType        : \"click\",\r\n		tabTagName       : \"span\"\r\n		};\r\n\r\n	// ]]>\r\n	</script>\r\n</head>\r\n<body onload=\"tabInit()\">\r\n\r\n<div id=\"pagehead\">\r\n	<img src=\"banner_01.png\" width=\"400\" height=\"50\" border=\"0\" alt=\"banner\" title=\"\"/>\r\n	<h1>TIKIWIKI</h1>\r\n	<p>Open Source Excellence, One Line at a Time</p>\r\n</div> <!-- div pagehead -->\r\n\r\n<div id=\"pagemenu\">\r\n	<ul>\r\n		<li><a href=\"http://sourceforge.net/projects/tikiwiki/\">Project Page</a></li>\r\n		<li><a href=\"http://sourceforge.net/tracker/?atid=506847&amp;group_id=64258&amp;func=browse\">Support</a></li>\r\n		<li><a href=\"http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/tikiwiki/\">View CVS</a></li>\r\n		<li><a href=\"http://sourceforge.net/tracker/?atid=506849&amp;group_id=64258&amp;func=browse\">Request Feature</a></li>\r\n		<li><a href=\"http://sourceforge.net/tracker/?func=add&amp;group_id=64258&amp;atid=506846\">Report Bug</a></li>\r\n		<li><a href=\"http://sourceforge.net/tracker/?func=browse&group_id=64258&amp;atid=506846\">Browse Bugs</a></li>\r\n		<li><a href=\"http://sourceforge.net/forum/?group_id=64258\">Forums</a></li>\r\n		<li><a href=\"http://sourceforge.net/mail/?group_id=64258\">Mail Lists</a></li>\r\n		<li><a href=\"http://alt.thetinfoilhat.com/\">Demo Site</a></li>\r\n		<li><a href=\"cvsstats/index.html\">CVS stats</a></li>\r\n		<li><a href=\"http://sourceforge.net/pm/?group_id=64258\">Tasks</a></li>\r\n	</ul>\r\n</div> <!-- div menubar -->\r\n\r\n<div id=\"pagebody\">\r\n\r\n	<div class=\"tabs\">\r\n		<span id=\"tab1\" class=\"tab tabActive\">News</span>\r\n		<span id=\"tab2\" class=\"tab\">Partners</span>\r\n		<span id=\"tab3\" class=\"tab\">Features</span>\r\n		<span id=\"tab4\" class=\"tab\">Downloads</span>\r\n		<span id=\"tab6\" class=\"tab\">Meet the team</span>\r\n		<span id=\"tab5\" class=\"tab\">Join the team</span>\r\n		<span id=\"tab7\" class=\"tab\">Upcoming version</span>\r\n	</div>\r\n	\r\n	<div id=\"content1\" class=\"content\">\r\n	\r\n		<h1>All The News that\'s Fit to Print</h1>\r\n\r\n		<h2>Tiki 1.6.1 released!</h2>\r\n		<div class=\"published\">Published: 26th May 2003</div>\r\n		<p>A bugfix version of Tiki 1.6. No new features or improvements just many bugfixes from the 1.6 release.\r\n		</p>\r\n\r\n\r\n		<h2>Galaxia documentation unleashed</h2>\r\n		<div class=\"published\">Published: 19th May 2003</div>\r\n		<p>The Galaxia project is the Workflow engine that will be used in Tiki 1.7+, the engine is already available in CVS in alpha-status, the documentation describes how to use the Workflow engine, how to create a process and execute it. The tutorial should be working with the current CVS HEAD so you can try it out.<br/>\r\n		Documents:<br/>\r\n		<a href=\"Galaxia_manual.pdf\">Galaxia documentation and user manual</a><br/>\r\n		<a href=\"http://tikiwiki.sourceforge.net/Galaxia_introduction.pdf\">Galaxia introduction and concepts</a>\r\n		</p>\r\n		\r\n		<h2>Tiki 1.6 \"Tau Ceti\" Released!</h2>\r\n		<div class=\"published\">Published: 5th May 2003</div>\r\n		<p>Plenty of good news; install script added, notable performance improvement, less memory consumption, and alot of new features!  This version also fixes several bugs found in Tiki 1.5 and 1.6RC1 users that want\r\n		to enjoy the new features are encouraged to upgrade.</p>\r\n		<h3>Principal Changes/Additions (<a href=\"changelog.txt\">Read the full changelog</a>)</h3>\r\n		<ul>\r\n			<li>New MyTiki section grouping Webmail, Newsreader, User Calendar, User notepad, User personal Files, User tasks, User preferences, User bookmarks, User menus and User messages.</li>\r\n			<li>Newsreader (NTTP) added</li>\r\n			<li>User calendar added, with daily and weekly views, import/export events from/to Outlook, list and search events and event reminders</li>\r\n			<li>User files section, users can upload and download personal files, a quota can be assigned by admin</li>\r\n			<li>User notepad added, users can write notes, view notes unparsed or parsed as wiki pages. Download notes, upload notes. Etc.</li>\r\n			<li>User tasks added and user tasks module added, users can add tasks, track activity completion,etc.</li>\r\n			<li>User menus added: users can add personal links to the application menu.</li>\r\n			<li>Directory added. Dmoz-alike directory with categories, URL suggestion and validation, top sites, new sites listing and many features.</li>\r\n			<li>Internal messaging system added with option to send broadcast messages. Users can also send messages to groups, admin can broadcast to all users, messages can have priorities.</li>\r\n			<li>LDAP Authentication</li>\r\n			<li>Notable performance improvements and less memory consumption.</li>\r\n			<li>Graphviz integration, wiki graphs can be displayed and navigated.</li>\r\n			<li>Themes can now optionally redefine any Tiki template.</li>\r\n			<li>Ephemerides</li>\r\n			<li>Wiki page footnotes, personal notes per-user about wiki pages.</li>\r\n			<li>Wiki structures added, Wiki tables of contents can be created and slides can be displayed from a Wiki structure.</li>\r\n			<li>Theme control center added, opntionally admin can setup different themes for sections, categories, or even individual objects.</li>\r\n			<li>Many plugins added: SQL, INCLUDE, CODE, AVATAR, CENTER, DL, GAUGE, SPLIT.</li>\r\n			<li>Minor edits of wiki pages are available.</li>\r\n			<li>Inter wiki links added</li>\r\n			<li>New themes added.</li>\r\n			<li>Who is online modules and other new modules added.</li>\r\n			<li>Improved permission admin interface. Permissions can now be grouped in levels and levels can be assigned to groups.</li>\r\n			<li>Wiki pages can now be locked at a user-level.</li>\r\n			<li>Many bugs fixed, many surprises, many improvements.</li>\r\n		</ul>\r\n\r\n\r\n		<h2>Tiki\'s New Look .. or three!</h2>\r\n		<div class=\"published\">Published: 23rd April 2003 by Mark Limburg</div>\r\n		<p>After much struggle (I have a serious love/hate thing going on with CSS and XHTML), our new homepage is done.  This is a 100% CSS and XHTML page, with NO tables (check the source, I\'m not kidding) and with some javascripting magic, we\'ve plenty of useful eye-candy from a style swapper to a full multi-tabbed interface.  Big thanks to those at <a href=\"http://www.dhtmlkitch.com/\">DHTML Kitchen</a> for the inital scripts for the tabs.  So, dive in and enjoy!.</p>\r\n\r\n		<h2>Introduction to Galaxia: A PHP based workflow engine</h2>\r\n		<div class=\"published\">Published: 12th April 2003</div>\r\n		<p>Workflow project has started!  Galaxia, announced the release of the first project document: \"<a href=\"http://tikiwiki.sourceforge.net/Galaxia_introduction.pdf\">Galaxia introduction and concepts</a>\".  Galaxia is a Workflow engine based on Openflow (http://www.openflow.it). It\'s being designed and coded by an independant group of developers lead by Tiki\'s project manager Garland Foster.</p>\r\n\r\n\r\n	</div>\r\n	\r\n	<div id=\"content2\" class=\"content\">\r\n	\r\n		<h1>Tiki partnershipts</h1>\r\n\r\n		<p>This is a list of companies and projects that actively cooperate with Tiki.</p>\r\n		<img border=\'0\' src=\'jgraph.gif\' alt=\'jgraphpad logo\' />\r\n		<p><a href=\"http://jgraph.sourceforge.net/\"><b>JGraphPad</b></a> JGraphPad is a very advanced and powerful yet simple to use tool to create drawings, graphs, diagrams and drawings. Tiki uses JGraphPad to edit drawings that can be inserted in Wiki pages, Blogs, Articles and other Tiki objects. So you can create a drawing insert it in some page, edit it later or even better let other users edit the drawing.</p>\r\n		<hr/>\r\n		<img border=\'0\' src=\'phpopentracker.jpeg\' alt=\'phpopentracker logo\' />\r\n		<p><a href=\"http://www.phpopentracker.de/\"><b>PHPOpenTracker</b></a> is a framework solution for the analysis of website traffic and visitor analysis. Tiki provides a template based GUI to phpopentracker so you can see statistics of all sorts about your site.</p>\r\n		<hr/>\r\n		<img src=\'htmlarea.gif\' alt=\'htmlarea logo\' />\r\n		<p><a href=\"http://www.interactivetools.com/products/htmlarea/\"><b>htmlArea</b></a> is a WYSIWYG editor replacement for any textarea field. Tiki uses htmlarea to provide WYSIWYG editing in some objects. The most notable usage is in Tiki blogs where you can edit a blog post using a WYSIWYG editor without worries.<br/>\r\n		Another usages include: editing user modules, dynamic content system and HTML pages.</p>\r\n		<hr/>\r\n		<img src=\'hawhaw.gif\' alt=\'Haw Haw logo\' />\r\n		<p><a href=\"http://www.hawhaw.de/\"><b>HawHaw</b></a> HAWHAW stands for \"HTML and WML hybrid adapted Webserver\"\r\n		and is a PHP-based toolkit to create universal mobile applications. Tiki will be WML and PDA enabled from version 1.7\r\n		using HawHaw.</p>\r\n		\r\n		\r\n\r\n	</div>\r\n	\r\n	<div id=\"content3\" class=\"content\">\r\n\r\n		<h1>Tiki, Feature Overview</h1>\r\n\r\n		<h2>Design Features</h2>\r\n		<ul>\r\n			<li>Outputs valid XHTML code</li>\r\n			<li>Uses CSS to deploy themes</li>\r\n			<li>Permission system using groups and users</li>\r\n			<li>Uses PEAR::DB to access databases</li>\r\n			<li>Multi-language support</li>\r\n			<li>Template-based using Smarty, customizable layout and look and feel</li>\r\n			<li>Caching system for external pages and images</li>\r\n			<li>Externally linked images are downloaded to the Tiki image base</li>\r\n			<li>Rankings for all the features</li>\r\n			<li>Integrated Search engine</li>\r\n		</ul>\r\n		\r\n		<h2>Tiki Capabilities</h2>\r\n		<ul>\r\n			<li>A Wiki</li>\r\n			<li>Image Galleries</li>\r\n			<li>Weblogs/Journals</li>\r\n			<li>File Galleries</li>\r\n			<li>Polls</li>\r\n			<li>Articles and Submissions</li>\r\n			<li>Chat</li>\r\n			<li>Forums</li>\r\n			<li>FAQs</li>\r\n			<li>Quizzes</li>\r\n			<li>HTML and Dynamic HTML Pages (ie: Live Updates!)</li>\r\n			<li>RSS Feeds</li>\r\n			<li>Templates</li>\r\n			<li>Editable Drawings and Figures</li>\r\n			<li>Comments</li>\r\n			<li>Surveys</li>\r\n			<li>Webmail</li>\r\n			<li>Newsletters</li>\r\n			<li>Trackers</li>\r\n			<li>Internal Messaging</li>\r\n			<li>Calendar</li>\r\n			<li>User Tasks</li>\r\n			<li>User Notepad</li>\r\n			<li>Links Directory</li>\r\n			<li>User Files</li>\r\n			<li>Ephemerides</li>\r\n			<li>And a grand total of more than 375 features not listed!</li>\r\n		</ul>\r\n	</div>\r\n	\r\n	<div id=\"content4\" class=\"content\">\r\n		<h1>File Downloads</h1>\r\n		\r\n		<h2>TikiWiki, Stable</h2>\r\n		<div class=\"download\"><a href=\"https://sourceforge.net/project/showfiles.php?group_id=64258\">Download</a></div>\r\n		<p>\r\n			Grab the latest stable release of TikiWiki for your site today,  freshly served \r\n			from the sourceforge download server.\r\n		</p>\r\n		\r\n		<h2>TouchGraphWikiBrowser</h2>\r\n		<div class=\"download\"><a href=\"https://sourceforge.net/project/showfiles.php?group_id=64258&amp;release_id=127019\">Download</a></div>\r\n		<p>\r\n			A graphical visualization tool for the Wiki. This very nice Java application\r\n			will show you a graph of the Wiki along with the HTML content of the current\r\n			page and you can navigate the wiki following the links between nodes. A very\r\n			nice complement to the Wiki.\r\n		</p>\r\n		\r\n		<h2>wBloggar 3.0</h2>\r\n		<div class=\"download\"><a href=\"https://sourceforge.net/project/showfiles.php?group_id=64258&amp;release_id=127019\">Download</a></div>\r\n		<p>\r\n			One of the best desktop applications to manage weblogs and of course it is ready\r\n			to be used with Tiki weblogs. Write weblog posts from your windows desktop, save\r\n			posts edit old posts, remove posts, etc.\r\n		</p>\r\n  \r\n		<h2>Taglines Pack 1</h2>\r\n		<div class=\"download\"><a href=\"https://sourceforge.net/project/showfiles.php?group_id=64258&amp;release_id=127019\">Download</a></div>\r\n		<p>\r\n			A zipped txt file with a collection of computer-related taglines that are ready \r\n			to be uploaded to the tiki taglines system. Upload the taglines and use the {cookie}\r\n			syntax to display a random tagline in a wiki page, forum post or comment. \r\n		</p>\r\n\r\n		<h2>Game Pack 1</h2>\r\n		<div class=\"download\"><a href=\"https://sourceforge.net/project/showfiles.php?group_id=64258&amp;release_id=127019\">Download</a></div>\r\n		<p>\r\n			A collection of very nice flash games ready to be uploaded to your tiki \"games\" \r\n			directory. Installation instructions are very simple and included in the package,\r\n			about 20 games are ready to play at one click.\r\n		</p>\r\n\r\n		<h2>Spellchecking Dictionary for English</h2>\r\n		<div class=\"download\"><a href=\"https://sourceforge.net/project/showfiles.php?group_id=64258&amp;release_id=127019\">Download</a></div>\r\n		<p>\r\n			English version of the dictionary needed for the spellchecker (or it won\'t do\r\n			anything).\r\n		</p>\r\n		\r\n 	</div>\r\n	\r\n	<div id=\"content5\" class=\"content\">\r\n		<h1>CVS, Code and Developers, Oh My!</h1>\r\n\r\n		<h2>Can You Help?</h2>\r\n		<p>Tiki is easy to customize and extend, there\'re a lot of planned features so if you want to contribute, please contact Luis.  Remember, if you are not a programmer, you can always help out with adding themes, languages, bug reports, and your ideas to Tiki.</p>\r\n		<p>Contact email: <a href=\"mailto:lrargerich@yahoo.com\">lrargerich@yahoo.com</a></p>\r\n	</div>	\r\n	\r\n	\r\n	\r\n	<div id=\"content6\" class=\"content\">\r\n		<h1>The tiki develoment team</h1>\r\n		<table width=\"100%\">	\r\n			<tr>\r\n				<td width=\"50%\" valign=\"top\" id=\"team_col1\" >\r\n					<p>\r\n					<img style=\"float:left;margin-right:4px;\" src=\"team/luis.gif\" />\r\n					<a href=\"mailto:luis@fuegolabs.com\"><b>Luis Argerich (29)</b></a>. Buenos Aires, Argentina<br />\r\n					<i>\"It\'s just data\"</i><br/>\r\n					Teacher at the University of Buenos Aires, Software developer,\r\n					open source fundamentalist and Bridge player. Author of many Tiki\r\n					features. \r\n					<br /><small>YahooId: lrargerich</small>\r\n					</p>\r\n					\r\n					<p>\r\n					\r\n					<!--<img width=\"45\" height=\"59\"  style=\"float:left;margin-right:4px;\" src=\"team/Garland2.jpg\" />-->\r\n					<b>Garland Foster (44)</b>. Green Bay, Wisconsin.<br />\r\n					<i>\"Go Packers go!\"</i><br />\r\n					From the frozen tundra Mr Foster is helping the Tiki team to organize the chaos inherent\r\n					to every open-source project. He was in charge of the Tiki documentation until version\r\n					1.6 and authored the install script and the Workflow engine: Galaxia.\r\n					</p>\r\n					\r\n					<p>\r\n					<a href=\"mailto:damienmckenna@genesi-usa.com\"><b>Damien McKenna (27)</b></a>.Sanford, Florida, USA<br />\r\n					<i>\"For years I\'d hoped that someone would write a powerful content management \r\n					system that did it all, and then I found Tiki, and they have!\"</i><br />\r\n					Web developer for Genesi Sarl, an international PowerPC-based systems \r\n					developer.  I work with a team of others from around the US.\r\n					</p>\r\n					\r\n					<p>\r\n					<img width=\"45\" height=\"59\"  style=\"float:left;margin-right:4px;\" src=\"team/patrick.jpg\" />\r\n					<a href=\"mailto:\"><b>Patrick Van der Veken (34)</b></a>. Scherpenheuvel-Zichem, Belgium<br />\r\n					<i>Awesome, just awesome </i><br />\r\n					UNIX adept, trying to translate Tiki into Dutch, trying to understand \r\n					how Tiki works :rolleyes:.  In daily life, an independant UNIX sysadmin, \r\n					currently working on Production Engineering projects\r\n					<br /><small>ICQ: 4000286</small>\r\n					</p>\r\n					\r\n					<p>\r\n					<img width=\"45\" height=\"59\"  style=\"float:left;margin-right:4px;\" src=\"team/Greg_Martin.jpg\" />\r\n					<a href=\"mailto:gmartin@gmartin.org\"><b>Greg Martin</b>.</a>Perkasie, PA, US<br />\r\n					<i>\"Tiki is the fastest moving piece of software I\'ve ever seen.\"</i><br />\r\n					IT consultant/manager & computer hobbyist.  Self-taught Linux/Apache/MySQL.PHP. Tikiwiki is my first Open Source project.  Participating mostly to help flesh out Tiki ideas and to understand the community aspects of OS.\r\n					<br /><small>MSN/gregjmartin20@hotmail.com AOL/gregmartin20</small>\r\n					</p>\r\n					\r\n					<p>\r\n					<img width=\"45\" height=\"59\"  style=\"float:left;margin-right:4px;\" src=\"team/flothumb.jpg\" />\r\n					<a href=\"mailto:\"><b>Flo G. (33)</b></a>.Near Munich, Germany<br />\r\n					<i>\"A wiki with some more features! Some ...?\"</i><br />\r\n					Physican, working as UNIX and DB Admin. Playing basketball, UT and Schafkopf. I go sledding in winter and climbing in summer. vi is my editor and fvwm2 my windowmanager.\r\n					<br /><small></small>\r\n					</p>\r\n					\r\n					<p>\r\n					<img width=\"45\" height=\"59\"  style=\"float:left;margin-right:4px;\" src=\"team/ricardo.jpg\" />\r\n					<a href=\"mailto:ricardo.gladwell@btinternet.com\"><b>Ricardo Gladwell.</b></a>London, UK.<br />\r\n					<i>\"My god, it\'s full of stars!\"</i><br />\r\n					Web developer, Unix sysadmin and general jack-of-all-trades. I enjoy reading, writing, films and theater. I stumbled across Tiki when I was looking for a wiki to replace PHP-Nuke for my open-content roleplaying project, <a href=\"http://www.netbookofplanes.org/\">The Netbook of Planes</a> and never looked back.\r\n					<br /><small>YahooId:axonrg</small>\r\n					</p>\r\n					\r\n					<p>\r\n					<img width=\"45\" height=\"59\"  style=\"float:left;margin-right:4px;\" src=\"team/tetamose.jpg\" />\r\n					<a href=\"http://mose.fr/cv/?loc=en\"><b>Mose (35)</b></a>. Paris, France<br />\r\n					<i>\"That\'s a framework, a heaven for coders !\"</i><br />\r\n					Unqualified free software designer, fast coder, webdesigner, unix\r\n					admin, geek of all trades, involved in building collaborative and \r\n					free software. Speaks shell, sql, php and perl fluently.\r\n					<br /><small>irc: #tikiwiki on irc.freenode.net</small>\r\n					</p>\r\n				\r\n				\r\n				</td>\r\n				<td width=\"50%\" valign=\"top\" id=\"team_col2\" >\r\n					<p>\r\n					<img width=\"45\" height=\"59\" style=\"float:left;margin-right:4px;\" src=\"team/poli.jpg\" />\r\n					<a href=\"mailto:eduardo@polidor.net\"><b>Eduardo Polidor (30)</b></a>. Sao Paulo, Brazil<br />\r\n					<i>\"It\'s snowing in Sao Paulo.\"</i><br/>\r\n					Used to teach at the university and is now managing projects using the\r\n					web for health and finnancial transactions. He comes from the dark side\r\n					to help the Tiki team achieve world domination.\r\n					<br /><small>YahooId: epolidor</small>\r\n					</p>\r\n					\r\n					<p>\r\n					<img width=\"45\" height=\"59\"  style=\"float:left;margin-right:4px;\" src=\"team/fotogmuslera.jpg\" />\r\n					<a href=\"mailto:gmuslera@internet.com.uy\"><b>Gustavo Muslera</b></a>. Montevideo, Uruguay<br />\r\n					<i>\"I need some inspiration\"</i><br />\r\n					An active participant in the Tiki devel mailing list.\r\n					<br /><small>ICQ:16596516</small>\r\n					</p>\r\n					\r\n					<p>\r\n					<img width=\"45\" height=\"59\"  style=\"float:left;margin-right:4px;\" src=\"team/ohertel.jpg\" />\r\n					<a href=\"mailto:rom@readonly.de\"><b>Oliver \'ROM\' Hertel (32)</b></a>.Frankfurt, Germany.<br />\r\n					<i>Woah, that easy!</i><br />\r\n					Professional java and php developer, using TikiWiki at his employee\'s company, too.\r\n					<br /><small>ICQ: 329769157 YahooId:ohertel</small>\r\n					</p>\r\n					\r\n					<p>\r\n					<a href=\"mailto:tiki@marclaporte.com\"><b>Marc Laporte</b></a>.Montréal, Canada<br />\r\n					<i>I was looking for a Wiki. I found so much more!!</i><br />\r\n					IT consultant and open source enthusiast\r\n					<br /><small></small>\r\n					</p>\r\n					\r\n					<p>\r\n					<img width=\"45\" height=\"59\"  style=\"float:left;margin-right:4px;\" src=\"team/markl.jpeg\" />\r\n					<a href=\"mailto:\"><b>Mark Limburg</b></a><br />\r\n					<i>\"Don\'t give *me* that kinkier than thou look.\"</i><br />\r\n					Mark is in charge of the production of themes and usability of Tiki. He dessigned this new\r\n					home page for us here at SourceForge and is working in a brand new set of themes for Tiki.\r\n					<br /><small></small>\r\n					</p>\r\n					\r\n					<p>\r\n					<img width=\"45\" height=\"59\"  style=\"float:left;margin-right:4px;\" src=\"team/Mario.gif\" />\r\n					<a href=\"mailto:mariomene@stopspam.yahoo.com\"><b>Mario Mene (38)</b></a>. Rome, Italy<br />\r\n					<i>\"need a solution?\"</i><br />\r\n					General purpose italian engineer, knows nothing about everything, using Tiki for his personal website. First experience in open source distributed development.\r\n					<br /><small></small>\r\n					</p>\r\n					\r\n					<p>\r\n					<a href=\"mailto:tiki-stuff@heltzel.org\"><b>Dennis Heltzel</b></a>.Pottstown, PA, USA (near Philadelphia)<br />\r\n					<i>\"I wish I\'d found Tiki first\"</i><br />\r\n					Oracle DBA, Linux/Solaris Sys Admin, Webmaster for a number of small clubs devoted to my other hobby, raising tropical fish.\r\n					<br /><small></small>\r\n					</p>\r\n					\r\n					<p>\r\n					<img width=\"56\" height=\"70\"  style=\"float:left;margin-right:4px;\" src=\"team/aaron.jpg\" />\r\n					<a href=\"mailto:\"><b>Aaron Holmes (20)</b></a>. Niagara falls, Canada.<br />\r\n					<i>\"send a quote!\"</i><br />\r\n					Vice President and senior programmer of a small web development and programming firm located in Southern Ontario, Canada. Open source advocate and Tiki enthusiast.\r\n					<br /><small>Yahooid: aholmes9 ICQ: 24787134</small>\r\n					</p>\r\n					\r\n					<p>\r\n					<img width=\"45\" height=\"59\"  style=\"float:left;margin-right:4px;\" src=\"team/JoanVilarino.jpg\" />\r\n					<a href=\"mailto:lechuckdapirate@lycos.es\"><b>Joan Vilariño (35)</b></a>.Barcelona, Spain.<br />\r\n					<i>\"I think we have a winner\"</i><br />\r\n					I code since I remember, I also so some network admin functions. I currently work at IT department in a construction enterprise.\r\n					<br /><small>ICQ:553088 – YahooId:jai_bee – MSNM:jaibee_the_jaibeer@hotmail.com</small>\r\n					</p>\r\n					\r\n					<p>\r\n					<img width=\"45\" height=\"59\"  style=\"float:left;margin-right:4px;\" src=\"team/\" />\r\n					<a href=\"mailto:\"><b></b></a><br />\r\n					<i></i><br />\r\n					\r\n					<br /><small></small>\r\n					</p>\r\n				\r\n				</td>\r\n			\r\n			</tr>\r\n		</table>\r\n	</div>\r\n	\r\n	<div id=\"content7\" class=\"content\">\r\n		<h1>Previewing Tiki 1.7 -Eta Carinae-</h1>\r\n		<p>This is just a list of <i>some</i> features in Tiki 1.7</p>\r\n		<p>Tiki 1.7 will feature a bunch of new features, many usability improvements and a general improvement\r\n		in usability and look and feel.</p>\r\n		<p><b>Better UI</b>: user interfaces will be improved adding icons and improving the layout and alignement\r\n		of tables. Listings can now be configured selecting which columns to display.</p>\r\n		<p><b>Amazing forums!</b>: the forums section will feature a lot of improvements matching top-level forum players like phpBB and others:\r\n			<ul>\r\n				<li>Forum posts can be automatically forwarded to an email address (outbound email)</li>\r\n				<li>Forum posts can be read from an email account (inbound email)</li>\r\n				<li>A group can be set as moderator, then all the group users are moderators</li>\r\n				<li>Forum posts can have attachments</li>\r\n				<li>Improved editor for forum posts including helplinks</li>\r\n				<li>Topic smileys can be used when posting topics</li>\r\n				<li>Topic summaries allowed when posting a new topic</li>\r\n				<li>Moderation queue added, posts from users without auto-approve permission are send to an approval queue</li>\r\n				<li>Posts can be reported to moderators</li>\r\n				<li>User information configurable: user name, level, number of posts, online status, etc.</li>\r\n				<li>Private responses using tiki internal messages are allowed</li>\r\n				<li>Moderators can moved/remove/merge/split posts. Many posts can be moved/removed at once.</li>\r\n				<li>Posts can be converted into a new topic</li>\r\n				<li>And believe us: more!</li>\r\n			</ul>\r\n		</p>\r\n		<p><b>Blogs revamped!</b>: The tiki blogs will have now the same or even more features than other blogging PHP packages:\r\n			<ul>\r\n				<li>Multi-page posts supported, easy and sweet</li>\r\n				<li>Improved interface to add images to blog posts</li>\r\n				<li>Permalinks supported</li>\r\n				<li>Trackback pings supported (full implementation with auto-discovery)</li>\r\n				<li>Blog headings can be configured</li>\r\n				<li>Send blog posts by email feature</li>\r\n				<li>WYSIWYG editing mode for blog posts (optional)</li>\r\n			</ul>\r\n		</p>\r\n		<p><b>Multi page articles</b>: Now articles and reviews can have any number of pages with a very simple\r\n		syntax to define pages, automatic navigation is added to multi-page articles.\r\n		</p>\r\n		<p><b>Banning system</b>: Users can be banned by IP or username from one or many sections of Tiki, the system accepts\r\n		regular expressions for user names and wildcards for IPs (IP ranges). The rules can be configured to be active in a specified period of time implementing\r\n		a suspension mechanism.\r\n		</p>\r\n		<p><b>Live support system</b>: A revolutionary new approach to live-support chat, without frames or browsers reloading. Tiki users can be\r\n		configured as operators, users can \"request\" support and operators accept support calls starting a one-on-one chat. You can now chat with\r\n		your users if they have a problem!\r\n		</p>\r\n		<p><b>Workflow(!)</b>: A full-fledged workflow engine is added to Tiki (Galaxia), the engine implements an activity-based\r\n		workflow where activities are represented as PHP scripts, interactive activities are modeled as a combination of one PHP script and one\r\n		Smarty template. A process modeler including a process graph, wizards and editors are included to create, monitor and execute processes.\r\n		Processes can be imported/exported using an XML format. This opens a whole new world of opportunities to your Tiki!.\r\n		</p>\r\n		<p><b>Charts and rankings</b>:\r\n		A new feature where carts and rankings can be created, weekly, daily, monthly or real-time charts can be created. \r\n		</p>\r\n		<p><b>JgraphPad integration</b>:\r\n		Jgraphpad is now the official editor for drawings that can be then included in Wiki pages, articles, blog posts and other Tiki objects.\r\n		Using JGP you can create really powerful and nice looking graphs, diagrams and other drawings. An amazing tool.\r\n		</p>\r\n		<p><b>PDA & WML support</b>:\r\n		Tiki is now integrated to HawHaw, and the 1.7 version will feature a PDA&WML accesible Wiki. Yes! you will be able to browse your\r\n		Wiki using a PDA or cell-phone.\r\n		</p>\r\n		<p><b>Wiki2PDF features</b>:\r\n		Wiki pages can be converted to PDF, a Wiki structure can be converted to PDF generating a booklet. This is extremely useful\r\n		in documentation projects.\r\n		</p>\r\n		<p><b>Improved uploading</b>: In image galleries, file galleries and user files up to 6 files can now be uploaded in a single post without using the batch upload feature.\r\n		</p>\r\n		<p><b>WYSIWYG editor(!)</b>:\r\n		A WYSIWYG HTML editor is added to Tiki features where HTML editing is supported and expected. Using the editor is optional.\r\n		HTMLArea is used as the WYSIWYG editor.		\r\n		</p>\r\n		<p><b>Search-engine friendliness</b>:\r\n		Re-write rules added so your Tiki objects can be accessed in a search-engine friendly way. \r\n		</p>\r\n	</div>\r\n\r\n</div> <!-- div pageleft -->\r\n\r\n<div id=\"pagebar\">\r\n\r\n	<h1>What is TikiWiki?</h1>\r\n	<p><i>\"A catch-all PHP application so you don\'t have to install many!\"</i></p>\r\n	<p>TikiWiki is an open source web application which provides a full Wiki environment, as well as Articles, Sections, User/Group Management (including optinal LDAP interaction), Polls and Quizzes, File and Image Galleries, Forums, Comments on many areas, Weblogs, and much more.</p>\r\n\r\n	<h1>Some numbers</h1>\r\n	<p>\r\n		<b>&raquo; </b>Tiki has 272202 lines of code.<br />\r\n		<b>&raquo; </b>The bug-rate is 0.0020 bugs per line.<br />\r\n		<b>&raquo; </b>Tiki has more than 375 different features.\r\n	</p>\r\n\r\n	<h1>Licensing</h1>\r\n	<p>Tiki is 100% free and open-source. Released under the LGPL license. Basically you can do whatever you want with Tiki</p>\r\n\r\n	<h1>Make a donation! (PayPal)</h1>\r\n	<div align=\"center\">\r\n		<input type=\"hidden\" name=\"cmd\" value=\"_xclick\">\r\n		<input type=\"hidden\" name=\"business\" value=\"tiki@marclaporte.com\">\r\n		<input type=\"hidden\" name=\"item_name\" value=\"Tiki CMS/Groupware donation\">\r\n		<input type=\"hidden\" name=\"no_shipping\" value=\"1\">\r\n		<input type=\"hidden\" name=\"cn\" value=\"Optional note\">\r\n		<input type=\"hidden\" name=\"currency_code\" value=\"USD\">\r\n		<input type=\"hidden\" name=\"tax\" value=\"0\">\r\n		<input type=\"image\" src=\"https://www.paypal.com/images/x-click-but21.gif\" border=\"0\" name=\"submit\" alt=\"Make payments with PayPal - it\'s fast, free and secure!\">\r\n		</form>\r\n	</div>\r\n\r\n	<h1>Style Swapper</h1>\r\n	<p>\r\n		<b>&raquo; </b><span style=\"cursor: help;\" onClick=\"chooseStyle(0);\" title=\"The Deault Mozilla Look\">Mozilla (Default)</span><br />\r\n		<b>&raquo; </b><span style=\"cursor: help;\" onClick=\"chooseStyle(1);\" title=\"A More Corporate Look\">WebXP</span><br />\r\n		<b>&raquo; </b><span style=\"cursor: help;\" onClick=\"chooseStyle(2);\" title=\"Relax into the Liquid\">Liquid</span>\r\n	</p>\r\n	\r\n	\r\n	\r\n	<h1>Associated With</h1>\r\n	<div align=\"center\">\r\n		<a href=\"http://www.opensource.org/docs/definition.php\" title=\"Certified with the OSI\"><img src=\"button_osi.png\" width=\"88\" height=\"31\" alt=\"\" border=\"0\" /></a>\r\n		<a href=\"http://www.php.net/\" title=\"Powered by PHP4\"><img src=\"button_php.png\" width=\"88\" height=\"31\" alt=\"\" border=\"0\" /></a>\r\n		<br />\r\n		<a href=\"http://smarty.php.net/\" title=\"Rendered by the SMARTY Template Engine\"><img src=\"button_smarty.gif\" width=\"88\" height=\"31\" alt=\"\" border=\"0\" /></a>\r\n		<a href=\"http://pear.php.net\" title=\"Powered by PEAR::db\"><img src=\"button_pear.png\" width=\"88\" height=\"31\" alt=\"\" border=\"0\" /></a>\r\n		<br />\r\n		<a href=\"http://www.w3.org/MarkUp/\" title=\"Rendered in XHTML1\"><img src=\"button_xhtml.png\" width=\"88\" height=\"31\" alt=\"\" border=\"0\" /></a>\r\n		<a href=\"http://www.w3.org/Style/CSS/\" title=\"Styled by CSS1/2\"><img src=\"button_css.png\" width=\"88\" height=\"31\" alt=\"\" border=\"0\" /></a>\r\n		<br />\r\n	</div>\r\n	\r\n	<form action=\"https://www.paypal.com/cgi-bin/webscr\" method=\"post\">\r\n\r\n	\r\n\r\n\r\n</div> <!-- div pageright -->\r\n\r\n<br clear=\"all\" />\r\n\r\n</body>\r\n</html>',1058245572);





CREATE TABLE tiki_links (
"fromPage" varchar(160) NOT NULL default '',
"toPage" varchar(160) NOT NULL default '',
PRIMARY KEY ("fromPage","toPage")
) ;






INSERT INTO tiki_links VALUES ('AWordWithCapitals','HomePage');
INSERT INTO tiki_links VALUES ('LisasPage','HaTha-pradIpikA');
INSERT INTO tiki_links VALUES ('LisasPage','Sanskrit-English');
INSERT INTO tiki_links VALUES ('LisasPage','SvAtmArAma');
INSERT INTO tiki_links VALUES ('NewPage','JobHunting');
INSERT INTO tiki_links VALUES ('NewPage','NextPage');
INSERT INTO tiki_links VALUES ('NextPage','JobHunting');
INSERT INTO tiki_links VALUES ('NoHTMLCodeIsNeeded','AWordWithCapitals');





CREATE TABLE tiki_live_support_events (
"eventId" integer NOT NULL default nextval('tiki_live_support_events_seq') unique not null,
"reqId" varchar(32) NOT NULL default '',
"type" varchar(40) NOT NULL default '',
"seqId" integer NOT NULL default '0',
"senderId" varchar(32) NOT NULL default '',
"data" text NOT NULL,
"timestamp" integer NOT NULL default '0',
PRIMARY KEY ("eventId")
) ;











CREATE TABLE tiki_live_support_message_comments (
"cId" integer NOT NULL default nextval('tiki_live_support_message_c_seq') unique not null,
"msgId" integer NOT NULL default '0',
"data" text NOT NULL,
"timestamp" integer NOT NULL default '0',
PRIMARY KEY ("cId")
) ;











CREATE TABLE tiki_live_support_messages (
"msgId" integer NOT NULL default nextval('tiki_live_support_messages_seq') unique not null,
"data" text NOT NULL,
"timestamp" integer NOT NULL default '0',
"user" varchar(200) NOT NULL default '',
"username" varchar(200) NOT NULL default '',
"priority" integer NOT NULL default '0',
"status" varchar(1) NOT NULL default '',
"assigned_to" varchar(200) NOT NULL default '',
"resolution" varchar(100) NOT NULL default '',
"title" varchar(200) NOT NULL default '',
"module" integer NOT NULL default '0',
"email" varchar(250) NOT NULL default '',
PRIMARY KEY ("msgId")
) ;











CREATE TABLE tiki_live_support_modules (
"modId" integer NOT NULL default nextval('tiki_live_support_modules_seq') unique not null,
"name" varchar(90) NOT NULL default '',
PRIMARY KEY ("modId")
) ;






INSERT INTO tiki_live_support_modules VALUES (1,'wiki');
INSERT INTO tiki_live_support_modules VALUES (2,'forums');
INSERT INTO tiki_live_support_modules VALUES (3,'image galleries');
INSERT INTO tiki_live_support_modules VALUES (4,'file galleries');
INSERT INTO tiki_live_support_modules VALUES (5,'directory');
INSERT INTO tiki_live_support_modules VALUES (6,'workflow');
INSERT INTO tiki_live_support_modules VALUES (7,'charts');





CREATE TABLE tiki_live_support_operators (
"user" varchar(200) NOT NULL default '',
"accepted_requests" integer NOT NULL default '0',
"status" varchar(20) NOT NULL default '',
"longest_chat" integer NOT NULL default '0',
"shortest_chat" integer NOT NULL default '0',
"average_chat" integer NOT NULL default '0',
"last_chat" integer NOT NULL default '0',
"time_online" integer NOT NULL default '0',
"votes" integer NOT NULL default '0',
"points" integer NOT NULL default '0',
"status_since" integer NOT NULL default '0',
PRIMARY KEY ("user")
) ;











CREATE TABLE tiki_live_support_requests (
"reqId" varchar(32) NOT NULL default '',
"user" varchar(200) NOT NULL default '',
"tiki_user" varchar(200) NOT NULL default '',
"email" varchar(200) NOT NULL default '',
"operator" varchar(200) NOT NULL default '',
"operator_id" varchar(32) NOT NULL default '',
"user_id" varchar(32) NOT NULL default '',
"reason" text NOT NULL,
"req_timestamp" integer NOT NULL default '0',
"timestamp" integer NOT NULL default '0',
"status" varchar(40) NOT NULL default '',
"resolution" varchar(40) NOT NULL default '',
"chat_started" integer NOT NULL default '0',
"chat_ended" integer NOT NULL default '0',
PRIMARY KEY ("reqId")
) ;











CREATE TABLE tiki_mail_events (
"event" varchar(200) NOT NULL default '',
"object" varchar(200) NOT NULL default '',
"email" varchar(200) NOT NULL default ''
) ;











CREATE TABLE tiki_mailin_accounts (
"accountId" integer NOT NULL default nextval('tiki_mailin_accounts_seq') unique not null,
"user" varchar(200) NOT NULL default '',
"account" varchar(50) NOT NULL default '',
"pop" varchar(255) NOT NULL default '',
"port" integer NOT NULL default '0',
"username" varchar(100) NOT NULL default '',
"pass" varchar(100) NOT NULL default '',
"active" varchar(1) NOT NULL default '',
"type" varchar(40) NOT NULL default '',
"smtp" varchar(255) NOT NULL default '',
"useAuth" varchar(1) NOT NULL default '',
"smtpPort" integer NOT NULL default '0',
PRIMARY KEY ("accountId")
) ;











CREATE TABLE tiki_menu_languages (
"menuId" integer NOT NULL default nextval('tiki_menu_languages_seq') unique not null,
"language" varchar(2) NOT NULL default '',
PRIMARY KEY ("language","menuId")
) ;











CREATE TABLE tiki_menu_options (
"optionId" integer NOT NULL default nextval('tiki_menu_options_seq') unique not null,
"menuId" integer NOT NULL default '0',
"type" varchar(1) NOT NULL default '',
"name" varchar(20) NOT NULL default '',
"url" varchar(255) NOT NULL default '',
"position" integer NOT NULL default '0',
PRIMARY KEY ("optionId")
) ;











CREATE TABLE tiki_menus (
"menuId" integer NOT NULL default nextval('tiki_menus_seq') unique not null,
"name" varchar(20) NOT NULL default '',
"description" text NOT NULL,
"type" varchar(1) NOT NULL default '',
PRIMARY KEY ("menuId")
) ;











CREATE TABLE tiki_minical_events (
"user" varchar(200) NOT NULL default '',
"eventId" integer NOT NULL default nextval('tiki_minical_events_seq') unique not null,
"title" varchar(250) NOT NULL default '',
"description" text NOT NULL,
"start" integer NOT NULL default '0',
"end" integer NOT NULL default '0',
"security" varchar(1) NOT NULL default '',
"duration" integer NOT NULL default '0',
"topicId" integer NOT NULL default '0',
"reminded" varchar(1) NOT NULL default '',
PRIMARY KEY ("eventId")
) ;











CREATE TABLE tiki_minical_topics (
"user" varchar(200) NOT NULL default '',
"topicId" integer NOT NULL default nextval('tiki_minical_topics_seq') unique not null,
"name" varchar(250) NOT NULL default '',
"filename" varchar(200) NOT NULL default '',
"filetype" varchar(200) NOT NULL default '',
"filesize" varchar(200) NOT NULL default '',
"data" text,
"path" varchar(250) NOT NULL default '',
"isIcon" varchar(1) NOT NULL default '',
PRIMARY KEY ("topicId")
) ;











CREATE TABLE tiki_modules (
"name" varchar(200) NOT NULL default '',
"position" varchar(1) NOT NULL default '',
"ord" integer NOT NULL default '0',
"type" varchar(1) NOT NULL default '',
"title" varchar(40) NOT NULL default '',
"cache_time" integer NOT NULL default '0',
"rows" integer NOT NULL default '0',
"groups" text NOT NULL,
"params" varchar(250) NOT NULL default '',
PRIMARY KEY ("name")
) ;






INSERT INTO tiki_modules VALUES ('login_box','r',1,'','',0,0,'','');
INSERT INTO tiki_modules VALUES ('application_menu','l',1,'','',0,10,'a:0:{}','');
INSERT INTO tiki_modules VALUES ('search_box','r',1,'','',0,10,'a:0:{}','');
INSERT INTO tiki_modules VALUES ('calendar','l',1,'','',0,10,'a:0:{}','');
INSERT INTO tiki_modules VALUES ('google','r',0,'','',0,10,'a:0:{}','');
INSERT INTO tiki_modules VALUES ('shoutbox','l',1,'','',0,10,'a:0:{}','');
INSERT INTO tiki_modules VALUES ('top_active_blogs','l',1,'','',0,10,'a:0:{}','');
INSERT INTO tiki_modules VALUES ('breadcrumb','r',1,'','',0,10,'a:0:{}','');
INSERT INTO tiki_modules VALUES ('logged_users','r',1,'','',0,10,'a:0:{}','');
INSERT INTO tiki_modules VALUES ('slashdot','r',1,'','',0,10,'a:0:{}','0');
INSERT INTO tiki_modules VALUES ('php.net','l',1,'','',60,10,'a:0:{}','0');
INSERT INTO tiki_modules VALUES ('debianplanet','r',2,'','',0,10,'a:0:{}','');





CREATE TABLE tiki_newsletter_subscriptions (
"nlId" integer NOT NULL default '0',
"email" varchar(255) NOT NULL default '',
"code" varchar(32) NOT NULL default '',
"valid" varchar(1) NOT NULL default '',
"subscribed" integer NOT NULL default '0',
PRIMARY KEY ("email","nlId")
) ;











CREATE TABLE tiki_newsletters (
"nlId" integer NOT NULL default nextval('tiki_newsletters_seq') unique not null,
"name" varchar(200) NOT NULL default '',
"description" text NOT NULL,
"created" integer NOT NULL default '0',
"lastSent" integer NOT NULL default '0',
"editions" integer NOT NULL default '0',
"users" integer NOT NULL default '0',
"allowAnySub" varchar(1) NOT NULL default '',
"frequency" integer NOT NULL default '0',
PRIMARY KEY ("nlId")
) ;






INSERT INTO tiki_newsletters VALUES (1,'test','test',1051799502,1051799502,0,0,'n',604800);





CREATE TABLE tiki_newsreader_marks (
"user" varchar(200) NOT NULL default '',
"serverId" integer NOT NULL default '0',
"groupName" varchar(255) NOT NULL default '',
"timestamp" integer NOT NULL default '0',
PRIMARY KEY ("groupName","user","serverId")
) ;











CREATE TABLE tiki_newsreader_servers (
"user" varchar(200) NOT NULL default '',
"serverId" integer NOT NULL default nextval('tiki_newsreader_servers_seq') unique not null,
"server" varchar(250) NOT NULL default '',
"port" integer NOT NULL default '0',
"username" varchar(200) NOT NULL default '',
"password" varchar(200) NOT NULL default '',
PRIMARY KEY ("serverId")
) ;











CREATE TABLE tiki_page_footnotes (
"user" varchar(200) NOT NULL default '',
"pageName" varchar(250) NOT NULL default '',
"data" text NOT NULL,
PRIMARY KEY ("pageName","user")
) ;











CREATE TABLE tiki_pages (
"pageName" varchar(160) NOT NULL default '',
"hits" integer NOT NULL default '0',
"data" text NOT NULL,
"lastModif" integer NOT NULL default '0',
"comment" varchar(200) NOT NULL default '',
"version" integer NOT NULL default '0',
"user" varchar(200) NOT NULL default '',
"ip" varchar(15) NOT NULL default '',
"flag" varchar(1) NOT NULL default '',
"points" integer NOT NULL default '0',
"votes" integer NOT NULL default '0',
"pageRank" decimal(5,3) NOT NULL default '0.000',
"description" varchar(200) NOT NULL default '',
"cache" text,
"cache_timestamp" integer NOT NULL default '0',
"creator" varchar(200) NOT NULL default '',
PRIMARY KEY ("pageName")




) ;






INSERT INTO tiki_pages VALUES ('HomePage',783,'[http://tikiwiki.sf.net/|tiki]',1045231844,'',31,'ross','192.168.1.2','',0,0,0.386,'',NULL,0,'ross');
INSERT INTO tiki_pages VALUES ('JobHunting',12,'[http://losangeles.craigslist.org/eng/] - while this site looks good, I\'ve submitted several resumes and have received 0 replies.  Probably just spammers harvesting email addresses....',1039947473,'',2,'ross','192.168.1.2','',0,0,0.395,'',NULL,0,'ross');
INSERT INTO tiki_pages VALUES ('NoHTMLCodeIsNeeded',2,'This is another page ((AWordWithCapitals))',1038794163,'',1,'ross','192.168.1.2','',0,0,0.150,'',NULL,0,'ross');
INSERT INTO tiki_pages VALUES ('AWordWithCapitals',1,'Another Page\r\n\r\n((HomePage))',1038794197,'',1,'ross','192.168.1.2','',0,0,0.278,'',NULL,0,'ross');
INSERT INTO tiki_pages VALUES ('LisasPage',1,'\r\nPer Lisa\'s request, here are the definitions from Monier-Williams\' Sanskrit-English Dictionary for ha, Tha, and haTha I found using the search engine:\r\n\r\n[http://www.uni-koeln.de/phil-fak/indologie/tamil/mwd_search.html]\r\n\r\n* ha\r\n \r\nMeaning  1 the thirty-third and last consonant of the Na1gari1 alphabet (in Pa1n2ini\'s system belonging to the guttural class , and usually pronounced like the English %{h} in %{hard} ; it is not an original letter , but is mostly derived from an older %{gh} , rarely from %{dh} or %{bh}).\r\n\r\nMeaning  2 (only L.) m. a form of S3iva or Bhairava (cf. %{nakulI7za}) ; water ; a cipher (i.e. the arithmetical figure which symbolizes o) ; meditation , auspiciousness ; sky , heaven , paradise ; blood ; dying ; fear ; knowledge ; the moon ; Vishn2u ; war , battle ; horripilation ; a horse ; pride ; a physician ; cause , motive ; = %{pApa-haraNa} ; = %{sakopa-vAraNa} ; = %{zuSka} ; (also %{A} f.) laughter ; (%{A}) f. coition ; a lute (%{am}) n. the Supreme Spirit ; pleasure , delight ; a weapon ; the sparkling of a gem ; calling , calling to the sound of a lute ; (ind.) = %{aham} (?) , IndSt. ; mfn. mad , drunk. \r\n \r\nMeaning  3 ind. (prob. orig. identical with 2. %{gha} , and used as a particle for emphasizing a preceding word , esp. if it begins a sentence closely connected with another ; very frequent in the Bra1hman2as and Su1tras , and often translatable by) indeed , assuredly , verily , of course , then &c. (often with other particles e.g. with %{tv@eva} , %{u} , %{sma} , %{vai} &c. ; %{na@ha} , `\" not indeed \"\' ; also with interrogatives and relatives e.g. %{yad@dha} , `\" when indeed \"\' ; %{kad@dha} , `\" what then? \"\' sometimes with impf. or pf. [cf. Pa1n2. 3-2 , 116] ; in later language very commonly used as a mere expletive , esp. at the end of a verse) RV. &c. &c. \r\n\r\nMeaning  4 mf(%{A})n. (fr. %{han}) killing , destroying , removing (only ifc. ; see %{arAti-} , %{vRtra-} , %{zatruha} &c.) \r\n\r\nMeaning  5 mf(%{A})n. (fr. 3. %{hA}) abandoning , deserting , avoiding (ifc. ; see %{an-oka-} and %{vApI-ha}) ; (%{A}) f. abandonment , desertion L. \r\n\r\n* Tha\r\n \r\nMeaning  1 the aspirate of the preceding consonant.\r\n\r\nMeaning  2 m. a loud noise (%{ThaThaM@ThaThaM@ThaM@ThaThaThaM@ThaThaM@ThaH} , an imitative sound as of a golden pitcher rolling down steps Maha1n.2 iii , 5) L. ; the moon\'s disk L. ; a disk L. ; a cypher L. ; a place frequented by all L. ; S3iva L. \r\n\r\n* haTha\r\n \r\nMeaning  m. violence , force (ibc. , %{ena} , and %{At} , `\" by force , forcibly \"\') R. Ra1jat. Katha1s. &c. ; obstinacy , pertinacity (ibc. and %{At} , `\" obstinately , persistently \"\') Pan5cat. Katha1s. ; absolute or inevitable necessity (as the cause of all existence and activity ; ibc. , %{At} , and %{ena} , `\" necessarily , inevitably , by all means \"\') MBh. Ka1v. &c. ; = %{haTha-yoga} Cat. ; oppression W. ; rapine ib. ; going in the rear of an enemy L. ; Pistia Stratiotes L. \r\n\r\n* haTha-yoga\r\n\r\nMeaning m. a kind of forced Yoga or abstract meditation (forcing the mind to withdraw from external objects; treated of in the HaTha-pradIpikA by SvAtmArAma and performed with much self-torture, such as standing on one leg, holding up the arms, inhaling smoke with the head inverted &c.)\r\n\r\n',1038940749,'',1,'ross','192.168.1.2','',0,0,0.150,'',NULL,0,'ross');
INSERT INTO tiki_pages VALUES ('NewPage',1,'Adding an entry to test the full text search function.\r\n\r\nHere are some search terms:\r\n\r\nJobHunting\r\ntest\r\ntiki\r\n\r\nNextPage',1040866218,'',1,'ross','192.168.1.2','',0,0,0.150,'',NULL,0,'ross');
INSERT INTO tiki_pages VALUES ('NextPage',1,'Adding an entry to test the full text search function.\r\n\r\nHere are some search terms:\r\n\r\nJobHunting\r\ntest\r\ntiki\r\n',1040866230,'',1,'ross','192.168.1.2','',0,0,0.214,'',NULL,0,'ross');





CREATE TABLE tiki_pageviews (
"day" integer NOT NULL default '0',
"pageviews" integer NOT NULL default '0',
PRIMARY KEY ("day")
) ;






INSERT INTO tiki_pageviews VALUES (1038643200,92);
INSERT INTO tiki_pageviews VALUES (1038729600,43);
INSERT INTO tiki_pageviews VALUES (1038902400,44);
INSERT INTO tiki_pageviews VALUES (1039075200,2);
INSERT INTO tiki_pageviews VALUES (1039161600,31);
INSERT INTO tiki_pageviews VALUES (1039507200,29);
INSERT INTO tiki_pageviews VALUES (1039593600,60);
INSERT INTO tiki_pageviews VALUES (1039680000,92);
INSERT INTO tiki_pageviews VALUES (1039766400,117);
INSERT INTO tiki_pageviews VALUES (1039939200,48);
INSERT INTO tiki_pageviews VALUES (1040025600,2);
INSERT INTO tiki_pageviews VALUES (1040112000,4);
INSERT INTO tiki_pageviews VALUES (1040284800,4);
INSERT INTO tiki_pageviews VALUES (1040371200,12);
INSERT INTO tiki_pageviews VALUES (1040544000,99);
INSERT INTO tiki_pageviews VALUES (1040630400,14);
INSERT INTO tiki_pageviews VALUES (1040803200,165);
INSERT INTO tiki_pageviews VALUES (1040889600,27);
INSERT INTO tiki_pageviews VALUES (1040976000,31);
INSERT INTO tiki_pageviews VALUES (1041148800,17);
INSERT INTO tiki_pageviews VALUES (1041235200,20);
INSERT INTO tiki_pageviews VALUES (1041408000,91);
INSERT INTO tiki_pageviews VALUES (1041494400,130);
INSERT INTO tiki_pageviews VALUES (1041552000,35);
INSERT INTO tiki_pageviews VALUES (1041667200,62);
INSERT INTO tiki_pageviews VALUES (1041638400,8);
INSERT INTO tiki_pageviews VALUES (1041724800,96);
INSERT INTO tiki_pageviews VALUES (1041753600,179);
INSERT INTO tiki_pageviews VALUES (1041811200,122);
INSERT INTO tiki_pageviews VALUES (1041840000,1);
INSERT INTO tiki_pageviews VALUES (1041897600,1);
INSERT INTO tiki_pageviews VALUES (1042012800,2);
INSERT INTO tiki_pageviews VALUES (1041984000,1);
INSERT INTO tiki_pageviews VALUES (1042099200,1);
INSERT INTO tiki_pageviews VALUES (1042070400,21);
INSERT INTO tiki_pageviews VALUES (1044172800,14);
INSERT INTO tiki_pageviews VALUES (1044432000,2);
INSERT INTO tiki_pageviews VALUES (1044864000,35);
INSERT INTO tiki_pageviews VALUES (1044950400,112);
INSERT INTO tiki_pageviews VALUES (1045036800,115);
INSERT INTO tiki_pageviews VALUES (1045123200,13);
INSERT INTO tiki_pageviews VALUES (1045209600,82);
INSERT INTO tiki_pageviews VALUES (1045296000,13);
INSERT INTO tiki_pageviews VALUES (1045382400,31);
INSERT INTO tiki_pageviews VALUES (1045468800,6);
INSERT INTO tiki_pageviews VALUES (1045728000,2);
INSERT INTO tiki_pageviews VALUES (1045900800,45);
INSERT INTO tiki_pageviews VALUES (1046073600,11);
INSERT INTO tiki_pageviews VALUES (1046160000,46);
INSERT INTO tiki_pageviews VALUES (1046131200,2);
INSERT INTO tiki_pageviews VALUES (1046764800,1);
INSERT INTO tiki_pageviews VALUES (1046822400,3);
INSERT INTO tiki_pageviews VALUES (1046851200,1);
INSERT INTO tiki_pageviews VALUES (1047283200,1);
INSERT INTO tiki_pageviews VALUES (1047340800,29);
INSERT INTO tiki_pageviews VALUES (1047369600,2);
INSERT INTO tiki_pageviews VALUES (1048060800,1);
INSERT INTO tiki_pageviews VALUES (1048118400,1);
INSERT INTO tiki_pageviews VALUES (1048147200,1);
INSERT INTO tiki_pageviews VALUES (1048204800,1);
INSERT INTO tiki_pageviews VALUES (1049698800,1);
INSERT INTO tiki_pageviews VALUES (1049760000,3);
INSERT INTO tiki_pageviews VALUES (1050044400,1);
INSERT INTO tiki_pageviews VALUES (1050019200,1);
INSERT INTO tiki_pageviews VALUES (1051254000,1);
INSERT INTO tiki_pageviews VALUES (1051315200,7);
INSERT INTO tiki_pageviews VALUES (1051340400,1);
INSERT INTO tiki_pageviews VALUES (1051513200,3);
INSERT INTO tiki_pageviews VALUES (1051488000,1);
INSERT INTO tiki_pageviews VALUES (1051772400,47);
INSERT INTO tiki_pageviews VALUES (1051747200,107);
INSERT INTO tiki_pageviews VALUES (1051858800,1);
INSERT INTO tiki_pageviews VALUES (1051833600,48);
INSERT INTO tiki_pageviews VALUES (1052204400,1);
INSERT INTO tiki_pageviews VALUES (1052265600,4);
INSERT INTO tiki_pageviews VALUES (1052290800,2);
INSERT INTO tiki_pageviews VALUES (1052377200,1);
INSERT INTO tiki_pageviews VALUES (1052438400,2);
INSERT INTO tiki_pageviews VALUES (1052463600,1);
INSERT INTO tiki_pageviews VALUES (1052982000,1);
INSERT INTO tiki_pageviews VALUES (1052956800,1);
INSERT INTO tiki_pageviews VALUES (1053154800,18);
INSERT INTO tiki_pageviews VALUES (1053846000,1);
INSERT INTO tiki_pageviews VALUES (1053907200,3);
INSERT INTO tiki_pageviews VALUES (1054105200,1);
INSERT INTO tiki_pageviews VALUES (1054166400,5);
INSERT INTO tiki_pageviews VALUES (1054796400,1);
INSERT INTO tiki_pageviews VALUES (1054771200,6);
INSERT INTO tiki_pageviews VALUES (1055401200,3);
INSERT INTO tiki_pageviews VALUES (1055376000,3);
INSERT INTO tiki_pageviews VALUES (1055660400,1);
INSERT INTO tiki_pageviews VALUES (1055721600,1);
INSERT INTO tiki_pageviews VALUES (1056438000,6);
INSERT INTO tiki_pageviews VALUES (1057708800,40);
INSERT INTO tiki_pageviews VALUES (1057734000,1);
INSERT INTO tiki_pageviews VALUES (1057906800,4);
INSERT INTO tiki_pageviews VALUES (1057968000,149);
INSERT INTO tiki_pageviews VALUES (1057993200,39);
INSERT INTO tiki_pageviews VALUES (1058054400,176);
INSERT INTO tiki_pageviews VALUES (1058079600,19);
INSERT INTO tiki_pageviews VALUES (1058140800,47);
INSERT INTO tiki_pageviews VALUES (1058166000,16);
INSERT INTO tiki_pageviews VALUES (1058227200,39);
INSERT INTO tiki_pageviews VALUES (1058252400,4);





CREATE TABLE tiki_poll_options (
"pollId" integer NOT NULL default '0',
"optionId" integer NOT NULL default nextval('tiki_poll_options_seq') unique not null,
"title" varchar(200) NOT NULL default '',
"votes" integer NOT NULL default '0',
PRIMARY KEY ("optionId")
) ;











CREATE TABLE tiki_polls (
"pollId" integer NOT NULL default nextval('tiki_polls_seq') unique not null,
"title" varchar(200) NOT NULL default '',
"votes" integer NOT NULL default '0',
"active" varchar(1) NOT NULL default '',
"publishDate" integer NOT NULL default '0',
PRIMARY KEY ("pollId")
) ;











CREATE TABLE tiki_preferences (
"name" varchar(40) NOT NULL default '',
"value" varchar(250) NOT NULL default '',
PRIMARY KEY ("name")
) ;






INSERT INTO tiki_preferences VALUES ('feature_wiki','y');
INSERT INTO tiki_preferences VALUES ('feature_chat','y');
INSERT INTO tiki_preferences VALUES ('feature_polls','y');
INSERT INTO tiki_preferences VALUES ('feature_custom_home','y');
INSERT INTO tiki_preferences VALUES ('feature_forums','y');
INSERT INTO tiki_preferences VALUES ('feature_file_galleries','y');
INSERT INTO tiki_preferences VALUES ('feature_banners','y');
INSERT INTO tiki_preferences VALUES ('feature_xmlrpc','y');
INSERT INTO tiki_preferences VALUES ('feature_categories','y');
INSERT INTO tiki_preferences VALUES ('feature_comm','y');
INSERT INTO tiki_preferences VALUES ('feature_search','y');
INSERT INTO tiki_preferences VALUES ('feature_edit_templates','y');
INSERT INTO tiki_preferences VALUES ('feature_dynamic_content','y');
INSERT INTO tiki_preferences VALUES ('feature_articles','y');
INSERT INTO tiki_preferences VALUES ('feature_submissions','y');
INSERT INTO tiki_preferences VALUES ('feature_blogs','y');
INSERT INTO tiki_preferences VALUES ('feature_hotwords','y');
INSERT INTO tiki_preferences VALUES ('feature_userPreferences','y');
INSERT INTO tiki_preferences VALUES ('feature_featuredLinks','y');
INSERT INTO tiki_preferences VALUES ('feature_galleries','y');
INSERT INTO tiki_preferences VALUES ('tikiIndex','tiki-index.php');
INSERT INTO tiki_preferences VALUES ('style','neat.css');
INSERT INTO tiki_preferences VALUES ('language','en');
INSERT INTO tiki_preferences VALUES ('anonCanEdit','n');
INSERT INTO tiki_preferences VALUES ('modallgroups','y');
INSERT INTO tiki_preferences VALUES ('cachepages','n');
INSERT INTO tiki_preferences VALUES ('cacheimages','n');
INSERT INTO tiki_preferences VALUES ('popupLinks','y');
INSERT INTO tiki_preferences VALUES ('allowRegister','y');
INSERT INTO tiki_preferences VALUES ('maxRecords','10');
INSERT INTO tiki_preferences VALUES ('feature_blog_rankings','y');
INSERT INTO tiki_preferences VALUES ('feature_blog_comments','y');
INSERT INTO tiki_preferences VALUES ('blog_comments_per_page','25');
INSERT INTO tiki_preferences VALUES ('blog_comments_default_ordering','points_desc');
INSERT INTO tiki_preferences VALUES ('home_blog','1');
INSERT INTO tiki_preferences VALUES ('feature_faqs','y');
INSERT INTO tiki_preferences VALUES ('feature_stats','y');
INSERT INTO tiki_preferences VALUES ('feature_games','y');
INSERT INTO tiki_preferences VALUES ('user_assigned_modules','y');
INSERT INTO tiki_preferences VALUES ('feature_user_bookmarks','y');
INSERT INTO tiki_preferences VALUES ('home_forum','');
INSERT INTO tiki_preferences VALUES ('feature_lastChanges','y');
INSERT INTO tiki_preferences VALUES ('feature_wiki_comments','y');
INSERT INTO tiki_preferences VALUES ('wiki_spellcheck','y');
INSERT INTO tiki_preferences VALUES ('feature_warn_on_edit','n');
INSERT INTO tiki_preferences VALUES ('feature_dump','y');
INSERT INTO tiki_preferences VALUES ('feature_wiki_rankings','y');
INSERT INTO tiki_preferences VALUES ('feature_wiki_undo','y');
INSERT INTO tiki_preferences VALUES ('feature_wiki_multiprint','y');
INSERT INTO tiki_preferences VALUES ('feature_ranking','n');
INSERT INTO tiki_preferences VALUES ('feature_listPages','y');
INSERT INTO tiki_preferences VALUES ('feature_history','y');
INSERT INTO tiki_preferences VALUES ('feature_sandbox','y');
INSERT INTO tiki_preferences VALUES ('feature_backlinks','y');
INSERT INTO tiki_preferences VALUES ('feature_likePages','y');
INSERT INTO tiki_preferences VALUES ('feature_userVersions','n');
INSERT INTO tiki_preferences VALUES ('siteTitle','Stemmin\' the Tide!');
INSERT INTO tiki_preferences VALUES ('useRegisterPasscode','n');
INSERT INTO tiki_preferences VALUES ('registerPasscode','');
INSERT INTO tiki_preferences VALUES ('validateUsers','n');
INSERT INTO tiki_preferences VALUES ('eponymousGroups','n');
INSERT INTO tiki_preferences VALUES ('forgotPass','n');
INSERT INTO tiki_preferences VALUES ('feature_shoutbox','y');
INSERT INTO tiki_preferences VALUES ('feature_quizzes','y');
INSERT INTO tiki_preferences VALUES ('feature_smileys','n');
INSERT INTO tiki_preferences VALUES ('feature_left_column','y');
INSERT INTO tiki_preferences VALUES ('feature_right_column','y');
INSERT INTO tiki_preferences VALUES ('feature_top_bar','y');
INSERT INTO tiki_preferences VALUES ('feature_bot_bar','y');
INSERT INTO tiki_preferences VALUES ('feature_drawings','y');
INSERT INTO tiki_preferences VALUES ('feature_html_pages','y');
INSERT INTO tiki_preferences VALUES ('feature_search_stats','y');
INSERT INTO tiki_preferences VALUES ('feature_referer_stats','y');
INSERT INTO tiki_preferences VALUES ('feature_hotwords_nw','y');
INSERT INTO tiki_preferences VALUES ('layout_section','y');
INSERT INTO tiki_preferences VALUES ('max_rss_articles','10');
INSERT INTO tiki_preferences VALUES ('max_rss_image_galleries','10');
INSERT INTO tiki_preferences VALUES ('max_rss_file_galleries','10');
INSERT INTO tiki_preferences VALUES ('max_rss_image_gallery','10');
INSERT INTO tiki_preferences VALUES ('max_rss_file_gallery','10');
INSERT INTO tiki_preferences VALUES ('max_rss_wiki','10');
INSERT INTO tiki_preferences VALUES ('max_rss_blogs','10');
INSERT INTO tiki_preferences VALUES ('max_rss_blog','10');
INSERT INTO tiki_preferences VALUES ('max_rss_forum','10');
INSERT INTO tiki_preferences VALUES ('max_rss_forums','10');
INSERT INTO tiki_preferences VALUES ('max_rss_mapfiles','10');
INSERT INTO tiki_preferences VALUES ('rss_articles','y');
INSERT INTO tiki_preferences VALUES ('rss_blogs','y');
INSERT INTO tiki_preferences VALUES ('rss_image_galleries','y');
INSERT INTO tiki_preferences VALUES ('rss_file_galleries','y');
INSERT INTO tiki_preferences VALUES ('rss_wiki','y');
INSERT INTO tiki_preferences VALUES ('rss_forum','y');
INSERT INTO tiki_preferences VALUES ('rss_forums','y');
INSERT INTO tiki_preferences VALUES ('rss_mapfiles','y');
INSERT INTO tiki_preferences VALUES ('rss_blog','y');
INSERT INTO tiki_preferences VALUES ('rss_image_gallery','y');
INSERT INTO tiki_preferences VALUES ('rss_file_gallery','y');
INSERT INTO tiki_preferences VALUES ('change_theme','y');
INSERT INTO tiki_preferences VALUES ('change_language','y');
INSERT INTO tiki_preferences VALUES ('count_admin_pvs','y');
INSERT INTO tiki_preferences VALUES ('useUrlIndex','n');
INSERT INTO tiki_preferences VALUES ('urlIndex','');
INSERT INTO tiki_preferences VALUES ('wiki_left_column','y');
INSERT INTO tiki_preferences VALUES ('wiki_right_column','y');
INSERT INTO tiki_preferences VALUES ('wiki_top_bar','y');
INSERT INTO tiki_preferences VALUES ('wiki_bot_bar','y');
INSERT INTO tiki_preferences VALUES ('feature_trackers','y');
INSERT INTO tiki_preferences VALUES ('feature_search_fulltext','y');
INSERT INTO tiki_preferences VALUES ('feature_webmail','y');
INSERT INTO tiki_preferences VALUES ('feature_surveys','y');
INSERT INTO tiki_preferences VALUES ('slide_style','slidestyle.css');
INSERT INTO tiki_preferences VALUES ('feature_server_name','wiki.netebb.com');
INSERT INTO tiki_preferences VALUES ('long_date_format','%A %B %d, %Y');
INSERT INTO tiki_preferences VALUES ('short_date_format','%a. %b. %d, %Y');
INSERT INTO tiki_preferences VALUES ('feature_obzip','n');
INSERT INTO tiki_preferences VALUES ('direct_pagination','n');
INSERT INTO tiki_preferences VALUES ('feature_bidi','n');
INSERT INTO tiki_preferences VALUES ('display_timezone','PST8PDT');
INSERT INTO tiki_preferences VALUES ('long_time_format','%H:%M:%S %Z');
INSERT INTO tiki_preferences VALUES ('short_time_format','%H:%M %Z');
INSERT INTO tiki_preferences VALUES ('feature_newsletters','y');
INSERT INTO tiki_preferences VALUES ('min_pass_length','1');
INSERT INTO tiki_preferences VALUES ('pass_due','999');
INSERT INTO tiki_preferences VALUES ('pass_chr_num','n');
INSERT INTO tiki_preferences VALUES ('feature_challenge','n');
INSERT INTO tiki_preferences VALUES ('feature_clear_passwords','n');
INSERT INTO tiki_preferences VALUES ('https_login','y');
INSERT INTO tiki_preferences VALUES ('https_login_required','n');
INSERT INTO tiki_preferences VALUES ('http_domain','wiki2.netebb.com');
INSERT INTO tiki_preferences VALUES ('http_port','18080');
INSERT INTO tiki_preferences VALUES ('https_domain','wiki2.netebb.com');
INSERT INTO tiki_preferences VALUES ('https_port','18443');
INSERT INTO tiki_preferences VALUES ('http_prefix','/');
INSERT INTO tiki_preferences VALUES ('https_prefix','/');
INSERT INTO tiki_preferences VALUES ('feature_directory','y');
INSERT INTO tiki_preferences VALUES ('feature_newsreader','y');
INSERT INTO tiki_preferences VALUES ('feature_notepad','y');
INSERT INTO tiki_preferences VALUES ('feature_userfiles','y');
INSERT INTO tiki_preferences VALUES ('feature_usermenu','y');
INSERT INTO tiki_preferences VALUES ('feature_minical','y');
INSERT INTO tiki_preferences VALUES ('feature_theme_control','y');
INSERT INTO tiki_preferences VALUES ('feature_workflow','y');
INSERT INTO tiki_preferences VALUES ('feature_user_watches','y');
INSERT INTO tiki_preferences VALUES ('feature_charts','y');
INSERT INTO tiki_preferences VALUES ('feature_phpopentracker','n');
INSERT INTO tiki_preferences VALUES ('feature_eph','y');
INSERT INTO tiki_preferences VALUES ('feature_contact','y');
INSERT INTO tiki_preferences VALUES ('feature_messages','y');
INSERT INTO tiki_preferences VALUES ('feature_tasks','y');
INSERT INTO tiki_preferences VALUES ('contact_user','admin');
INSERT INTO tiki_preferences VALUES ('system_os','unix');
INSERT INTO tiki_preferences VALUES ('tmpDir','/tmp');
INSERT INTO tiki_preferences VALUES ('lang_use_db','n');
INSERT INTO tiki_preferences VALUES ('record_untranslated','n');
INSERT INTO tiki_preferences VALUES ('feature_menusfolderstyle','n');
INSERT INTO tiki_preferences VALUES ('webserverauth','n');
INSERT INTO tiki_preferences VALUES ('rnd_num_reg','n');
INSERT INTO tiki_preferences VALUES ('rememberme','all');
INSERT INTO tiki_preferences VALUES ('remembertime','720000');
INSERT INTO tiki_preferences VALUES ('auth_method','tiki');
INSERT INTO tiki_preferences VALUES ('feature_calendar','n');
INSERT INTO tiki_preferences VALUES ('feature_editcss','n');
INSERT INTO tiki_preferences VALUES ('wiki_feature_copyrights','n');
INSERT INTO tiki_preferences VALUES ('feature_wiki_monosp','y');





CREATE TABLE tiki_private_messages (
"messageId" integer NOT NULL default nextval('tiki_private_messages_seq') unique not null,
"toNickname" varchar(200) NOT NULL default '',
"data" varchar(255) NOT NULL default '',
"poster" varchar(200) NOT NULL default 'anonymous',
"timestamp" integer NOT NULL default '0',
PRIMARY KEY ("messageId")
) ;











CREATE TABLE tiki_programmed_content (
"pId" integer NOT NULL default nextval('tiki_programmed_content_seq') unique not null,
"contentId" integer NOT NULL default '0',
"publishDate" integer NOT NULL default '0',
"data" text NOT NULL,
PRIMARY KEY ("pId")
) ;











CREATE TABLE tiki_quiz_question_options (
"optionId" integer NOT NULL default nextval('tiki_quiz_question_options_seq') unique not null,
"questionId" integer NOT NULL default '0',
"optionText" text NOT NULL,
"points" integer NOT NULL default '0',
PRIMARY KEY ("optionId")
) ;











CREATE TABLE tiki_quiz_questions (
"questionId" integer NOT NULL default nextval('tiki_quiz_questions_seq') unique not null,
"quizId" integer NOT NULL default '0',
"question" text NOT NULL,
"position" integer NOT NULL default '0',
"type" varchar(1) NOT NULL default '',
"maxPoints" integer NOT NULL default '0',
PRIMARY KEY ("questionId")
) ;






INSERT INTO tiki_quiz_questions VALUES (1,1,'Question 1',1,'o',0);
INSERT INTO tiki_quiz_questions VALUES (2,1,'Question 2',1,'o',0);





CREATE TABLE tiki_quiz_results (
"resultId" integer NOT NULL default nextval('tiki_quiz_results_seq') unique not null,
"quizId" integer NOT NULL default '0',
"fromPoints" integer NOT NULL default '0',
"toPoints" integer NOT NULL default '0',
"answer" text NOT NULL,
PRIMARY KEY ("resultId")
) ;











CREATE TABLE tiki_quiz_stats (
"quizId" integer NOT NULL default '0',
"questionId" integer NOT NULL default '0',
"optionId" integer NOT NULL default '0',
"votes" integer NOT NULL default '0',
PRIMARY KEY ("quizId","optionId","questionId")
) ;











CREATE TABLE tiki_quiz_stats_sum (
"quizId" integer NOT NULL default '0',
"quizName" varchar(255) NOT NULL default '',
"timesTaken" integer NOT NULL default '0',
"avgpoints" decimal(5,2) NOT NULL default '0.00',
"avgavg" decimal(5,2) NOT NULL default '0.00',
"avgtime" decimal(5,2) NOT NULL default '0.00',
PRIMARY KEY ("quizId")
) ;











CREATE TABLE tiki_quizzes (
"quizId" integer NOT NULL default nextval('tiki_quizzes_seq') unique not null,
"name" varchar(255) NOT NULL default '',
"description" text NOT NULL,
"canRepeat" varchar(1) NOT NULL default '',
"storeResults" varchar(1) NOT NULL default '',
"questionsPerPage" integer NOT NULL default '0',
"timeLimited" varchar(1) NOT NULL default '',
"timeLimit" integer NOT NULL default '0',
"created" integer NOT NULL default '0',
"taken" integer NOT NULL default '0',
PRIMARY KEY ("quizId")
) ;






INSERT INTO tiki_quizzes VALUES (1,'A Test Quiz','A Test Quiz','n','n',999,'n',1,1040550135,0);





CREATE TABLE tiki_received_articles (
"receivedArticleId" integer NOT NULL default nextval('tiki_received_articles_seq') unique not null,
"receivedFromSite" varchar(200) NOT NULL default '',
"receivedFromUser" varchar(200) NOT NULL default '',
"receivedDate" integer NOT NULL default '0',
"title" varchar(80) NOT NULL default '',
"authorName" varchar(60) NOT NULL default '',
"size" integer NOT NULL default '0',
"useImage" varchar(1) NOT NULL default '',
"image_name" varchar(80) NOT NULL default '',
"image_type" varchar(80) NOT NULL default '',
"image_size" integer NOT NULL default '0',
"image_x" integer NOT NULL default '0',
"image_y" integer NOT NULL default '0',
"image_data" text,
"publishDate" integer NOT NULL default '0',
"created" integer NOT NULL default '0',
"heading" text NOT NULL,
"body" text,
"hash" varchar(32) NOT NULL default '',
"author" varchar(200) NOT NULL default '',
"type" varchar(50) NOT NULL default '',
"rating" decimal(4,2) NOT NULL default '0.00',
PRIMARY KEY ("receivedArticleId")
) ;











CREATE TABLE tiki_received_pages (
"receivedPageId" integer NOT NULL default nextval('tiki_received_pages_seq') unique not null,
"pageName" varchar(160) NOT NULL default '',
"data" text,
"comment" varchar(200) NOT NULL default '',
"receivedFromSite" varchar(200) NOT NULL default '',
"receivedFromUser" varchar(200) NOT NULL default '',
"receivedDate" integer NOT NULL default '0',
"description" varchar(200) NOT NULL default '',
PRIMARY KEY ("receivedPageId")
) ;











CREATE TABLE tiki_referer_stats (
"referer" varchar(50) NOT NULL default '',
"hits" integer NOT NULL default '0',
"last" integer NOT NULL default '0',
PRIMARY KEY ("referer")
) ;






INSERT INTO tiki_referer_stats VALUES ('skanda',2,1039714895);
INSERT INTO tiki_referer_stats VALUES ('wiki2.netebb.com',10,1058198715);
INSERT INTO tiki_referer_stats VALUES ('tikiwiki.org',1,1058072094);
INSERT INTO tiki_referer_stats VALUES ('10.0.0.2',13,1058139833);





CREATE TABLE tiki_related_categories (
"categId" integer NOT NULL default '0',
"relatedTo" integer NOT NULL default '0',
PRIMARY KEY ("categId","relatedTo")
) ;











CREATE TABLE tiki_rss_modules (
"rssId" integer NOT NULL default nextval('tiki_rss_modules_seq') unique not null,
"name" varchar(30) NOT NULL default '',
"description" text NOT NULL,
"url" varchar(255) NOT NULL default '',
"refresh" integer NOT NULL default '0',
"lastUpdated" integer NOT NULL default '0',
"content" text,
PRIMARY KEY ("rssId")
) ;






INSERT INTO tiki_rss_modules VALUES (1,'php.net','','http://www.php.net/news.rss',900,1058294881,'<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<rdf:RDF\n	xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\"\n	xmlns=\"http://purl.org/rss/1.0/\"\n	xmlns:dc=\"http://purl.org/dc/elements/1.1/\"\n>\n<channel rdf:about=\"http://www.php.net/\">\n	<title>PHP: Hypertext Preprocessor</title>\n	<link>http://www.php.net/</link>\n	<description>The PHP scripting language web site</description>\n	<items>\n		<rdf:Seq>\n			<rdf:li rdf:resource=\"http://www.linuxtag.org/2003/en/index.html\" />\n			<rdf:li rdf:resource=\"http://www.php.net/downloads.php\" />\n			<rdf:li rdf:resource=\"http://www.zend.com/survey/php_net.php\" />\n			<rdf:li rdf:resource=\"http://www.phpconference.de/2003/index_en.php\" />\n			<rdf:li rdf:resource=\"http://qa.php.net/\" />\n			<rdf:li rdf:resource=\"http://www.ActiveState.com/Corporate/ActiveAwards/\" />\n			<rdf:li rdf:resource=\"http://www.php.net/release_4_3_2.php\" />\n			<rdf:li rdf:resource=\"http://www.directi.com/?site=ip-to-country\" />\n			<rdf:li rdf:resource=\"http://www.php.net/my.php\" />\n			<rdf:li rdf:resource=\"http://www.php.net/my.php\" />\n			<rdf:li rdf:resource=\"http://www.phparch.com\" />\n			<rdf:li rdf:resource=\"http://www.php.net/echo\" />\n			<rdf:li rdf:resource=\"http://phpconf.hu/\" />\n			<rdf:li rdf:resource=\"http://www.php.net/release_4_3_1.php\" />\n		</rdf:Seq>\n	</items>\n</channel>\n<!-- RSS-Items -->\n\n<item rdf:about=\"http://www.linuxtag.org/2003/en/index.html\">\n	<title>PHP @ LinuxTag</title>\n	<link>http://www.linuxtag.org/2003/en/index.html</link>\n	<description>      From July, 10th to 13th 2003  LinuxTag, Europe\'s  largest Fair and Congress dedicated to Open Source in general and Linux in  particular, takes place in Karlsruhe, Germany.    Under the motto &quot;PHP and Friends&quot; the PHP Project showcases PHP and related  projects, like MySQL, SQLite, Midgard, osCommerce or DB Designer, at booth  F21.  In addition to the booth &quot;PHP and Friends&quot; offer an interesting  programme of  technical talks and workshops  which are held by 24 speakers from 11 nations and cover the latest trends and  technologies related to PHP, Apache and MySQL.  Among the speakers are core  developers of the discussed Open Source projects, for instance Ken Coar  (Apache), Rasmus Lerdorf (PHP) or Kaj Arn&amp;ouml; (MySQL).  </description>\n	<dc:date>2003-07-06</dc:date>\n</item>\n\n<item rdf:about=\"http://www.php.net/downloads.php\">\n	<title>PHP 5.0.0 Beta 1</title>\n	<link>http://www.php.net/downloads.php</link>\n	<description>    The PHP development community is proud to announce the release of PHP 5 Beta 1.  Both source packages,  and a Windows build are available in the Downloads Section.  A list of changes   can be found in the ChangeLog file.   Some of the more major changes include:     PHP 5 features the Zend Engine 2.  For a list of Zend Engine 2 changes, please visit   this webpage.  XML support has been completely redone in PHP 5, all extensions are now focused around the   excellent libxml2 library (http://www.xmlsoft.org/).  SQLite has been bundled with PHP.  For more information on SQLite, please visit their   website.  Streams have been greatly improved, including the ability to access lowlevel socket   operations on streams.    Note: This is a beta version. It should not be used in production or even semiproduction web sites. There are known bugs in it, and in addition, some of the features may change (based on feedback). We encourage you to download and play with it (and report bugs if you find any!), but please do not replace your production installations of PHP 4 at this time.  </description>\n	<dc:date>2003-06-29</dc:date>\n</item>\n\n<item rdf:about=\"http://www.zend.com/survey/php_net.php\">\n	<title>PHP Usage Survey</title>\n	<link>http://www.zend.com/survey/php_net.php</link>\n	<description>     Zend Technologies is sponsoring a public PHP Usage Survey.  The results will be shared with the PHP Group, and will help us to better understand the ways in which PHP is being used, and what may need improvement.  Fill it out and get a chance to win one of 50 PHP Tshirts!  </description>\n	<dc:date>2003-06-24</dc:date>\n</item>\n\n<item rdf:about=\"http://www.phpconference.de/2003/index_en.php\">\n	<title>International PHP Conference 2003</title>\n	<link>http://www.phpconference.de/2003/index_en.php</link>\n	<description>     The traditional International PHP Conference 2003 will be taking place from 2nd November to 5th November in Frankfurt (FFM).  The Call for Papers has been issued, so if you have an interesting talk, the organizers would love to hear about it! You can expect a gathering of PHP experts and core developers and to focus on PHP 5 as the main topic for the conference.   You can find the CfP on the website.  The deadline is 14th July, 2003.  The conference is also featuring an OpenSource Exhibition where PHP related OpenSource projects can present themselves for free.  </description>\n	<dc:date>2003-06-24</dc:date>\n</item>\n\n<item rdf:about=\"http://qa.php.net/\">\n	<title>PHP 4.3.3RC1 released</title>\n	<link>http://qa.php.net/</link>\n	<description>    PHP 4.3.3RC1 has been released for testing.  This is the first release candidate and should have a very low number of problems  and/or bugs. Nevertheless, please download and test it as much as possible on reallife   applications to uncover any remaining issues.    List of changes can be found in the   NEWS  file.  </description>\n	<dc:date>2003-06-19</dc:date>\n</item>\n\n<item rdf:about=\"http://www.ActiveState.com/Corporate/ActiveAwards/\">\n	<title>Active Awards Programmers\' Choice Nominees are in!</title>\n	<link>http://www.ActiveState.com/Corporate/ActiveAwards/</link>\n	<description>     Thanks to the community for recognizing their peers in ActiveState\'s third annual Active Awards.  The awards honor those individuals who actively contribute to open languages and display excellence in their programming efforts.  Please visit and help choose this years award winner!  More information and voting is at: http://www.ActiveState.com/Corporate/ActiveAwards/  </description>\n	<dc:date>2002-12-06</dc:date>\n</item>\n\n<item rdf:about=\"http://www.php.net/release_4_3_2.php\">\n	<title>PHP 4.3.2 Released!</title>\n	<link>http://www.php.net/release_4_3_2.php</link>\n	<description>   The PHP developers are proud to announce the immediate availability of PHP 4.3.2. This release contains a large number of bug fixes and is a strongly recommended update for all users of PHP. Full list of fixes can be found in the NEWS file.  </description>\n	<dc:date>2003-05-29</dc:date>\n</item>\n\n<item rdf:about=\"http://www.directi.com/?site=ip-to-country\">\n	<title>Automatic Mirror Select</title>\n	<link>http://www.directi.com/?site=ip-to-country</link>\n	<description>   In our ongoing battle to fight load and keep serving you content, whenever you perform a search on www.php.net, you will be redirected onto a nearby mirror (determined using the Directi IptoCountry Database).  You may experience a few quirks in the search until your mirrors have synced an uptodate version of the site.  </description>\n	<dc:date>2003-05-23</dc:date>\n</item>\n\n<item rdf:about=\"http://www.php.net/my.php\">\n	<title>Country Detection</title>\n	<link>http://www.php.net/my.php</link>\n	<description>   We are proud to introduce you the latest addition to our My PHP.net service. The PHP.net site and mirror sites now autodetect your country using the Directi IptoCountry Database. We use this information to present events in your country in bold letters on the frontpage, and to offer close mirror sites for downloads and your usual daily work.  </description>\n	<dc:date>2003-05-04</dc:date>\n</item>\n\n<item rdf:about=\"http://www.php.net/my.php\">\n	<title>My PHP.net</title>\n	<link>http://www.php.net/my.php</link>\n	<description>    The PHP website and mirrors sites now have a \'My PHP.net\' page, which allows you to check what language settings you have, and enables you to set one which will override all the other detected parameters.    However, normally this is not needed, as we remember the language you used last time. Be sure to have cookies turned on for PHP.net to let this feature work!  </description>\n	<dc:date>2003-04-24</dc:date>\n</item>\n\n<item rdf:about=\"http://www.phparch.com\">\n	<title>Grant Program</title>\n	<link>http://www.phparch.com</link>\n	<description>    php|architect, is proud to announce the creation of the php|architect Grant Program, whose goal is to provide financial support to bestofbreed PHPrelated projects.    Participation in the program is open to all opensource projects that are related to PHP (but not necessarily written in PHP). The program is accepting submissions now and will start distributing grants in June of 2003.    For more information, visit the program\'s website.  </description>\n	<dc:date>2003-03-06</dc:date>\n</item>\n\n<item rdf:about=\"http://www.php.net/echo\">\n	<title>Set your own language preference</title>\n	<link>http://www.php.net/echo</link>\n	<description>    Starting from today, your browser\'s &quot;Accept Language&quot; setting is also honored on language sensitive pages on the php.net site. If you would like to get to the documentation page of echo for example, you can use the /echo shortcut on all mirror sites, if your browser is set to provide your language preference information to the server. This also makes the PHP error message links point to the documentation in your preferred language.    You can set your preferences under Edit/Preferences/Navigator/Languages in Mozilla, and under Tools/Internet Options/Languages in Internet Explorer. This will probably also enhance your web experience on sites providing translated content.  </description>\n	<dc:date>2003-03-01</dc:date>\n</item>\n\n<item rdf:about=\"http://phpconf.hu/\">\n	<title>First Hungarian PHP Conference</title>\n	<link>http://phpconf.hu/</link>\n	<description>      The members of the Hungarian PHP community announce the first Hungarian PHP Conference which will take place in Budapest, on Saturday March 29th, sponsored by several international and local companies. The conference offers an entirely free one day activity with several presentations addressing basic and advanced topics, as well, exclusively in Hungarian. Moreover, a five kilobytelimited PHP contest has been started to discover the most talented PHP programmers in our country. The programme includes the first session of the socalled PHP Division which will be established with the set purpose of representing the community itself and promoting their interests in any national business and official phorums.  </description>\n	<dc:date>2003-02-25</dc:date>\n</item>\n\n<item rdf:about=\"http://www.php.net/release_4_3_1.php\">\n	<title>PHP 4.3.1 released in response to CGI vulnerability</title>\n	<link>http://www.php.net/release_4_3_1.php</link>\n	<description>    The PHP Group today announced the details of a serious CGI vulnerability in PHP version 4.3.0. A security update, PHP 4.3.1, fixes the issue. Everyone running affected version of PHP (as CGI) are encouraged to upgrade immediately. The new 4.3.1 release does not include any other changes, so upgrading from 4.3.0 is safe and painless.  </description>\n	<dc:date>2003-02-17</dc:date>\n</item>\n<!-- / RSS-Items PHP/RSS -->\n</rdf:RDF>\n');
INSERT INTO tiki_rss_modules VALUES (2,'slashdot','','http://slashdot.org/slashdot.rdf',1800,1058295004,'<?xml version=\"1.0\"?>\n\n<rdf:RDF\nxmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\"\nxmlns=\"http://my.netscape.com/rdf/simple/0.9/\">\n\n<channel>\n<title>Slashdot</title>\n<link>http://slashdot.org/</link>\n<description>News for nerds, stuff that matters</description>\n</channel>\n\n<image>\n<title>Slashdot</title>\n<url>http://images.slashdot.org/topics/topicslashdot.gif</url>\n<link>http://slashdot.org/</link>\n</image>\n\n<item>\n<title>The IT Market: Cyclical Downturn or New World Order?</title>\n<link>http://slashdot.org/article.pl?sid=03/07/15/188251</link>\n</item>\n\n<item>\n<title>The Mozilla Foundation</title>\n<link>http://slashdot.org/article.pl?sid=03/07/15/1736223</link>\n</item>\n\n<item>\n<title>All The Rave</title>\n<link>http://slashdot.org/article.pl?sid=03/07/11/1858235</link>\n</item>\n\n<item>\n<title>Matrix Reloaded on DVD Before Revolutions</title>\n<link>http://slashdot.org/article.pl?sid=03/07/15/1459257</link>\n</item>\n\n<item>\n<title>EU Rolls out Anti Spam Strategy</title>\n<link>http://slashdot.org/article.pl?sid=03/07/15/1359252</link>\n</item>\n\n<item>\n<title>New Kazaa Lite Protects Identity</title>\n<link>http://slashdot.org/article.pl?sid=03/07/15/1326240</link>\n</item>\n\n<item>\n<title>Big Brother Gets a Brain</title>\n<link>http://slashdot.org/article.pl?sid=03/07/15/1231217</link>\n</item>\n\n<item>\n<title>OpenOffice 1.1 RC 1 Released</title>\n<link>http://slashdot.org/article.pl?sid=03/07/15/1157247</link>\n</item>\n\n<item>\n<title>State Of The Filesystem</title>\n<link>http://slashdot.org/article.pl?sid=03/07/15/0615221</link>\n</item>\n\n<item>\n<title>LinuxTag: 40% Growth Over Last Year</title>\n<link>http://slashdot.org/article.pl?sid=03/07/15/018235</link>\n</item>\n\n<textinput>\n<title>Search Slashdot</title>\n<description>Search Slashdot stories</description>\n<name>query</name>\n<link>http://slashdot.org/search.pl</link>\n</textinput>\n\n</rdf:RDF>');
INSERT INTO tiki_rss_modules VALUES (3,'debianplanet','debianplanet','http://debianplanet.org/module.php?mod=node&op=feed',3600,1058293144,'<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\n<rss version=\"0.91\">\n<channel>\n <title>Debian Planet</title>\n <link>http://www.debianplanet.org/</link>\n <description>Everything Debian! News, interviews, comment.</description>\n <language>en</language>\n<item>\n <title>IBM on building Debian packages</title>\n <link>http://www.debianplanet.org/node.php?id=982</link>\n <description>Seen over at /.: IBM has put up a document by a freelance write on how to create Debian packages. Its nothing more than a short intro but I guess it will generate some interest...the Maintainer\'s Guide does a better job though!</description>\n</item>\n<item>\n <title>open.hands.com replaced, and in need of some test load</title>\n <link>http://www.debianplanet.org/node.php?id=980</link>\n <description>As I\'m sure most of you know, open.hands.com (previously serving www.uk.d.o) has been sadly unreliable for ages, so I recently replaced all the hardware (again, for about the 4th time).\n\nThis time with hardware that actually cost real money, namely a dual Xeon 1800 machine, with 2GB of ECC RAM, and a 3ware IDE RAID card with 4 120GB disks hanging off of it.\n\nOf course, this only ran for about a week before crashing, but the new hardware gave it enough headroom for it to provide some diagnosable symptoms --- it was occasionally managing quarter of a million context switches a second.</description>\n</item>\n<item>\n <title>Debian boot-floppies Gets More Bad Press</title>\n <link>http://www.debianplanet.org/node.php?id=978</link>\n <description>The Independent Newspaper has a &lt;a href=&quot;http://news.independent.co.uk/digital/features/story.jsp?story=420948&quot;&gt; review&lt;/a&gt; which thrashes Debian solely on basis of the author\'s bad experience with the installer.</description>\n</item>\n<item>\n <title>Securing Linux - Interview of Russell Coker</title>\n <link>http://www.debianplanet.org/node.php?id=977</link>\n <description>Today\'s Australian Age has an &lt;a href=&quot;http://www.theage.com.au/articles/2003/07/02/1056825450368.html&quot;&gt;interview &lt;/a&gt; of SE-Linux Debian Developer Russel Coker. Have you tested his SE Linux &quot;play&quot; machine with a public root password? You can find more about it &lt;a href=&quot;http://www.coker.com.au/selinux/&quot;&gt;here&lt;/a&gt;.</description>\n</item>\n<item>\n <title>Debian feature on SitePoint</title>\n <link>http://www.debianplanet.org/node.php?id=976</link>\n <description>My name is &lt;a href=&quot;http://www.jonobacon.org/&quot;&gt;Jono Bacon&lt;/a&gt; and I am a KDE developer and writer. I have recently written an article that introduces Debian and includes guidelines on installing Debian. The article is available at &lt;a href=&quot;http://www.sitepoint.com/article/1158&quot;&gt;SitePoint&lt;/a&gt;.</description>\n</item>\n<item>\n <title>Debootstrap/LVM with LNX-BBC 2.1</title>\n <link>http://www.debianplanet.org/node.php?id=975</link>\n <description>The new &lt;a href=&quot;http://www.lnx-bbc.org/&quot;&gt;LNX-BBC&lt;/a&gt; is out and being distributed by me (Jim Dennis) and friends of mine.  It\'s the continuing efforts of the orginal Linuxcare &quot;bootable business card&quot; crowd after we\'ve all left Linuxcare over the years.\n\nSome of the old versions of the BBC included &lt;b&gt;debootstrap&lt;/b&gt; and I used it routinely use it as my Debian installer.  However, this version doesn\'t include it.</description>\n</item>\n<item>\n <title>Australian Personal Computer on Debian</title>\n <link>http://www.debianplanet.org/node.php?id=974</link>\n <description>I went off to my local Border\'s this morning, and in between flicking through a few cookbooks, Motor magazine (hooray for a 533kW, 1250kg Evo VII), and a book with a huge rap from Branden &quot;Overfiend&quot; Robinson, I had a not-so-quick flick through &lt;a href=&quot;http://apcmag.com&quot;&gt;APC&lt;/a&gt;, which &lt;a href=&quot;http://www.debianplanet.org/node.php?id=972&quot;&gt;included Debian on its cover CD&lt;/a&gt;. Read on to see what they had to say about Debian.</description>\n</item>\n<item>\n <title>Bonzai Linux Version 2.0</title>\n <link>http://www.debianplanet.org/node.php?id=973</link>\n <description>Immediately after the release of version 1.8, the Debian based mini-distribution Bonzai Linux is now available in version 2.0. The step in the version numbering scheme should indicate that this is a \'stable\' Release.\n\nThe only change that has been made is to the kernel version. In version 1.8 of Bonzai Linux, kernel 2.4.20 was used. The current boot-floppies have been rebuilt to use Kernel 2.4.21 instead. This kernel has been compiled with gcc-3.2 due to space restrictions.</description>\n</item>\n<item>\n <title>Australian Personal Computer includes Debian on Cover CD</title>\n <link>http://www.debianplanet.org/node.php?id=972</link>\n <description>&lt;a href=&quot;http://www.apcmag.com&quot;&gt;Australian Personal Computer&lt;/a&gt; includes Debian 3.0 (2 CDs) on its cover this Month (July 2003).  This is the first time I have seen Debian on a cover CD in Australia.  APC has a wide distribution in Australia, so I think this is great news.  I must say that I am a little surprised that they went with Debian rather than (the usually trivial to get going) Knoppix, but kudos to them for making the right choice.  DebianPlanet is mentioned in the article, too ...\n\n&lt;b&gt;DanielS&lt;/b&gt;: APC are, I think, Australia\'s largest-selling computer magazine; unfortunately their articles aren\'t online.</description>\n</item>\n<item>\n <title>Debian 10th birthday party coordination page</title>\n <link>http://www.debianplanet.org/node.php?id=971</link>\n <description>On August 16th 2003 Debian hits double digits, and lots of people think that sounds like a pretty good reason for a party - or lots of parties! Trouble is there hasn\'t been a simple way to figure out who\'s organising what or where, so Debconf.org has just &lt;a href=&quot;http://www.debconf.org/10years/&quot;&gt;put up a page&lt;/a&gt; to help potential party-goers get in touch. It\'s still pretty thin, so if you know of events in your local area make sure you send in the details.</description>\n</item>\n<item>\n <title>Compiling kernels The Debian Way</title>\n <link>http://www.debianplanet.org/node.php?id=969</link>\n <description>Debian has some really cool tools for managing the process of compiling and packaging custom kernels, but a lot of Debian users still do things the traditional way.  The current issue of &lt;a href=&quot;http://www.linmagau.org/&quot;&gt;linmagau&lt;/a&gt;, the Australian Linux magazine, is &lt;a href=&quot;http://www.linmagau.org/modules.php?op=modload&amp;name=Sections&amp;file=index&amp;req=viewarticle&amp;artid=158&quot;&gt;carrying an article&lt;/a&gt; that walks step by step through getting kernel source and configuring, then compiling and building a custom kernel package that can be installed using dpkg just like any other package.</description>\n</item>\n<item>\n <title>GNU/FreeBSD progress</title>\n <link>http://www.debianplanet.org/node.php?id=968</link>\n <description>The Debian GNU/FreeBSD port has recently made significant progress using the &lt;a href=&quot;http://www.gnu.org/software/glibc/&quot;&gt;GNU C library&lt;/a&gt; as a base instead of FreeBSD\'s libc. The result has been a great improvement in portability, which allowed a single developer to bootstrap Debian to the point of having a &lt;a href=&quot;http://lists.debian.org/debian-bsd/2003/debian-bsd-200306/msg00001.html&quot;&gt;working xfree86&lt;/a&gt; package in matter of a few weeks. There\'s currently a base &lt;a href=&quot;http://people.debian.org/~rmh/gnu-freebsd/pub/&quot;&gt;GNU/FreeBSD tarball&lt;/a&gt; that can be installed as a standalone system, an &lt;a href=&quot;http://lists.debian.org/debian-bsd/2003/debian-bsd-200306/msg00004.html&quot;&gt;APT repository&lt;/a&gt; and a &lt;a href=&quot;http://www.debian.org/ports/freebsd/gnu-libc-based&quot;&gt;website summarizing the current status of the port&lt;/a&gt;.</description>\n</item>\n<item>\n <title>X broken in unstable (GCC 3.3 fun)</title>\n <link>http://www.debianplanet.org/node.php?id=966</link>\n <description>If you are tracking unstable, you might want to postpone the upgrade of X packages.  Version 4.2.1-7 breaks XDM, KDM (GDM2 works fine for me) and startx in due to some problems with GCC 3.3 compiling code related to X authorization cookies. See &lt;a href=&quot;http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=196575&quot;&gt;bug #196575&lt;/a&gt; for details. Filing further bugs is not necessary, Branden (X maintainer) is painfully aware of the problem.\n\n&lt;b&gt;DanielS&lt;/b&gt;: 4.2.1-8 was uploaded last night (my time), should start hitting the mirrors any time now.</description>\n</item>\n<item>\n <title>Bonzai Linux releases version 1.7</title>\n <link>http://www.debianplanet.org/node.php?id=965</link>\n <description>Bonzia Linux, the Debian based distribution that fits on a 180MB CD-R(W) and features KDE 3.1.2, has been updated to version 1.7 as of June 5th, 2003.  You can download an ISO at &lt;a href=&quot;http://developer.berlios.de/projects/bonzai/&quot;&gt;http://developer.berlios.de/projects/bonzai/&lt;/a&gt;.</description>\n</item>\n<item>\n <title>Exim+Courier+Debian HOWTO</title>\n <link>http://www.debianplanet.org/node.php?id=962</link>\n <description>Jason Boxman has posted a &lt;a href=&quot;http://talk.trekweb.com/~jasonb/articles/exim_maildir_imap.shtml&quot;&gt;Exim+Courier+Debian HOWTO&lt;/a&gt; on his site, that describes in some depth how to set up a working system with Exim, Courier IMAP, and Maildirs, as well as covering topics like mail filtering, and MUA setup.</description>\n</item>\n</channel>\n</rss>\n');





CREATE TABLE tiki_search_stats (
"term" varchar(50) NOT NULL default '',
"hits" integer NOT NULL default '0',
PRIMARY KEY ("term")
) ;






INSERT INTO tiki_search_stats VALUES ('jobhunting',32);
INSERT INTO tiki_search_stats VALUES ('test\'',6);
INSERT INTO tiki_search_stats VALUES ('test',124);
INSERT INTO tiki_search_stats VALUES ('blog',1);
INSERT INTO tiki_search_stats VALUES ('the',2);
INSERT INTO tiki_search_stats VALUES ('tide',42);
INSERT INTO tiki_search_stats VALUES ('job',11);
INSERT INTO tiki_search_stats VALUES ('',13);
INSERT INTO tiki_search_stats VALUES ('help',1);
INSERT INTO tiki_search_stats VALUES ('damn',2);
INSERT INTO tiki_search_stats VALUES ('search',1);
INSERT INTO tiki_search_stats VALUES ('OK',1);
INSERT INTO tiki_search_stats VALUES ('stem',3);
INSERT INTO tiki_search_stats VALUES ('test2',1);
INSERT INTO tiki_search_stats VALUES ('table',1);
INSERT INTO tiki_search_stats VALUES ('text',1);
INSERT INTO tiki_search_stats VALUES ('hunting',2);





CREATE TABLE tiki_semaphores (
"semName" varchar(30) NOT NULL default '',
"timestamp" integer NOT NULL default '0',
"user" varchar(200) NOT NULL default '',
PRIMARY KEY ("semName")
) ;











CREATE TABLE tiki_sent_newsletters (
"editionId" integer NOT NULL default nextval('tiki_sent_newsletters_seq') unique not null,
"nlId" integer NOT NULL default '0',
"users" integer NOT NULL default '0',
"sent" integer NOT NULL default '0',
"subject" varchar(200) NOT NULL default '',
"data" text,
PRIMARY KEY ("editionId")
) ;











CREATE TABLE tiki_sessions (
"sessionId" varchar(32) NOT NULL default '',
"timestamp" integer NOT NULL default '0',
"user" varchar(200) NOT NULL default '',
PRIMARY KEY ("sessionId")
) ;






INSERT INTO tiki_sessions VALUES ('b25d0d0fc59003b7620bef86facf4963',1058295027,'ross');





CREATE TABLE tiki_shoutbox (
"msgId" integer NOT NULL default nextval('tiki_shoutbox_seq') unique not null,
"message" varchar(255) NOT NULL default '',
"timestamp" integer NOT NULL default '0',
"user" varchar(200) NOT NULL default '',
"hash" varchar(32) NOT NULL default '',
PRIMARY KEY ("msgId")
) ;






INSERT INTO tiki_shoutbox VALUES (11,'11:05PST',1045076860,'ross','039d946c6361a9fe4015ebcc29d71a6b');





CREATE TABLE tiki_structures (
"page" varchar(240) NOT NULL default '',
"parent" varchar(240) NOT NULL default '',
"pos" integer NOT NULL default '0',
PRIMARY KEY ("parent","page")
) ;











CREATE TABLE tiki_submissions (
"subId" integer NOT NULL default nextval('tiki_submissions_seq') unique not null,
"title" varchar(80) NOT NULL default '',
"authorName" varchar(60) NOT NULL default '',
"topicId" integer NOT NULL default '0',
"topicName" varchar(40) NOT NULL default '',
"size" integer NOT NULL default '0',
"useImage" varchar(1) NOT NULL default '',
"image_name" varchar(80) NOT NULL default '',
"image_type" varchar(80) NOT NULL default '',
"image_size" integer NOT NULL default '0',
"image_x" integer NOT NULL default '0',
"image_y" integer NOT NULL default '0',
"image_data" text,
"publishDate" integer NOT NULL default '0',
"created" integer NOT NULL default '0',
"heading" text NOT NULL,
"body" text,
"hash" varchar(32) NOT NULL default '',
"author" varchar(200) NOT NULL default '',
"reads" integer NOT NULL default '0',
"votes" integer NOT NULL default '0',
"points" integer NOT NULL default '0',
"type" varchar(50) NOT NULL default '',
"rating" decimal(4,2) NOT NULL default '0.00',
"isfloat" varchar(1) NOT NULL default '',
PRIMARY KEY ("subId")
) ;






INSERT INTO tiki_submissions VALUES (1,'test','test',1,'A Test Topic',36,'n','','',0,0,0,'',1045228020,1045069773,'test','publish date: 05:07 NZST (09:07 PST)','1fb0e331c05a52d5eb847d6fc018320d','ross',0,0,0,'Article',7.00,'n');
INSERT INTO tiki_submissions VALUES (2,'TEST','',1,'A Test Topic',4,'n','','',0,0,0,'',1045213740,1045069809,'TEST','TEST','67a2949e8d29cd4c7f572144e46a1b85','ross',0,0,0,'Article',7.00,'n');
INSERT INTO tiki_submissions VALUES (3,'test','test',1,'A Test Topic',10,'n','','',0,0,0,'',1045142160,1045070249,'test','05:16 NZST','3832e1825d1bbdf709bde7917b2c10e0','ross',0,0,0,'Article',7.00,'n');
INSERT INTO tiki_submissions VALUES (4,'TEST','TEST',1,'A Test Topic',10,'n','','',0,0,0,'',1045142280,1045070341,'TEST','05:18 nzst','464f3675e27c061dfd790c25e1e2442d','ross',0,0,0,'Article',7.00,'n');
INSERT INTO tiki_submissions VALUES (5,'test','test',1,'A Test Topic',21,'n','','',0,0,0,'',1044900360,1045076069,'etst','10:06 pst (6:06 nzst)','7afcdbf2aec78e0fa3cef752baf6589c','ross',0,0,0,'Article',7.00,'n');





CREATE TABLE tiki_suggested_faq_questions (
"sfqId" integer NOT NULL default nextval('tiki_suggested_faq_question_seq') unique not null,
"faqId" integer NOT NULL default '0',
"question" text NOT NULL,
"answer" text NOT NULL,
"created" integer NOT NULL default '0',
"user" varchar(200) NOT NULL default '',
PRIMARY KEY ("sfqId")
) ;











CREATE TABLE tiki_survey_question_options (
"optionId" integer NOT NULL default nextval('tiki_survey_question_option_seq') unique not null,
"questionId" integer NOT NULL default '0',
"qoption" text NOT NULL,
"votes" integer NOT NULL default '0',
PRIMARY KEY ("optionId")
) ;











CREATE TABLE tiki_survey_questions (
"questionId" integer NOT NULL default nextval('tiki_survey_questions_seq') unique not null,
"surveyId" integer NOT NULL default '0',
"question" text NOT NULL,
"options" text NOT NULL,
"type" varchar(1) NOT NULL default '',
"position" integer NOT NULL default '0',
"votes" integer NOT NULL default '0',
"value" integer NOT NULL default '0',
"average" decimal(4,2) NOT NULL default '0.00',
PRIMARY KEY ("questionId")
) ;











CREATE TABLE tiki_surveys (
"surveyId" integer NOT NULL default nextval('tiki_surveys_seq') unique not null,
"name" varchar(200) NOT NULL default '',
"description" text NOT NULL,
"taken" integer NOT NULL default '0',
"lastTaken" integer NOT NULL default '0',
"created" integer NOT NULL default '0',
"status" varchar(1) NOT NULL default '',
PRIMARY KEY ("surveyId")
) ;











CREATE TABLE tiki_tags (
"tagName" varchar(80) NOT NULL default '',
"pageName" varchar(160) NOT NULL default '',
"hits" integer NOT NULL default '0',
"data" text,
"lastModif" integer NOT NULL default '0',
"comment" varchar(200) NOT NULL default '',
"version" integer NOT NULL default '0',
"user" varchar(200) NOT NULL default '',
"ip" varchar(15) NOT NULL default '',
"flag" varchar(1) NOT NULL default '',
"description" varchar(200) NOT NULL default '',
PRIMARY KEY ("pageName","tagName")
) ;






INSERT INTO tiki_tags VALUES ('test','HomePage',740,'[http://tikiwiki.sf.net/|tiki]',1045231844,'',31,'ross','192.168.1.2','','');
INSERT INTO tiki_tags VALUES ('test','JobHunting',12,'[http://losangeles.craigslist.org/eng/] - while this site looks good, I\'ve submitted several resumes and have received 0 replies.  Probably just spammers harvesting email addresses....',1039947473,'',2,'ross','192.168.1.2','','');
INSERT INTO tiki_tags VALUES ('test','NoHTMLCodeIsNeeded',2,'This is another page ((AWordWithCapitals))',1038794163,'',1,'ross','192.168.1.2','','');
INSERT INTO tiki_tags VALUES ('test','AWordWithCapitals',1,'Another Page\r\n\r\n((HomePage))',1038794197,'',1,'ross','192.168.1.2','','');
INSERT INTO tiki_tags VALUES ('test','LisasPage',1,'\r\nPer Lisa\'s request, here are the definitions from Monier-Williams\' Sanskrit-English Dictionary for ha, Tha, and haTha I found using the search engine:\r\n\r\n[http://www.uni-koeln.de/phil-fak/indologie/tamil/mwd_search.html]\r\n\r\n* ha\r\n \r\nMeaning  1 the thirty-third and last consonant of the Na1gari1 alphabet (in Pa1n2ini\'s system belonging to the guttural class , and usually pronounced like the English %{h} in %{hard} ; it is not an original letter , but is mostly derived from an older %{gh} , rarely from %{dh} or %{bh}).\r\n\r\nMeaning  2 (only L.) m. a form of S3iva or Bhairava (cf. %{nakulI7za}) ; water ; a cipher (i.e. the arithmetical figure which symbolizes o) ; meditation , auspiciousness ; sky , heaven , paradise ; blood ; dying ; fear ; knowledge ; the moon ; Vishn2u ; war , battle ; horripilation ; a horse ; pride ; a physician ; cause , motive ; = %{pApa-haraNa} ; = %{sakopa-vAraNa} ; = %{zuSka} ; (also %{A} f.) laughter ; (%{A}) f. coition ; a lute (%{am}) n. the Supreme Spirit ; pleasure , delight ; a weapon ; the sparkling of a gem ; calling , calling to the sound of a lute ; (ind.) = %{aham} (?) , IndSt. ; mfn. mad , drunk. \r\n \r\nMeaning  3 ind. (prob. orig. identical with 2. %{gha} , and used as a particle for emphasizing a preceding word , esp. if it begins a sentence closely connected with another ; very frequent in the Bra1hman2as and Su1tras , and often translatable by) indeed , assuredly , verily , of course , then &c. (often with other particles e.g. with %{tv@eva} , %{u} , %{sma} , %{vai} &c. ; %{na@ha} , `\" not indeed \"\' ; also with interrogatives and relatives e.g. %{yad@dha} , `\" when indeed \"\' ; %{kad@dha} , `\" what then? \"\' sometimes with impf. or pf. [cf. Pa1n2. 3-2 , 116] ; in later language very commonly used as a mere expletive , esp. at the end of a verse) RV. &c. &c. \r\n\r\nMeaning  4 mf(%{A})n. (fr. %{han}) killing , destroying , removing (only ifc. ; see %{arAti-} , %{vRtra-} , %{zatruha} &c.) \r\n\r\nMeaning  5 mf(%{A})n. (fr. 3. %{hA}) abandoning , deserting , avoiding (ifc. ; see %{an-oka-} and %{vApI-ha}) ; (%{A}) f. abandonment , desertion L. \r\n\r\n* Tha\r\n \r\nMeaning  1 the aspirate of the preceding consonant.\r\n\r\nMeaning  2 m. a loud noise (%{ThaThaM@ThaThaM@ThaM@ThaThaThaM@ThaThaM@ThaH} , an imitative sound as of a golden pitcher rolling down steps Maha1n.2 iii , 5) L. ; the moon\'s disk L. ; a disk L. ; a cypher L. ; a place frequented by all L. ; S3iva L. \r\n\r\n* haTha\r\n \r\nMeaning  m. violence , force (ibc. , %{ena} , and %{At} , `\" by force , forcibly \"\') R. Ra1jat. Katha1s. &c. ; obstinacy , pertinacity (ibc. and %{At} , `\" obstinately , persistently \"\') Pan5cat. Katha1s. ; absolute or inevitable necessity (as the cause of all existence and activity ; ibc. , %{At} , and %{ena} , `\" necessarily , inevitably , by all means \"\') MBh. Ka1v. &c. ; = %{haTha-yoga} Cat. ; oppression W. ; rapine ib. ; going in the rear of an enemy L. ; Pistia Stratiotes L. \r\n\r\n* haTha-yoga\r\n\r\nMeaning m. a kind of forced Yoga or abstract meditation (forcing the mind to withdraw from external objects; treated of in the HaTha-pradIpikA by SvAtmArAma and performed with much self-torture, such as standing on one leg, holding up the arms, inhaling smoke with the head inverted &c.)\r\n\r\n',1038940749,'',1,'ross','192.168.1.2','','');
INSERT INTO tiki_tags VALUES ('test','NewPage',1,'Adding an entry to test the full text search function.\r\n\r\nHere are some search terms:\r\n\r\nJobHunting\r\ntest\r\ntiki\r\n\r\nNextPage',1040866218,'',1,'ross','192.168.1.2','','');
INSERT INTO tiki_tags VALUES ('test','NextPage',1,'Adding an entry to test the full text search function.\r\n\r\nHere are some search terms:\r\n\r\nJobHunting\r\ntest\r\ntiki\r\n',1040866230,'',1,'ross','192.168.1.2','','');





CREATE TABLE tiki_theme_control_categs (
"categId" integer NOT NULL default '0',
"theme" varchar(250) NOT NULL default '',
PRIMARY KEY ("categId")
) ;











CREATE TABLE tiki_theme_control_objects (
"objId" varchar(250) NOT NULL default '',
"type" varchar(250) NOT NULL default '',
"name" varchar(250) NOT NULL default '',
"theme" varchar(250) NOT NULL default '',
PRIMARY KEY ("objId")
) ;











CREATE TABLE tiki_theme_control_sections (
"section" varchar(250) NOT NULL default '',
"theme" varchar(250) NOT NULL default '',
PRIMARY KEY ("section")
) ;











CREATE TABLE tiki_topics (
"topicId" integer NOT NULL default nextval('tiki_topics_seq') unique not null,
"name" varchar(40) NOT NULL default '',
"image_name" varchar(80) NOT NULL default '',
"image_type" varchar(80) NOT NULL default '',
"image_size" integer NOT NULL default '0',
"image_data" text,
"active" varchar(1) NOT NULL default '',
"created" integer NOT NULL default '0',
PRIMARY KEY ("topicId")
) ;






INSERT INTO tiki_topics VALUES (1,'A Test Topic','php.gif','image/gif',1160,'GIF89af\0/\0�\0\0\0\0\0������\0333\0333333f3fff3�ff�3f�ff�f3ff�̙��f��fff��f���f33���33\03\0\03f3ff333�������������������,\0\0\0\0f\0/\0\0�  �di�h��l�p,�tm�x��8�L eA��Lƀ̡�-\Zi>dmY�\Z�ðvK��`t-��~��)��+�s*X�X�x|RiovO�d{{l�]?��yqt^U9��1�<�����.�������%�������*�	\n	�����\n˱��Щ�����	��õ���)���\n��������������	\r\r�����\0��g����E\0�_�a�A<AD�e��1A�g\nWA?� _D����=� b��t���4��@�T(8؇�?�l�p;u��)�u�T�|�5x��A����?��cULM\0p?���*�մd�0�E����	��[\0�������ymO@�\0U+�q~� ��?\'\r$FqcJ�F@\r���,�-T5@ѤI�gP��<��� ����� uóRHnx��)c{[?�0�98 dś=�@Ax\0�7�v�\0��	Z����6�C�k/�\0���w�&�=�L�d[u�$U_�}�WX�O^t\'?�s̀���\rb���ZfqXh#\0aQ>��E`�\0��0���O;?��u��r����?�vDDV�[;Q�?9Vg�L欴]{���Z�&Akpi�\0�\'�mYLk�P�_���Eq�U҅IQW?WB�?��B�6`�ˊ�-J�j�z�:������dڜ��U)�0~J��p�UU��1U^�3�v�C)e�A)�V?g]hX?��`\05Ĵ�[:ܬ#QR�5G�2`Q�����(`^|}��O�EkV��`�-�KM,,<p�]�F����\n��NMĪ���e���D�`���gT�	\0R�+���>��:�F\Zy��ZdH?(9$K����/�H)�V_H�qM�\"�a>%��ck!`��C�\n�mR�r2����r���>=�E��J1�rs\07\0	? Mt�XW=��B����[�?��a[=�	_O]��kgAu	_��u�j\'���n?]w�fo݈�g����Y�?6�E�\r���7�un��~DN�\nw�-���M���{>w�l?^xͨ��:*!\0\0;','y',1045068208);





CREATE TABLE tiki_tracker_fields (
"fieldId" integer NOT NULL default nextval('tiki_tracker_fields_seq') unique not null,
"trackerId" integer NOT NULL default '0',
"name" varchar(80) NOT NULL default '',
"options" text NOT NULL,
"type" varchar(1) NOT NULL default '',
"isMain" varchar(1) NOT NULL default '',
"isTblVisible" varchar(1) NOT NULL default '',
PRIMARY KEY ("fieldId")
) ;











CREATE TABLE tiki_tracker_item_attachments (
"attId" integer NOT NULL default nextval('tiki_tracker_item_attachmen_seq') unique not null,
"itemId" varchar(40) NOT NULL default '',
"filename" varchar(80) NOT NULL default '',
"filetype" varchar(80) NOT NULL default '',
"filesize" integer NOT NULL default '0',
"user" varchar(200) NOT NULL default '',
"data" text,
"path" varchar(255) NOT NULL default '',
"downloads" integer NOT NULL default '0',
"created" integer NOT NULL default '0',
"comment" varchar(250) NOT NULL default '',
PRIMARY KEY ("attId")
) ;











CREATE TABLE tiki_tracker_item_comments (
"commentId" integer NOT NULL default nextval('tiki_tracker_item_comments_seq') unique not null,
"itemId" integer NOT NULL default '0',
"user" varchar(200) NOT NULL default '',
"data" text NOT NULL,
"title" varchar(200) NOT NULL default '',
"posted" integer NOT NULL default '0',
PRIMARY KEY ("commentId")
) ;











CREATE TABLE tiki_tracker_item_fields (
"itemId" integer NOT NULL default '0',
"fieldId" integer NOT NULL default '0',
"value" text NOT NULL,
PRIMARY KEY ("fieldId","itemId")
) ;











CREATE TABLE tiki_tracker_items (
"itemId" integer NOT NULL default nextval('tiki_tracker_items_seq') unique not null,
"trackerId" integer NOT NULL default '0',
"created" integer NOT NULL default '0',
"status" varchar(1) NOT NULL default '',
"lastModif" integer NOT NULL default '0',
PRIMARY KEY ("itemId")
) ;











CREATE TABLE tiki_trackers (
"trackerId" integer NOT NULL default nextval('tiki_trackers_seq') unique not null,
"name" varchar(80) NOT NULL default '',
"description" text NOT NULL,
"created" integer NOT NULL default '0',
"lastModif" integer NOT NULL default '0',
"showCreated" varchar(1) NOT NULL default '',
"showStatus" varchar(1) NOT NULL default '',
"showLastModif" varchar(1) NOT NULL default '',
"useComments" varchar(1) NOT NULL default '',
"useAttachments" varchar(1) NOT NULL default '',
"items" integer NOT NULL default '0',
PRIMARY KEY ("trackerId")
) ;











CREATE TABLE tiki_untranslated (
"id" integer NOT NULL default nextval('tiki_untranslated_seq') unique not null,
"source" text NOT NULL,
"lang" varchar(2) NOT NULL default '',
PRIMARY KEY ("lang","source")
,UNIQUE ("id")

) ;











CREATE TABLE tiki_user_answers (
"userResultId" integer NOT NULL default '0',
"quizId" integer NOT NULL default '0',
"questionId" integer NOT NULL default '0',
"optionId" integer NOT NULL default '0',
PRIMARY KEY ("userResultId","quizId","optionId","questionId")
) ;











CREATE TABLE tiki_user_assigned_modules (
"name" varchar(200) NOT NULL default '',
"position" varchar(1) NOT NULL default '',
"ord" integer NOT NULL default '0',
"type" varchar(1) NOT NULL default '',
"title" varchar(40) NOT NULL default '',
"cache_time" integer NOT NULL default '0',
"rows" integer NOT NULL default '0',
"groups" text NOT NULL,
"user" varchar(200) NOT NULL default '',
PRIMARY KEY ("user","name")
) ;











CREATE TABLE tiki_user_bookmarks_folders (
"folderId" integer NOT NULL default nextval('tiki_user_bookmarks_folders_seq') unique not null,
"parentId" integer NOT NULL default '0',
"user" varchar(200) NOT NULL default '',
"name" varchar(30) NOT NULL default '',
PRIMARY KEY ("folderId","user")
) ;











CREATE TABLE tiki_user_bookmarks_urls (
"urlId" integer NOT NULL default nextval('tiki_user_bookmarks_urls_seq') unique not null,
"name" varchar(30) NOT NULL default '',
"url" varchar(250) NOT NULL default '',
"data" text,
"lastUpdated" integer NOT NULL default '0',
"folderId" integer NOT NULL default '0',
"user" varchar(200) NOT NULL default '',
PRIMARY KEY ("urlId")
) ;











CREATE TABLE tiki_user_mail_accounts (
"accountId" integer NOT NULL default nextval('tiki_user_mail_accounts_seq') unique not null,
"user" varchar(200) NOT NULL default '',
"account" varchar(50) NOT NULL default '',
"pop" varchar(255) NOT NULL default '',
"current" varchar(1) NOT NULL default '',
"port" integer NOT NULL default '0',
"username" varchar(100) NOT NULL default '',
"pass" varchar(100) NOT NULL default '',
"msgs" integer NOT NULL default '0',
"smtp" varchar(255) NOT NULL default '',
"useAuth" varchar(1) NOT NULL default '',
"smtpPort" integer NOT NULL default '0',
PRIMARY KEY ("accountId")
) ;






INSERT INTO tiki_user_mail_accounts VALUES (1,'ross','ross@yogamala.com','yogamala.com','y',110,'srikpj','joisrock',20,'localhost','n',25);





CREATE TABLE tiki_user_menus (
"user" varchar(200) NOT NULL default '',
"menuId" integer NOT NULL default nextval('tiki_user_menus_seq') unique not null,
"url" varchar(250) NOT NULL default '',
"name" varchar(40) NOT NULL default '',
"position" integer NOT NULL default '0',
"mode" varchar(1) NOT NULL default '',
PRIMARY KEY ("menuId")
) ;











CREATE TABLE tiki_user_modules (
"name" varchar(200) NOT NULL default '',
"title" varchar(40) NOT NULL default '',
"data" text,
PRIMARY KEY ("name")
) ;






INSERT INTO tiki_user_modules VALUES ('php.net','php.net','{rss id=1}');
INSERT INTO tiki_user_modules VALUES ('slashdot','slashdot','{rss id=2}');
INSERT INTO tiki_user_modules VALUES ('debianplanet','debianplanet','{rss id=3}');





CREATE TABLE tiki_user_notes (
"user" varchar(200) NOT NULL default '',
"noteId" integer NOT NULL default nextval('tiki_user_notes_seq') unique not null,
"created" integer NOT NULL default '0',
"name" varchar(255) NOT NULL default '',
"lastModif" integer NOT NULL default '0',
"data" text NOT NULL,
"size" integer NOT NULL default '0',
"parse_mode" varchar(20) NOT NULL default '',
PRIMARY KEY ("noteId")
) ;











CREATE TABLE tiki_user_postings (
"user" varchar(200) NOT NULL default '',
"posts" integer NOT NULL default '0',
"last" integer NOT NULL default '0',
"first" integer NOT NULL default '0',
"level" integer NOT NULL default '0',
PRIMARY KEY ("user")
) ;











CREATE TABLE tiki_user_preferences (
"user" varchar(200) NOT NULL default '',
"prefName" varchar(40) NOT NULL default '',
"value" varchar(250) NOT NULL default '',
PRIMARY KEY ("prefName","user")
) ;






INSERT INTO tiki_user_preferences VALUES ('ross','theme','subsilver.css');
INSERT INTO tiki_user_preferences VALUES ('ross','realName','Ross Smith');
INSERT INTO tiki_user_preferences VALUES ('ross','userbreadCrumb','4');
INSERT INTO tiki_user_preferences VALUES ('ross','homePage','');
INSERT INTO tiki_user_preferences VALUES ('ross','language','en');
INSERT INTO tiki_user_preferences VALUES ('display_timezone','PST','');
INSERT INTO tiki_user_preferences VALUES ('ross','display_timezone','default');
INSERT INTO tiki_user_preferences VALUES ('luis','theme','subsilver.css');
INSERT INTO tiki_user_preferences VALUES ('luis','realName','Luis');
INSERT INTO tiki_user_preferences VALUES ('luis','userbreadCrumb','4');
INSERT INTO tiki_user_preferences VALUES ('luis','homePage','');
INSERT INTO tiki_user_preferences VALUES ('luis','language','sp');
INSERT INTO tiki_user_preferences VALUES ('luis','display_timezone','AGT');
INSERT INTO tiki_user_preferences VALUES ('ross','country','United_States');
INSERT INTO tiki_user_preferences VALUES ('ross','user_information','public');





CREATE TABLE tiki_user_quizzes (
"user" varchar(100) NOT NULL default '',
"quizId" integer NOT NULL default '0',
"timestamp" integer NOT NULL default '0',
"timeTaken" integer NOT NULL default '0',
"points" integer NOT NULL default '0',
"maxPoints" integer NOT NULL default '0',
"resultId" integer NOT NULL default '0',
"userResultId" integer NOT NULL default nextval('tiki_user_quizzes_seq') unique not null,
PRIMARY KEY ("userResultId")
) ;











CREATE TABLE tiki_user_taken_quizzes (
"user" varchar(200) NOT NULL default '',
"quizId" varchar(255) NOT NULL default '',
PRIMARY KEY ("quizId","user")
) ;






INSERT INTO tiki_user_taken_quizzes VALUES ('ross','1');





CREATE TABLE tiki_user_tasks (
"user" varchar(200) NOT NULL default '',
"taskId" integer NOT NULL default nextval('tiki_user_tasks_seq') unique not null,
"title" varchar(250) NOT NULL default '',
"description" text NOT NULL,
"datetime" integer NOT NULL default '0',
"status" varchar(1) NOT NULL default '',
"priority" integer NOT NULL default '0',
"completed" integer NOT NULL default '0',
"percentage" integer NOT NULL default '0',
PRIMARY KEY ("taskId")
) ;











CREATE TABLE tiki_user_votings (
"user" varchar(200) NOT NULL default '',
"id" varchar(255) NOT NULL default '',
PRIMARY KEY ("id","user")
) ;






INSERT INTO tiki_user_votings VALUES ('ross','comment4');





CREATE TABLE tiki_user_watches (
"user" varchar(200) NOT NULL default '',
"event" varchar(40) NOT NULL default '',
"object" varchar(200) NOT NULL default '',
"hash" varchar(32) NOT NULL default '',
"title" varchar(250) NOT NULL default '',
"type" varchar(200) NOT NULL default '',
"url" varchar(250) NOT NULL default '',
"email" varchar(200) NOT NULL default '',
PRIMARY KEY ("object","event","user")
) ;











CREATE TABLE tiki_userfiles (
"user" varchar(200) NOT NULL default '',
"fileId" integer NOT NULL default nextval('tiki_userfiles_seq') unique not null,
"name" varchar(200) NOT NULL default '',
"filename" varchar(200) NOT NULL default '',
"filetype" varchar(200) NOT NULL default '',
"filesize" varchar(200) NOT NULL default '',
"data" text,
"hits" integer NOT NULL default '0',
"isFile" varchar(1) NOT NULL default '',
"path" varchar(255) NOT NULL default '',
"created" integer NOT NULL default '0',
PRIMARY KEY ("fileId")
) ;











CREATE TABLE tiki_userpoints (
"user" varchar(200) NOT NULL default '',
"points" decimal(8,2) NOT NULL default '0.00',
"voted" integer NOT NULL default '0'
) ;











CREATE TABLE tiki_users (
"user" varchar(200) NOT NULL default '',
"password" varchar(40) NOT NULL default '',
"email" varchar(200) NOT NULL default '',
"lastLogin" integer NOT NULL default '0',
PRIMARY KEY ("user")
) ;











CREATE TABLE tiki_webmail_contacts (
"contactId" integer NOT NULL default nextval('tiki_webmail_contacts_seq') unique not null,
"firstName" varchar(80) NOT NULL default '',
"lastName" varchar(80) NOT NULL default '',
"email" varchar(250) NOT NULL default '',
"nickname" varchar(200) NOT NULL default '',
"user" varchar(200) NOT NULL default '',
PRIMARY KEY ("contactId")
) ;











CREATE TABLE tiki_webmail_messages (
"accountId" integer NOT NULL default '0',
"mailId" varchar(255) NOT NULL default '',
"user" varchar(200) NOT NULL default '',
"isRead" varchar(1) NOT NULL default '',
"isReplied" varchar(1) NOT NULL default '',
"isFlagged" varchar(1) NOT NULL default '',
PRIMARY KEY ("mailId","accountId")
) ;











CREATE TABLE tiki_wiki_attachments (
"attId" integer NOT NULL default nextval('tiki_wiki_attachments_seq') unique not null,
"page" varchar(40) NOT NULL default '',
"filename" varchar(80) NOT NULL default '',
"filetype" varchar(80) NOT NULL default '',
"filesize" integer NOT NULL default '0',
"user" varchar(200) NOT NULL default '',
"data" text,
"path" varchar(255) NOT NULL default '',
"downloads" integer NOT NULL default '0',
"created" integer NOT NULL default '0',
"comment" varchar(250) NOT NULL default '',
PRIMARY KEY ("attId")
) ;











CREATE TABLE tiki_zones (
"zone" varchar(40) NOT NULL default '',
PRIMARY KEY ("zone")
) ;











CREATE TABLE users_grouppermissions (
"groupName" varchar(30) NOT NULL default '',
"permName" varchar(30) NOT NULL default '',
"value" varchar(1) NOT NULL default '',
PRIMARY KEY ("permName","groupName")
) ;






INSERT INTO users_grouppermissions VALUES ('Admins','tiki_p_admin','');
INSERT INTO users_grouppermissions VALUES ('Anonymous','tiki_p_view','');
INSERT INTO users_grouppermissions VALUES ('Anonymous','tiki_p_read_blog','');
INSERT INTO users_grouppermissions VALUES ('Anonymous','tiki_p_forum_read','');
INSERT INTO users_grouppermissions VALUES ('Anonymous','tiki_p_view_faqs','');
INSERT INTO users_grouppermissions VALUES ('Anonymous','tiki_p_vote_poll','');
INSERT INTO users_grouppermissions VALUES ('Anonymous','tiki_p_read_comments','');
INSERT INTO users_grouppermissions VALUES ('Anonymous','tiki_p_view_file_gallery','');
INSERT INTO users_grouppermissions VALUES ('Anonymous','tiki_p_view_image_gallery','');
INSERT INTO users_grouppermissions VALUES ('Anonymous','tiki_p_read_article','');





CREATE TABLE users_groups (
"groupName" varchar(30) NOT NULL default '',
"groupDesc" varchar(255) NOT NULL default '',
PRIMARY KEY ("groupName")
) ;






INSERT INTO users_groups VALUES ('Anonymous','Public users not logged');
INSERT INTO users_groups VALUES ('Registered','Users logged into the system');
INSERT INTO users_groups VALUES ('Admins','');





CREATE TABLE users_objectpermissions (
"groupName" varchar(30) NOT NULL default '',
"permName" varchar(30) NOT NULL default '',
"objectType" varchar(20) NOT NULL default '',
"objectId" varchar(32) NOT NULL default '',
PRIMARY KEY ("objectId","permName","groupName")
) ;






INSERT INTO users_objectpermissions VALUES ('Anonymous','tiki_p_read_blog','blog','4fb4afc64f1d794ae904d39a1ca5ebd1');
INSERT INTO users_objectpermissions VALUES ('Registered','tiki_p_read_blog','blog','4fb4afc64f1d794ae904d39a1ca5ebd1');





CREATE TABLE users_permissions (
"permName" varchar(30) NOT NULL default '',
"permDesc" varchar(250) NOT NULL default '',
"type" varchar(20) NOT NULL default '',
"level" varchar(80) NOT NULL default '',
PRIMARY KEY ("permName")
) ;






INSERT INTO users_permissions VALUES ('tiki_p_admin_galleries','Can admin Image Galleries','image galleries','editors');
INSERT INTO users_permissions VALUES ('tiki_p_admin_file_galleries','Can admin file galleries','file galleries','editors');
INSERT INTO users_permissions VALUES ('tiki_p_create_file_galleries','Can create file galleries','file galleries','editors');
INSERT INTO users_permissions VALUES ('tiki_p_upload_files','Can upload files','file galleries','registered');
INSERT INTO users_permissions VALUES ('tiki_p_download_files','Can download files','file galleries','basic');
INSERT INTO users_permissions VALUES ('tiki_p_post_comments','Can post new comments','comments','basic');
INSERT INTO users_permissions VALUES ('tiki_p_read_comments','Can read comments','comments','basic');
INSERT INTO users_permissions VALUES ('tiki_p_remove_comments','Can delete comments','comments','editors');
INSERT INTO users_permissions VALUES ('tiki_p_vote_comments','Can vote comments','comments','registered');
INSERT INTO users_permissions VALUES ('tiki_p_admin','Administrator, can manage users groups and permissions and all the weblog features','tiki','admin');
INSERT INTO users_permissions VALUES ('tiki_p_edit','Can edit pages','wiki','basic');
INSERT INTO users_permissions VALUES ('tiki_p_view','Can view page/pages','wiki','basic');
INSERT INTO users_permissions VALUES ('tiki_p_remove','Can remove','wiki','editors');
INSERT INTO users_permissions VALUES ('tiki_p_rollback','Can rollback pages','wiki','registered');
INSERT INTO users_permissions VALUES ('tiki_p_create_galleries','Can create image galleries','image galleries','editors');
INSERT INTO users_permissions VALUES ('tiki_p_upload_images','Can upload images','image galleries','registered');
INSERT INTO users_permissions VALUES ('tiki_p_use_HTML','Can use HTML in pages','tiki','editors');
INSERT INTO users_permissions VALUES ('tiki_p_create_blogs','Can create a blog','blogs','editors');
INSERT INTO users_permissions VALUES ('tiki_p_blog_post','Can post to a blog','blogs','registered');
INSERT INTO users_permissions VALUES ('tiki_p_blog_admin','Can admin blogs','blogs','editors');
INSERT INTO users_permissions VALUES ('tiki_p_edit_article','Can edit articles','cms','editors');
INSERT INTO users_permissions VALUES ('tiki_p_remove_article','Can remove articles','cms','editors');
INSERT INTO users_permissions VALUES ('tiki_p_read_article','Can read articles','cms','basic');
INSERT INTO users_permissions VALUES ('tiki_p_submit_article','Can submit articles','cms','basic');
INSERT INTO users_permissions VALUES ('tiki_p_edit_submission','Can edit submissions','cms','editors');
INSERT INTO users_permissions VALUES ('tiki_p_remove_submission','Can remove submissions','cms','editors');
INSERT INTO users_permissions VALUES ('tiki_p_approve_submission','Can approve submissions','cms','editors');
INSERT INTO users_permissions VALUES ('tiki_p_edit_templates','Can edit site templates','tiki','admin');
INSERT INTO users_permissions VALUES ('tiki_p_admin_dynamic','Can admin the dynamic content system','tiki','editors');
INSERT INTO users_permissions VALUES ('tiki_p_admin_banners','Administrator, can admin banners','tiki','admin');
INSERT INTO users_permissions VALUES ('tiki_p_admin_wiki','Can admin the wiki','wiki','editors');
INSERT INTO users_permissions VALUES ('tiki_p_admin_cms','Can admin the cms','cms','editors');
INSERT INTO users_permissions VALUES ('tiki_p_admin_categories','Can admin categories','tiki','editors');
INSERT INTO users_permissions VALUES ('tiki_p_send_pages','Can send pages to other sites','comm','registered');
INSERT INTO users_permissions VALUES ('tiki_p_sendme_pages','Can send pages to this site','comm','registered');
INSERT INTO users_permissions VALUES ('tiki_p_admin_received_pages','Can admin received pages','comm','editors');
INSERT INTO users_permissions VALUES ('tiki_p_admin_forum','Can admin forums','forums','editors');
INSERT INTO users_permissions VALUES ('tiki_p_forum_post','Can post in forums','forums','basic');
INSERT INTO users_permissions VALUES ('tiki_p_forum_post_topic','Can start threads in forums','forums','basic');
INSERT INTO users_permissions VALUES ('tiki_p_forum_read','Can read forums','forums','basic');
INSERT INTO users_permissions VALUES ('tiki_p_forum_vote','Can vote comments in forums','forums','registered');
INSERT INTO users_permissions VALUES ('tiki_p_read_blog','Can read blogs','blogs','basic');
INSERT INTO users_permissions VALUES ('tiki_p_view_image_gallery','Can view image galleries','image galleries','basic');
INSERT INTO users_permissions VALUES ('tiki_p_view_file_gallery','Can view file galleries','file galleries','basic');
INSERT INTO users_permissions VALUES ('tiki_p_edit_comments','Can edit all comments','comments','editors');
INSERT INTO users_permissions VALUES ('tiki_p_vote_poll','Can vote polls','tiki','basic');
INSERT INTO users_permissions VALUES ('tiki_p_admin_chat','Administrator, can create channels remove channels etc','chat','editors');
INSERT INTO users_permissions VALUES ('tiki_p_chat','Can use the chat system','chat','basic');
INSERT INTO users_permissions VALUES ('tiki_p_topic_read','Can read a topic (Applies only to individual topic perms)','topics','basic');
INSERT INTO users_permissions VALUES ('tiki_p_play_games','Can play games','games','basic');
INSERT INTO users_permissions VALUES ('tiki_p_admin_games','Can admin games','games','editors');
INSERT INTO users_permissions VALUES ('tiki_p_edit_cookies','Can admin cookies','tiki','editors');
INSERT INTO users_permissions VALUES ('tiki_p_view_stats','Can view site stats','tiki','basic');
INSERT INTO users_permissions VALUES ('tiki_p_create_bookmarks','Can create user bookmarksche user bookmarks','user','registered');
INSERT INTO users_permissions VALUES ('tiki_p_configure_modules','Can configure modules','user','registered');
INSERT INTO users_permissions VALUES ('tiki_p_cache_bookmarks','Can cache user bookmarks','user','registered');
INSERT INTO users_permissions VALUES ('tiki_p_admin_faqs','Can admin faqs','faqs','editors');
INSERT INTO users_permissions VALUES ('tiki_p_view_faqs','Can view faqs','faqs','basic');
INSERT INTO users_permissions VALUES ('tiki_p_send_articles','Can send articles to other sites','comm','editors');
INSERT INTO users_permissions VALUES ('tiki_p_sendme_articles','Can send articles to this site','comm','registered');
INSERT INTO users_permissions VALUES ('tiki_p_admin_received_articles','Can admin received articles','comm','editors');
INSERT INTO users_permissions VALUES ('tiki_p_view_shoutbox','Can view shoutbox','shoutbox','basic');
INSERT INTO users_permissions VALUES ('tiki_p_admin_shoutbox','Can admin shoutbox (Edit/remove msgs)','shoutbox','editors');
INSERT INTO users_permissions VALUES ('tiki_p_post_shoutbox','Can pot messages in shoutbox','shoutbox','basic');
INSERT INTO users_permissions VALUES ('tiki_p_suggest_faq','Can suggest faq questions','faqs','basic');
INSERT INTO users_permissions VALUES ('tiki_p_edit_content_templates','Can edit content templates','content templates','editors');
INSERT INTO users_permissions VALUES ('tiki_p_use_content_templates','Can use content templates','content templates','editors');
INSERT INTO users_permissions VALUES ('tiki_p_admin_quizzes','Can admin quizzes','quizzes','editors');
INSERT INTO users_permissions VALUES ('tiki_p_take_quiz','Can take quizzes','quizzes','basic');
INSERT INTO users_permissions VALUES ('tiki_p_view_quiz_stats','Can view quiz stats','quizzes','basic');
INSERT INTO users_permissions VALUES ('tiki_p_view_user_results','Can view user quiz results','quizzes','editors');
INSERT INTO users_permissions VALUES ('tiki_p_view_referer_stats','Can view referer stats','tiki','editors');
INSERT INTO users_permissions VALUES ('tiki_p_wiki_attach_files','Can attach files to wiki pages','wiki','basic');
INSERT INTO users_permissions VALUES ('tiki_p_wiki_admin_attachments','Can admin attachments to wiki pages','wiki','editors');
INSERT INTO users_permissions VALUES ('tiki_p_wiki_view_attachments','Can view wiki attachments and download','wiki','basic');
INSERT INTO users_permissions VALUES ('tiki_p_batch_upload_images','Can upload zip files with images','image galleries','editors');
INSERT INTO users_permissions VALUES ('tiki_p_admin_drawings','Can admin drawings','drawings','editors');
INSERT INTO users_permissions VALUES ('tiki_p_edit_drawings','Can edit drawings','drawings','basic');
INSERT INTO users_permissions VALUES ('tiki_p_view_html_pages','Can view HTML pages','html pages','basic');
INSERT INTO users_permissions VALUES ('tiki_p_edit_html_pages','Can edit HTML pages','html pages','editors');
INSERT INTO users_permissions VALUES ('tiki_p_modify_tracker_items','Can change tracker items','trackers','registered');
INSERT INTO users_permissions VALUES ('tiki_p_comment_tracker_items','Can insert comments for tracker items','trackers','basic');
INSERT INTO users_permissions VALUES ('tiki_p_create_tracker_items','Can create new items for trackers','trackers','registered');
INSERT INTO users_permissions VALUES ('tiki_p_admin_trackers','Can admin trackers','trackers','editors');
INSERT INTO users_permissions VALUES ('tiki_p_view_trackers','Can view trackers','trackers','basic');
INSERT INTO users_permissions VALUES ('tiki_p_attach_trackers','Can attach files to tracker items','trackers','registered');
INSERT INTO users_permissions VALUES ('tiki_p_use_webmail','Can use webmail','webmail','registered');
INSERT INTO users_permissions VALUES ('tiki_p_admin_surveys','Can admin surveys','surveys','editors');
INSERT INTO users_permissions VALUES ('tiki_p_take_survey','Can take surveys','surveys','basic');
INSERT INTO users_permissions VALUES ('tiki_p_view_survey_stats','Can view survey stats','surveys','basic');
INSERT INTO users_permissions VALUES ('tiki_p_admin_newsletters','Can admin newsletters','newsletters','editors');
INSERT INTO users_permissions VALUES ('tiki_p_subscribe_newsletters','Can subscribe to newsletters','newsletters','basic');
INSERT INTO users_permissions VALUES ('tiki_p_subscribe_email_newslet','Can subscribe any email to newsletters','newsletters','');
INSERT INTO users_permissions VALUES ('tiki_p_subscribe_email','Can subscribe any email to newsletters','newsletters','editors');
INSERT INTO users_permissions VALUES ('tiki_p_upload_picture','Can upload pictures to wiki pages','wiki','basic');
INSERT INTO users_permissions VALUES ('tiki_p_batch_upload_files','Can upload zip files with files','file galleries','editors');
INSERT INTO users_permissions VALUES ('tiki_p_admin_directory','Can admin the directory','directory','editors');
INSERT INTO users_permissions VALUES ('tiki_p_admin_directory_cats','Can admin directory categories','directory','editors');
INSERT INTO users_permissions VALUES ('tiki_p_admin_directory_sites','Can admin directory sites','directory','editors');
INSERT INTO users_permissions VALUES ('tiki_p_submit_link','Can submit sites to the directory','directory','basic');
INSERT INTO users_permissions VALUES ('tiki_p_autosubmit_link','Submited links are valid','directory','editors');
INSERT INTO users_permissions VALUES ('tiki_p_validate_links','Can validate submited links','directory','editors');
INSERT INTO users_permissions VALUES ('tiki_p_messages','Can use the messaging system','messu','registered');
INSERT INTO users_permissions VALUES ('tiki_p_broadcast','Can boradcast messages','messu','admin');
INSERT INTO users_permissions VALUES ('tiki_p_admin_mailin','Can admin mail-in accounts','tiki','admin');
INSERT INTO users_permissions VALUES ('tiki_p_edit_structures','Can create and edit structures','wiki','editors');
INSERT INTO users_permissions VALUES ('tiki_p_view_directory','Can use the directory','directory','basic');
INSERT INTO users_permissions VALUES ('tiki_p_minor','Can save as minor edit','wiki','editor');
INSERT INTO users_permissions VALUES ('tiki_p_rename','Can rename pages','wiki','editor');
INSERT INTO users_permissions VALUES ('tiki_p_lock','Can lock pages','wiki','editor');
INSERT INTO users_permissions VALUES ('tiki_p_usermenu','Can create items in personal menu','user','registered');
INSERT INTO users_permissions VALUES ('tiki_p_minical','Can use the mini event calendar','user','registered');
INSERT INTO users_permissions VALUES ('tiki_p_eph_admin','Can admin ephemerides','tiki','editor');
INSERT INTO users_permissions VALUES ('tiki_p_userfiles','Can upload personal files','user','registered');
INSERT INTO users_permissions VALUES ('tiki_p_tasks','Can use tasks','user','registered');
INSERT INTO users_permissions VALUES ('tiki_p_notepad','Can use the notepad','user','registered');
INSERT INTO users_permissions VALUES ('tiki_p_newsreader','Can use the newsreader','user','registered');
INSERT INTO users_permissions VALUES ('tiki_p_broadcast_all','Can broadcast messages to all user','messu','admin');
INSERT INTO users_permissions VALUES ('tiki_p_edit_languages','Can edit translations and create new languages','tiki','');
INSERT INTO users_permissions VALUES ('tiki_p_admin_workflow','Can admin workflow processes','workflow','admin');
INSERT INTO users_permissions VALUES ('tiki_p_abort_instance','Can abort a process instance','workflow','editor');
INSERT INTO users_permissions VALUES ('tiki_p_use_workflow','Can execute workflow activities','workflow','registered');
INSERT INTO users_permissions VALUES ('tiki_p_exception_instance','Can declare an instance as exception','workflow','registered');
INSERT INTO users_permissions VALUES ('tiki_p_send_instance','Can send instances after completion','workflow','registered');
INSERT INTO users_permissions VALUES ('tiki_p_admin_charts','Can admin charts','charts','admin');
INSERT INTO users_permissions VALUES ('tiki_p_view_chart','Can view charts','charts','basic');
INSERT INTO users_permissions VALUES ('tiki_p_vote_chart','Can vote','charts','basic');
INSERT INTO users_permissions VALUES ('tiki_p_suggest_chart_item','Can suggest items','charts','basic');
INSERT INTO users_permissions VALUES ('tiki_p_autoval_chart_suggestio','Autovalidate suggestions','charts','editor');
INSERT INTO users_permissions VALUES ('tiki_p_forum_autoapp','Auto approve forum posts','forums','admin');
INSERT INTO users_permissions VALUES ('tiki_p_forums_report','Can report msgs to moderator','forums','registered');
INSERT INTO users_permissions VALUES ('tiki_p_admin_banning','Can ban users or ips','tiki','admin');
INSERT INTO users_permissions VALUES ('tiki_p_forum_attach','Can attach to forum posts','forums','editor');
INSERT INTO users_permissions VALUES ('tiki_p_live_support_admin','Admin live support system','support','admin');
INSERT INTO users_permissions VALUES ('tiki_p_live_support','Can use live support system','support','basic');
INSERT INTO users_permissions VALUES ('tiki_p_autoapprove_submission','Submited articles automatically approved','cms','editors');
INSERT INTO users_permissions VALUES ('tiki_p_edit_copyrights','Can edit copyright notices','wiki','admin');
INSERT INTO users_permissions VALUES ('tiki_p_view_calendar','Can browse the calendar','calendar','basic');
INSERT INTO users_permissions VALUES ('tiki_p_change_events','Can change events in the calendar','calendar','registered');
INSERT INTO users_permissions VALUES ('tiki_p_add_events','Can add events in the calendar','calendar','registered');
INSERT INTO users_permissions VALUES ('tiki_p_admin_calendar','Can create/admin calendars','calendar','admin');
INSERT INTO users_permissions VALUES ('tiki_p_create_css','Can create new css suffixed with -user','tiki','registered');





CREATE TABLE users_usergroups (
"userId" integer NOT NULL default '0',
"groupName" varchar(30) NOT NULL default '',
PRIMARY KEY ("userId","groupName")
) ;






INSERT INTO users_usergroups VALUES (2,'Admins');
INSERT INTO users_usergroups VALUES (2,'Registered');
INSERT INTO users_usergroups VALUES (4,'Admins');
INSERT INTO users_usergroups VALUES (4,'Registered');





CREATE TABLE users_users (
"userId" integer NOT NULL default nextval('users_users_seq') unique not null,
"email" varchar(200) NOT NULL default '',
"login" varchar(40) NOT NULL default '',
"password" varchar(30) NOT NULL default '',
"provpass" varchar(30) NOT NULL default '',
"realname" varchar(80) NOT NULL default '',
"homePage" varchar(200) NOT NULL default '',
"lastLogin" integer NOT NULL default '0',
"country" varchar(80) NOT NULL default '',
"currentLogin" integer NOT NULL default '0',
"registrationDate" integer NOT NULL default '0',
"challenge" varchar(32) NOT NULL default '',
"hash" varchar(32) NOT NULL default '',
"pass_due" integer NOT NULL default '0',
"created" integer NOT NULL default '0',
"avatarName" varchar(80) NOT NULL default '',
"avatarSize" integer NOT NULL default '0',
"avatarFileType" varchar(250) NOT NULL default '',
"avatarData" text,
"avatarLibName" varchar(200) NOT NULL default '',
"avatarType" varchar(1) NOT NULL default '',
PRIMARY KEY ("userId")
) ;






INSERT INTO users_users VALUES (2,'ross@netebb.com','ross','','','','',1058293153,'',1058293153,1044244077,'','6cea1d4154470344ce947c444b291dcc',1131293732,0,'',0,'',NULL,'','n');
INSERT INTO users_users VALUES (4,'lrargerich@fibertel.com.ar','luis','tikirocks!','','','',1041570849,'',1041570849,1041570849,'','0fbcdc61c6c7e19cb3a4fc3500f03b65',0,0,'',0,'',NULL,'','n');
INSERT INTO users_users VALUES (5,'','admin','','','System Administrator','',1044892899,'',1044892911,0,'','d41d8cd98f00b204e9800998ecf8427e',1131294299,0,'',0,'',NULL,'','n');


-- Create Indexes

CREATE INDEX tiki_articles_body ON tiki_articles ("body");
CREATE INDEX tiki_articles_heading ON tiki_articles ("heading");
CREATE INDEX tiki_articles_reads ON tiki_articles ("reads");
CREATE INDEX tiki_articles_title ON tiki_articles ("title");
CREATE INDEX tiki_blog_posts_blogId ON tiki_blog_posts ("blogId");
CREATE INDEX tiki_blog_posts_created ON tiki_blog_posts ("created");
CREATE INDEX tiki_blog_posts_data ON tiki_blog_posts ("data");
CREATE INDEX tiki_blogs_description ON tiki_blogs ("description");
CREATE INDEX tiki_blogs_hits ON tiki_blogs ("hits");
CREATE INDEX tiki_blogs_title ON tiki_blogs ("title");
CREATE INDEX tiki_calendar_categories_calendarId ON tiki_calendar_categories ("calendarId");
CREATE INDEX tiki_calendar_categories_name ON tiki_calendar_categories ("name");
CREATE INDEX tiki_calendar_items_calendarId ON tiki_calendar_items ("calendarId");
CREATE INDEX tiki_calendar_locations_calendarId ON tiki_calendar_locations ("calendarId");
CREATE INDEX tiki_calendar_locations_name ON tiki_calendar_locations ("name");
CREATE INDEX tiki_comments_data ON tiki_comments ("data");
CREATE INDEX tiki_comments_hits ON tiki_comments ("hits");
CREATE INDEX tiki_comments_object ON tiki_comments ("object");
CREATE INDEX tiki_comments_title ON tiki_comments ("title");
CREATE INDEX tiki_directory_sites_description ON tiki_directory_sites ("description");
CREATE INDEX tiki_directory_sites_name ON tiki_directory_sites ("name");
CREATE INDEX tiki_faq_questions_answer ON tiki_faq_questions ("answer");
CREATE INDEX tiki_faq_questions_faqId ON tiki_faq_questions ("faqId");
CREATE INDEX tiki_faq_questions_question ON tiki_faq_questions ("question");
CREATE INDEX tiki_faqs_description ON tiki_faqs ("description");
CREATE INDEX tiki_faqs_hits ON tiki_faqs ("hits");
CREATE INDEX tiki_faqs_title ON tiki_faqs ("title");
CREATE INDEX tiki_files_description ON tiki_files ("description");
CREATE INDEX tiki_files_downloads ON tiki_files ("downloads");
CREATE INDEX tiki_files_name ON tiki_files ("name");
CREATE INDEX tiki_galleries_description ON tiki_galleries ("description");
CREATE INDEX tiki_galleries_hits ON tiki_galleries ("hits");
CREATE INDEX tiki_galleries_name ON tiki_galleries ("name");
CREATE INDEX tiki_images_created ON tiki_images ("created");
CREATE INDEX tiki_images_description ON tiki_images ("description");
CREATE INDEX tiki_images_galleryId ON tiki_images ("galleryId");
CREATE INDEX tiki_images_hits ON tiki_images ("hits");
CREATE INDEX tiki_images_name ON tiki_images ("name");
CREATE INDEX tiki_images_user ON tiki_images ("user");
CREATE INDEX tiki_images_data_imageId ON tiki_images_data ("imageId");
CREATE INDEX tiki_images_data_type ON tiki_images_data ("type");
CREATE INDEX tiki_images_old_description ON tiki_images_old ("description");
CREATE INDEX tiki_images_old_hits ON tiki_images_old ("hits");
CREATE INDEX tiki_images_old_name ON tiki_images_old ("name");
CREATE INDEX tiki_pages_data ON tiki_pages ("data");
CREATE INDEX tiki_pages_pageName ON tiki_pages ("pageName");
CREATE INDEX tiki_pages_pageRank ON tiki_pages ("pageRank");
CREATE INDEX tiki_untranslated_id ON tiki_untranslated ("id");

-- Create Sequences

CREATE SEQUENCE galaxia_activities_seq;
CREATE SEQUENCE galaxia_instance_comments_seq;
CREATE SEQUENCE galaxia_instances_seq;
CREATE SEQUENCE galaxia_processes_seq;
CREATE SEQUENCE galaxia_roles_seq;
CREATE SEQUENCE galaxia_user_roles_seq;
CREATE SEQUENCE galaxia_workitems_seq;
CREATE SEQUENCE messu_messages_seq;
CREATE SEQUENCE tiki_articles_seq;
CREATE SEQUENCE tiki_banners_seq;
CREATE SEQUENCE tiki_banning_seq;
CREATE SEQUENCE tiki_blog_posts_seq;
CREATE SEQUENCE tiki_blog_posts_images_seq;
CREATE SEQUENCE tiki_blogs_seq;
CREATE SEQUENCE tiki_calendar_categories_seq;
CREATE SEQUENCE tiki_calendar_items_seq;
CREATE SEQUENCE tiki_calendar_locations_seq;
CREATE SEQUENCE tiki_calendars_seq;
CREATE SEQUENCE tiki_categories_seq;
CREATE SEQUENCE tiki_categorized_objects_seq;
CREATE SEQUENCE tiki_chart_items_seq;
CREATE SEQUENCE tiki_charts_seq;
CREATE SEQUENCE tiki_chat_channels_seq;
CREATE SEQUENCE tiki_chat_messages_seq;
CREATE SEQUENCE tiki_comments_seq;
CREATE SEQUENCE tiki_content_seq;
CREATE SEQUENCE tiki_content_templates_seq;
CREATE SEQUENCE tiki_cookies_seq;
CREATE SEQUENCE tiki_copyrights_seq;
CREATE SEQUENCE tiki_directory_categories_seq;
CREATE SEQUENCE tiki_directory_sites_seq;
CREATE SEQUENCE tiki_drawings_seq;
CREATE SEQUENCE tiki_dsn_seq;
CREATE SEQUENCE tiki_eph_seq;
CREATE SEQUENCE tiki_extwiki_seq;
CREATE SEQUENCE tiki_faq_questions_seq;
CREATE SEQUENCE tiki_faqs_seq;
CREATE SEQUENCE tiki_file_galleries_seq;
CREATE SEQUENCE tiki_files_seq;
CREATE SEQUENCE tiki_forum_attachments_seq;
CREATE SEQUENCE tiki_forums_seq;
CREATE SEQUENCE tiki_forums_queue_seq;
CREATE SEQUENCE tiki_galleries_seq;
CREATE SEQUENCE tiki_images_seq;
CREATE SEQUENCE tiki_images_old_seq;
CREATE SEQUENCE tiki_link_cache_seq;
CREATE SEQUENCE tiki_live_support_events_seq;
CREATE SEQUENCE tiki_live_support_message_c_seq;
CREATE SEQUENCE tiki_live_support_messages_seq;
CREATE SEQUENCE tiki_live_support_modules_seq;
CREATE SEQUENCE tiki_mailin_accounts_seq;
CREATE SEQUENCE tiki_menu_languages_seq;
CREATE SEQUENCE tiki_menu_options_seq;
CREATE SEQUENCE tiki_menus_seq;
CREATE SEQUENCE tiki_minical_events_seq;
CREATE SEQUENCE tiki_minical_topics_seq;
CREATE SEQUENCE tiki_newsletters_seq;
CREATE SEQUENCE tiki_newsreader_servers_seq;
CREATE SEQUENCE tiki_poll_options_seq;
CREATE SEQUENCE tiki_polls_seq;
CREATE SEQUENCE tiki_private_messages_seq;
CREATE SEQUENCE tiki_programmed_content_seq;
CREATE SEQUENCE tiki_quiz_question_options_seq;
CREATE SEQUENCE tiki_quiz_questions_seq;
CREATE SEQUENCE tiki_quiz_results_seq;
CREATE SEQUENCE tiki_quizzes_seq;
CREATE SEQUENCE tiki_received_articles_seq;
CREATE SEQUENCE tiki_received_pages_seq;
CREATE SEQUENCE tiki_rss_modules_seq;
CREATE SEQUENCE tiki_sent_newsletters_seq;
CREATE SEQUENCE tiki_shoutbox_seq;
CREATE SEQUENCE tiki_submissions_seq;
CREATE SEQUENCE tiki_suggested_faq_question_seq;
CREATE SEQUENCE tiki_survey_question_option_seq;
CREATE SEQUENCE tiki_survey_questions_seq;
CREATE SEQUENCE tiki_surveys_seq;
CREATE SEQUENCE tiki_topics_seq;
CREATE SEQUENCE tiki_tracker_fields_seq;
CREATE SEQUENCE tiki_tracker_item_attachmen_seq;
CREATE SEQUENCE tiki_tracker_item_comments_seq;
CREATE SEQUENCE tiki_tracker_items_seq;
CREATE SEQUENCE tiki_trackers_seq;
CREATE SEQUENCE tiki_untranslated_seq;
CREATE SEQUENCE tiki_user_bookmarks_folders_seq;
CREATE SEQUENCE tiki_user_bookmarks_urls_seq;
CREATE SEQUENCE tiki_user_mail_accounts_seq;
CREATE SEQUENCE tiki_user_menus_seq;
CREATE SEQUENCE tiki_user_notes_seq;
CREATE SEQUENCE tiki_user_quizzes_seq;
CREATE SEQUENCE tiki_user_tasks_seq;
CREATE SEQUENCE tiki_userfiles_seq;
CREATE SEQUENCE tiki_webmail_contacts_seq;
CREATE SEQUENCE tiki_wiki_attachments_seq;
CREATE SEQUENCE users_users_seq;

-- Populate Sequences

SELECT SETVAL('galaxia_activities_seq', (SELECT MAX("activityId") FROM galaxia_activities));
SELECT SETVAL('galaxia_instance_comments_seq', (SELECT MAX("cId") FROM galaxia_instance_comments));
SELECT SETVAL('galaxia_instances_seq', (SELECT MAX("instanceId") FROM galaxia_instances));
SELECT SETVAL('galaxia_processes_seq', (SELECT MAX("pId") FROM galaxia_processes));
SELECT SETVAL('galaxia_roles_seq', (SELECT MAX("roleId") FROM galaxia_roles));
SELECT SETVAL('galaxia_user_roles_seq', (SELECT MAX("roleId") FROM galaxia_user_roles));
SELECT SETVAL('galaxia_workitems_seq', (SELECT MAX("itemId") FROM galaxia_workitems));
SELECT SETVAL('messu_messages_seq', (SELECT MAX("msgId") FROM messu_messages));
SELECT SETVAL('tiki_articles_seq', (SELECT MAX("articleId") FROM tiki_articles));
SELECT SETVAL('tiki_banners_seq', (SELECT MAX("bannerId") FROM tiki_banners));
SELECT SETVAL('tiki_banning_seq', (SELECT MAX("banId") FROM tiki_banning));
SELECT SETVAL('tiki_blog_posts_seq', (SELECT MAX("postId") FROM tiki_blog_posts));
SELECT SETVAL('tiki_blog_posts_images_seq', (SELECT MAX("imgId") FROM tiki_blog_posts_images));
SELECT SETVAL('tiki_blogs_seq', (SELECT MAX("blogId") FROM tiki_blogs));
SELECT SETVAL('tiki_calendar_categories_seq', (SELECT MAX("calcatId") FROM tiki_calendar_categories));
SELECT SETVAL('tiki_calendar_items_seq', (SELECT MAX("calitemId") FROM tiki_calendar_items));
SELECT SETVAL('tiki_calendar_locations_seq', (SELECT MAX("callocId") FROM tiki_calendar_locations));
SELECT SETVAL('tiki_calendars_seq', (SELECT MAX("calendarId") FROM tiki_calendars));
SELECT SETVAL('tiki_categories_seq', (SELECT MAX("categId") FROM tiki_categories));
SELECT SETVAL('tiki_categorized_objects_seq', (SELECT MAX("catObjectId") FROM tiki_categorized_objects));
SELECT SETVAL('tiki_chart_items_seq', (SELECT MAX("itemId") FROM tiki_chart_items));
SELECT SETVAL('tiki_charts_seq', (SELECT MAX("chartId") FROM tiki_charts));
SELECT SETVAL('tiki_chat_channels_seq', (SELECT MAX("channelId") FROM tiki_chat_channels));
SELECT SETVAL('tiki_chat_messages_seq', (SELECT MAX("messageId") FROM tiki_chat_messages));
SELECT SETVAL('tiki_comments_seq', (SELECT MAX("threadId") FROM tiki_comments));
SELECT SETVAL('tiki_content_seq', (SELECT MAX("contentId") FROM tiki_content));
SELECT SETVAL('tiki_content_templates_seq', (SELECT MAX("templateId") FROM tiki_content_templates));
SELECT SETVAL('tiki_cookies_seq', (SELECT MAX("cookieId") FROM tiki_cookies));
SELECT SETVAL('tiki_copyrights_seq', (SELECT MAX("copyrightId") FROM tiki_copyrights));
SELECT SETVAL('tiki_directory_categories_seq', (SELECT MAX("categId") FROM tiki_directory_categories));
SELECT SETVAL('tiki_directory_sites_seq', (SELECT MAX("siteId") FROM tiki_directory_sites));
SELECT SETVAL('tiki_drawings_seq', (SELECT MAX("drawId") FROM tiki_drawings));
SELECT SETVAL('tiki_dsn_seq', (SELECT MAX("dsnId") FROM tiki_dsn));
SELECT SETVAL('tiki_eph_seq', (SELECT MAX("ephId") FROM tiki_eph));
SELECT SETVAL('tiki_extwiki_seq', (SELECT MAX("extwikiId") FROM tiki_extwiki));
SELECT SETVAL('tiki_faq_questions_seq', (SELECT MAX("questionId") FROM tiki_faq_questions));
SELECT SETVAL('tiki_faqs_seq', (SELECT MAX("faqId") FROM tiki_faqs));
SELECT SETVAL('tiki_file_galleries_seq', (SELECT MAX("galleryId") FROM tiki_file_galleries));
SELECT SETVAL('tiki_files_seq', (SELECT MAX("fileId") FROM tiki_files));
SELECT SETVAL('tiki_forum_attachments_seq', (SELECT MAX("attId") FROM tiki_forum_attachments));
SELECT SETVAL('tiki_forums_seq', (SELECT MAX("forumId") FROM tiki_forums));
SELECT SETVAL('tiki_forums_queue_seq', (SELECT MAX("qId") FROM tiki_forums_queue));
SELECT SETVAL('tiki_galleries_seq', (SELECT MAX("galleryId") FROM tiki_galleries));
SELECT SETVAL('tiki_images_seq', (SELECT MAX("imageId") FROM tiki_images));
SELECT SETVAL('tiki_images_old_seq', (SELECT MAX("imageId") FROM tiki_images_old));
SELECT SETVAL('tiki_link_cache_seq', (SELECT MAX("cacheId") FROM tiki_link_cache));
SELECT SETVAL('tiki_live_support_events_seq', (SELECT MAX("eventId") FROM tiki_live_support_events));
SELECT SETVAL('tiki_live_support_message_c_seq', (SELECT MAX("cId") FROM tiki_live_support_message_comments));
SELECT SETVAL('tiki_live_support_messages_seq', (SELECT MAX("msgId") FROM tiki_live_support_messages));
SELECT SETVAL('tiki_live_support_modules_seq', (SELECT MAX("modId") FROM tiki_live_support_modules));
SELECT SETVAL('tiki_mailin_accounts_seq', (SELECT MAX("accountId") FROM tiki_mailin_accounts));
SELECT SETVAL('tiki_menu_languages_seq', (SELECT MAX("menuId") FROM tiki_menu_languages));
SELECT SETVAL('tiki_menu_options_seq', (SELECT MAX("optionId") FROM tiki_menu_options));
SELECT SETVAL('tiki_menus_seq', (SELECT MAX("menuId") FROM tiki_menus));
SELECT SETVAL('tiki_minical_events_seq', (SELECT MAX("eventId") FROM tiki_minical_events));
SELECT SETVAL('tiki_minical_topics_seq', (SELECT MAX("topicId") FROM tiki_minical_topics));
SELECT SETVAL('tiki_newsletters_seq', (SELECT MAX("nlId") FROM tiki_newsletters));
SELECT SETVAL('tiki_newsreader_servers_seq', (SELECT MAX("serverId") FROM tiki_newsreader_servers));
SELECT SETVAL('tiki_poll_options_seq', (SELECT MAX("optionId") FROM tiki_poll_options));
SELECT SETVAL('tiki_polls_seq', (SELECT MAX("pollId") FROM tiki_polls));
SELECT SETVAL('tiki_private_messages_seq', (SELECT MAX("messageId") FROM tiki_private_messages));
SELECT SETVAL('tiki_programmed_content_seq', (SELECT MAX("pId") FROM tiki_programmed_content));
SELECT SETVAL('tiki_quiz_question_options_seq', (SELECT MAX("optionId") FROM tiki_quiz_question_options));
SELECT SETVAL('tiki_quiz_questions_seq', (SELECT MAX("questionId") FROM tiki_quiz_questions));
SELECT SETVAL('tiki_quiz_results_seq', (SELECT MAX("resultId") FROM tiki_quiz_results));
SELECT SETVAL('tiki_quizzes_seq', (SELECT MAX("quizId") FROM tiki_quizzes));
SELECT SETVAL('tiki_received_articles_seq', (SELECT MAX("receivedArticleId") FROM tiki_received_articles));
SELECT SETVAL('tiki_received_pages_seq', (SELECT MAX("receivedPageId") FROM tiki_received_pages));
SELECT SETVAL('tiki_rss_modules_seq', (SELECT MAX("rssId") FROM tiki_rss_modules));
SELECT SETVAL('tiki_sent_newsletters_seq', (SELECT MAX("editionId") FROM tiki_sent_newsletters));
SELECT SETVAL('tiki_shoutbox_seq', (SELECT MAX("msgId") FROM tiki_shoutbox));
SELECT SETVAL('tiki_submissions_seq', (SELECT MAX("subId") FROM tiki_submissions));
SELECT SETVAL('tiki_suggested_faq_question_seq', (SELECT MAX("sfqId") FROM tiki_suggested_faq_questions));
SELECT SETVAL('tiki_survey_question_option_seq', (SELECT MAX("optionId") FROM tiki_survey_question_options));
SELECT SETVAL('tiki_survey_questions_seq', (SELECT MAX("questionId") FROM tiki_survey_questions));
SELECT SETVAL('tiki_surveys_seq', (SELECT MAX("surveyId") FROM tiki_surveys));
SELECT SETVAL('tiki_topics_seq', (SELECT MAX("topicId") FROM tiki_topics));
SELECT SETVAL('tiki_tracker_fields_seq', (SELECT MAX("fieldId") FROM tiki_tracker_fields));
SELECT SETVAL('tiki_tracker_item_attachmen_seq', (SELECT MAX("attId") FROM tiki_tracker_item_attachments));
SELECT SETVAL('tiki_tracker_item_comments_seq', (SELECT MAX("commentId") FROM tiki_tracker_item_comments));
SELECT SETVAL('tiki_tracker_items_seq', (SELECT MAX("itemId") FROM tiki_tracker_items));
SELECT SETVAL('tiki_trackers_seq', (SELECT MAX("trackerId") FROM tiki_trackers));
SELECT SETVAL('tiki_untranslated_seq', (SELECT MAX("id") FROM tiki_untranslated));
SELECT SETVAL('tiki_user_bookmarks_folders_seq', (SELECT MAX("folderId") FROM tiki_user_bookmarks_folders));
SELECT SETVAL('tiki_user_bookmarks_urls_seq', (SELECT MAX("urlId") FROM tiki_user_bookmarks_urls));
SELECT SETVAL('tiki_user_mail_accounts_seq', (SELECT MAX("accountId") FROM tiki_user_mail_accounts));
SELECT SETVAL('tiki_user_menus_seq', (SELECT MAX("menuId") FROM tiki_user_menus));
SELECT SETVAL('tiki_user_notes_seq', (SELECT MAX("noteId") FROM tiki_user_notes));
SELECT SETVAL('tiki_user_quizzes_seq', (SELECT MAX("userResultId") FROM tiki_user_quizzes));
SELECT SETVAL('tiki_user_tasks_seq', (SELECT MAX("taskId") FROM tiki_user_tasks));
SELECT SETVAL('tiki_userfiles_seq', (SELECT MAX("fileId") FROM tiki_userfiles));
SELECT SETVAL('tiki_webmail_contacts_seq', (SELECT MAX("contactId") FROM tiki_webmail_contacts));
SELECT SETVAL('tiki_wiki_attachments_seq', (SELECT MAX("attId") FROM tiki_wiki_attachments));
SELECT SETVAL('users_users_seq', (SELECT MAX("userId") FROM users_users));

-- EOF

