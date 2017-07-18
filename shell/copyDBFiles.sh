#!/bin/bash

# Setup Environment - setup your oracle environment parameters prior to execution.
export REMOTE_SRV=your_remote_server
export LSID=$(echo "$ORACLE_SID" | awk '{print tolower($0)}')

scp -pr $ORACLE_BASE/oradata/$ORACLE_SID            $REMOTE_SRV:$ORACLE_BASE/oradata/$ORACLE_SID
scp -pr $ORACLE_BASE/fra/$ORACLE_SID                $REMOTE_SRV:$ORACLE_BASE/fra/$ORACLE_SID
scp -pr $ORACLE_BASE/oralog1/$ORACLE_SID            $REMOTE_SRV:$ORACLE_BASE/oralog1/$ORACLE_SID
scp -pr $ORACLE_BASE/oralog2/$ORACLE_SID            $REMOTE_SRV:$ORACLE_BASE/oralog2/$ORACLE_SID
scp -pr $ORACLE_BASE/diag/rdbms/$LSID               $REMOTE_SRV:$ORACLE_BASE/diag/rdbms/$LSID
scp -pr $ORACLE_BASE/cfgtoollogs/dbca/$ORACLE_SID   $REMOTE_SRV:$ORACLE_BASE/cfgtoollogs/dbca/$ORACLE_SID
scp -pr $ORACLE_BASE/audit/$ORACLE_SID              $REMOTE_SRV:$ORACLE_BASE/audit/$ORACLE_SID
scp -pr $ORACLE_BASE/admin/$ORACLE_SID              $REMOTE_SRV:$ORACLE_BASE/admin/$ORACLE_SID

# Use these when firewall blocks access between servers.

# sudo find /opt/oracle/u01/app/oracle ! -path "*oraclone*" -iname $ORACLE_SID -exec du -sh {} +

# sudo find /opt/oracle/u01/app/oracle ! -path "*oraclone*" -iname $ORACLE_SID -exec \
# tar -cvzf /opt/oracle/u01/app/oracle/oradata/$ORACLE_SID.tgz {} +
