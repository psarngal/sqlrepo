--------------------------------------------------------
--  File created - Thursday-July-08-2021   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package Body TEST_PACKAGE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "ADMIN"."TEST_PACKAGE" AS

    PROCEDURE bulk_insert (
        input geoquant_crisks_delta_tbl_type
    ) AS
    BEGIN
        FOR i IN input.first..input.last LOOP
            INSERT INTO geoquant_crisks_delta (
                skey,
                as_of_date,
                tstp,
                country,
                risk,
                date_of_data,
                primary_country,
                risk_values,
                start_date,
                end_date
            ) VALUES (
                input(i).skey,
                input(i).as_of_date,
                input(i).tstp,
                input(i).country,
                input(i).risk,
                input(i).date_of_data,
                input(i).primary_country,
                input(i).risk_values,
                input(i).start_date,
                input(i).end_date
            );

        END LOOP;
    END bulk_insert;

    PROCEDURE bulk_delete (
        p_as_of_date       DATE,
        p_primary_country  VARCHAR
    ) IS
        TYPE geoquant_crisks_delta_tbl_typ IS
            TABLE OF geoquant_crisks_delta%rowtype;
        geoquant_crisks_delta_tbl geoquant_crisks_delta_tbl_typ;
    BEGIN
        SELECT
            skey,
            as_of_date,
            tstp,
            country,
            risk,
            date_of_data,
            primary_country,
            risk_values,
            start_date,
            end_date
        BULK COLLECT
        INTO geoquant_crisks_delta_tbl
        FROM
            geoquant_crisks_delta
        WHERE
                primary_country = p_primary_country
            AND as_of_date = p_as_of_date;

        FORALL i IN geoquant_crisks_delta_tbl.first..geoquant_crisks_delta_tbl.last
            DELETE FROM geoquant_crisks_delta
            WHERE
                    skey = geoquant_crisks_delta_tbl(i).skey
                AND primary_country = geoquant_crisks_delta_tbl(i).primary_country
                AND as_of_date = geoquant_crisks_delta_tbl(i).as_of_date;

    END bulk_delete;

END test_package;

/
