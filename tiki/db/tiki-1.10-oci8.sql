;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."activityId" FROM DUAL;
END;
/
;

;

;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."cId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."instanceId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."pId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."roleId" FROM DUAL;
END;
/
;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."roleId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."itemId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."msgId" FROM DUAL;
END;
/
;

;

;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."articleId" FROM DUAL;
END;
/
;

;

;

;

;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."bannerId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."banId" FROM DUAL;
END;
/
;

;

;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."postId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."imgId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."blogId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."calcatId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."calitemId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."callocId" FROM DUAL;
END;
/
;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."calendarId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."categId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."catObjectId" FROM DUAL;
END;
/
;

;

;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."itemId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."chartId" FROM DUAL;
END;
/
;

;

;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."channelId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."messageId" FROM DUAL;
END;
/
;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."threadId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."contentId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."templateId" FROM DUAL;
END;
/
;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."cookieId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."copyrightId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."categId" FROM DUAL;
END;
/
;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."siteId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."drawId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."dsnId" FROM DUAL;
END;
/
;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."ephId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."extwikiId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."questionId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."faqId" FROM DUAL;
END;
/
;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."galleryId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."fileId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."attId" FROM DUAL;
END;
/
;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."forumId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."qId" FROM DUAL;
END;
/
;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."galleryId" FROM DUAL;
END;
/
;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."imageId" FROM DUAL;
END;
/
;

;

;

;

;

;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."cacheId" FROM DUAL;
END;
/
;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."eventId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."cId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."msgId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."modId" FROM DUAL;
END;
/
;

;

;

;

;

;

;

;

;

;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."logId" FROM DUAL;
END;
/
;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."accountId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."menuId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."optionId" FROM DUAL;
END;
/
;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."menuId" FROM DUAL;
END;
/
;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."eventId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."topicId" FROM DUAL;
END;
/
;

;

;

;

;

;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."nlId" FROM DUAL;
END;
/
;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."serverId" FROM DUAL;
END;
/
;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."page_id" FROM DUAL;
END;
/
;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."optionId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."pollId" FROM DUAL;
END;
/
;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."messageId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."pId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."optionId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."questionId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."resultId" FROM DUAL;
END;
/
;

;

;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."quizId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."receivedArticleId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."receivedPageId" FROM DUAL;
END;
/
;

;

;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."rssId" FROM DUAL;
END;
/
;

;

;

;

;

;

;

;

;

;

;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."editionId" FROM DUAL;
END;
/
;

;

;

;

;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."sheetId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."msgId" FROM DUAL;
END;
/
;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."structure_id" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."page_ref_id" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."subId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."sfqId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."optionId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."questionId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."surveyId" FROM DUAL;
END;
/
;

;

;

;

;

;

;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."topicId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."fieldId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."attId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."commentId" FROM DUAL;
END;
/
;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."itemId" FROM DUAL;
END;
/
;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."trackerId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."id" FROM DUAL;
END;
/
;

;

;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."folderId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."urlId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."accountId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."menuId" FROM DUAL;
END;
/
;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."noteId" FROM DUAL;
END;
/
;

;

;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."userResultId" FROM DUAL;
END;
/
;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."taskId" FROM DUAL;
END;
/
;

;

;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."fileId" FROM DUAL;
END;
/
;

;

;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."contactId" FROM DUAL;
END;
/
;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."attId" FROM DUAL;
END;
/
;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."id" FROM DUAL;
END;
/
;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."userId" FROM DUAL;
END;
/
;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."repID" FROM DUAL;
END;
/
;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."ruleID" FROM DUAL;
END;
/
;

;

;

;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."tagId" FROM DUAL;
END;
/
;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."genreId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."albumId" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."trackId" FROM DUAL;
END;
/
;

;

;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."assignmentId" FROM DUAL;
END;
/
;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."id" FROM DUAL;
END;
/
;

;

;

;

;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."id" FROM DUAL;
END;
/
;

CREATE SEQUENCE "_sequ" INCREMENT BY 1 START WITH 1;
;

CREATE TRIGGER "_trig" BEFORE INSERT ON "" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
SELECT "_sequ".nextval into :NEW."traId" FROM DUAL;
END;
/
;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

;

