To insert sql from file,

`psql -d <db> < file_name.sql`

in psql cli use, `\i`


To disable trigger,

`alter table <schema>.<table> disable trigger <trigger_name>;`
