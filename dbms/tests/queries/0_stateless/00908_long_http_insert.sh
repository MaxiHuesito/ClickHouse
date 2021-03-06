#!/usr/bin/env bash
set -e

CURDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
. $CURDIR/../shell_config.sh

echo 'DROP TABLE IF EXISTS test.table_for_insert'                            | ${CLICKHOUSE_CURL} -sSg ${CLICKHOUSE_URL} -d @-
echo 'CREATE TABLE test.table_for_insert (a UInt8, b UInt8) ENGINE = Memory' | ${CLICKHOUSE_CURL} -sSg ${CLICKHOUSE_URL} -d @-
echo "INSERT INTO test.table_for_insert VALUES `printf '%*s' "1000000" | sed 's/ /(1, 2)/g'`" | ${CLICKHOUSE_CURL} -sSg ${CLICKHOUSE_URL} -d @-
echo 'SELECT count(*) FROM test.table_for_insert'                            | ${CLICKHOUSE_CURL} -sSg ${CLICKHOUSE_URL} -d @-
echo 'DROP TABLE IF EXISTS test.table_for_insert'                            | ${CLICKHOUSE_CURL} -sSg ${CLICKHOUSE_URL} -d @-
