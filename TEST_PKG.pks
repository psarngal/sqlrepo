--------------------------------------------------------
--  File created - Thursday-July-08-2021   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package TEST_PACKAGE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "ADMIN"."TEST_PACKAGE" AS 

  /* TODO enter package declarations (types, exceptions, methods etc) here */
    PROCEDURE bulk_insert (
        input geoquant_crisks_delta_tbl_type
    );

    PROCEDURE bulk_delete (
        p_as_of_date       DATE,
        p_primary_country  VARCHAR
    );

END test_package;

/
