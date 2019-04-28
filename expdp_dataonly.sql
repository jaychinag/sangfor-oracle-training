################################################################################################################################## 导入
--表结构导出
cat > exp_WIFIITSM_DEVELOP_20161227_meta.par
USERID='/ as sysdba'
DIRECTORY=DUMP
DUMPFILE=exp_WIFIITSM_DEVELOP_20161227_meta_%U.dmp
LOGFILE=exp_WIFIITSM_DEVELOP_20161227_meta.log
content=METADATA_ONLY
SCHEMAS=WIFIITSM_DEVELOP
FILESIZE=6656M
version=11.2.0.4.0
exclude=STATISTICS

nohup expdp parfile=exp_WIFIITSM_DEVELOP_20161227_meta.par > exp_WIFIITSM_DEVELOP_20161227_meta.par.out &

--表数据导出 DATA_ONLY
cat > exp_WIFIITSM_DEVELOP_20161227_data.par
USERID='/ as sysdba'
DIRECTORY=DUMP
DUMPFILE=exp_WIFIITSM_DEVELOP_20161227_data_%U.dmp
LOGFILE=exp_WIFIITSM_DEVELOP_20161227_data.log
content=DATA_ONLY
SCHEMAS=WIFIITSM_DEVELOP
FILESIZE=6656M
version=11.2.0.4.0
parallel=1
CLUSTER=N

nohup expdp parfile=exp_WIFIITSM_DEVELOP_20161227_data.par > exp_WIFIITSM_DEVELOP_20161227_data.par.out &

##表结构导入(不含索引和约束)
cat > imp_WIFIITSM_DEVELOP_20161227_meta.par
userid='/ as sysdba'
directory=DUMP
dumpfile=exp_WIFIITSM_DEVELOP_20161227_meta_%U.dmp
logfile=imp_WIFIITSM_DEVELOP_20161227_meta.log
schemas=WIFIITSM_DEVELOP
exclude=index,CONSTRAINT
CLUSTER=N
parallel=1

nohup impdp parfile=imp_WIFIITSM_DEVELOP_20161227_meta.par > imp_WIFIITSM_DEVELOP_20161227_meta.par.out &

##表数据导入
cat > imp_WIFIITSM_DEVELOP_20161227_data.par
userid='/ as sysdba'
directory=DUMP
dumpfile=exp_WIFIITSM_DEVELOP_20161227_data_%U.dmp
logfile=imp_WIFIITSM_DEVELOP_20161227_data.log
CLUSTER=N
parallel=1

nohup impdp parfile=imp_WIFIITSM_DEVELOP_20161227_data.par > imp_WIFIITSM_DEVELOP_20161227_data.par.out &

##索引导入
cat >imp_WIFIITSM_DEVELOP_20161227_idx.par
userid='/ as sysdba'
directory=DUMP
dumpfile=exp_WIFIITSM_DEVELOP_20161227_meta_%U.dmp
logfile=imp_WIFIITSM_DEVELOP_20161227_idx.log
CLUSTER=N
include=index
SQLFILE=imp_WIFIITSM_DEVELOP_20161227_idx.sql
parallel=1
schemas=WIFIITSM_DEVELOP

nohup impdp parfile=imp_WIFIITSM_DEVELOP_20161227_idx.par > imp_WIFIITSM_DEVELOP_20161227_idx.par.out &

##约束导入
cat >imp_WIFIITSM_DEVELOP_20161227_con.par
userid='/ as sysdba'
directory=DUMP
dumpfile=exp_WIFIITSM_DEVELOP_20161227_meta_%U.dmp
logfile=imp_WIFIITSM_DEVELOP_20161227_con.log
CLUSTER=N
include=constraint
SQLFILE=imp_WIFIITSM_DEVELOP_20161227_con.sql
parallel=1
schemas=WIFIITSM_DEVELOP

nohup impdp parfile=imp_WIFIITSM_DEVELOP_20161227_con.par > imp_WIFIITSM_DEVELOP_20161227_con.par.out &

##统计收集
exec DBMS_STATS.GATHER_SCHEMA_STATS(ownname=>'WIFIITSM_DEVELOP',ESTIMATE_PERCENT=>5,method_opt=>'for all columns size 1',cascade=>true,force=>true,degree=>8);
