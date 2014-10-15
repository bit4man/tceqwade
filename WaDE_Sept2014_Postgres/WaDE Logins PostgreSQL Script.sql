--Group Roles and Login Roles for WaDE PostgreSQL database restore
BEGIN
CREATE ROLE "CATALOG_MGR"
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
CREATE ROLE "WADE_ADMIN"
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
CREATE ROLE "WADE_APP"
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
CREATE ROLE "WU_ADMIN"
  NOSUPERUSER INHERIT CREATEDB CREATEROLE NOREPLICATION;
END
BEGIN
CREATE ROLE "WADE" LOGIN
  ENCRYPTED PASSWORD '  '
  NOSUPERUSER INHERIT CREATEDB CREATEROLE NOREPLICATION;
CREATE ROLE nodeadmin LOGIN
  ENCRYPTED PASSWORD '  '
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
GRANT "WADE_ADMIN" TO nodeadmin;
GRANT "WADE_APP" TO nodeadmin;
CREATE ROLE wade_app1 LOGIN
  ENCRYPTED PASSWORD ' '
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
GRANT "WADE_APP" TO wade_app1;
END