SET LINES 200 PAGES 5000 TIMING ON;
COL ACTION_TIME FOR A30;
COL ACTION FOR A10;
COL NAMESPACE FOR A10;
COL VERSION FOR A10;
COL ID FOR 99;
COL BUNDLE_SERIES FOR A15;
COL COMMENTS FOR A75;
SELECT * FROM REGISTRY$HISTORY;
SELECT BANNER FROM V$VERSION;