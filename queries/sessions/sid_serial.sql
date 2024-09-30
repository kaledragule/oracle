SET PAGESIZE 0
SET LINESIZE 150
SET FEEDBACK OFF


COLUMN SPID     FORMAT 99999999 TRUNC JUSTIFY LEFT
COLUMN ALTERSYSTEM FORMAT A11 TRUNC JUSTIFY LEFT
COLUMN O_USER   FORMAT A12 TRUNC
COLUMN U_USER   FORMAT A12 TRUNC
COLUMN SERIAL#  FORMAT 99999 TRUNC
COLUMN TERMINAL FORMAT A5 TRUNC
COLUMN PROGRAM  FORMAT A60 TRUNC
COLUMN BACKGROUND       FORMAT A1

SELECT s.sid||','|| s.serial# AlterSystem,decode(nvl(p.background, 0), 0, ' ', 'B') background,
       to_number(p.SPID) SPID,
       'U:' || p.USERNAME u_user,
       'O:' || lower(s.USERNAME) o_user,
       p.TERMINAL,
       UPPER(DECODE(NVL(s.command, 0),
                0,      '---------------',
                1,      'Create Table',
                2,      'Insert ...',
                3,      'Select ...',
                4,      'Create Cluster',
                5,      'Alter Cluster',
                6,      'Update ...',
                7,      'Delete ...',
                8,      'Drop ...',
                9,      'Create Index',
               10,      'Drop Index',
               11,      'Alter Index',
               12,      'Drop Table',
               13,      '--',
               14,      '--',
               15,      'Alter Table',
               16,      '--',
               17,      'Grant',
               18,      'Revoke',
               19,      'Create Synonym',
               20,      'Drop Synonym',
               21,      'Create View',
               22,      'Drop View',
               23,      '--',
               24,      '--',
               25,      '--',
               26,      'Lock Table',
               27,      'No Operation',
               28,      'Rename',
               29,      'Comment',
               30,      'Audit',
               31,      'NoAudit',
               32,      'Create Ext DB',
               33,      'Drop Ext. DB',
               34,      'Create Database',
               35,      'Alter Database',
               36,      'Create RBS',
               37,      'Alter RBS',
               38,      'Drop RBS',
               39,      'Create Tablespace',
               40,      'Alter Tablespace',
               41,      'Drop tablespace',
               42,      'Alter Session',
               43,      'Alter User',
               44,      'Commit',
               45,      'Rollback',
               46,      'Savepoint')) job,
               s.program program
FROM    v$process p,
       v$session s
WHERE   p.addr=s.paddr (+)
 AND   p.spid IS NOT NULL
ORDER   by o_user,1, program, p.username, s.username, spid;
