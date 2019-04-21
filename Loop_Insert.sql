<<<<<<< HEAD
CREATE TABLE HR.TOO_LITTLE_INFORMATION (
MY_TASK             VARCHAR2(100)
);

BEGIN
  FOR V_LP IN 1..1000000 LOOP
    INSERT INTO HR.TOO_LITTLE_INFORMATION
    VALUES ('I will provide more information when asking questions in the future.');
  END LOOP;
  COMMIT;
END;
=======
CREATE TABLE HR.TOO_LITTLE_INFORMATION (
MY_TASK             VARCHAR2(100)
);

BEGIN
  FOR V_LP IN 1..1000000 LOOP
    INSERT INTO HR.TOO_LITTLE_INFORMATION
    VALUES ('I will provide more information when asking questions in the future.');
  END LOOP;
  COMMIT;
END;
>>>>>>> 327b5e2c2d7f1e6078f5d0c4cff716a75d749ca2
