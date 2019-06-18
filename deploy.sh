#!/bin/bash


etcd_addr="https://10.6.185.110:12379"
WEBUI_PORT="8088"


hostpath_etcd_ca=`find /etc -name "etcd-ca"`
hostpath_etcd_cert=`find /etc -name "etcd-cert"`
hostpath_etcd_key=`find /etc -name "etcd-key"`

#------------------------------------------

path_etcd_ca=`basename $hostpath_etcd_ca`
path_etcd_cert=`basename $hostpath_etcd_cert`
path_etcd_key=`basename $hostpath_etcd_key`


docker run -d -p $WEBUI_PORT:8080   \
  -e CA_FILE=/var/$path_etcd_ca \
  -e CERT_FILE=/var/$path_etcd_cert \
  -e KEY_FILE=/var/$path_etcd_key \
    -v $hostpath_etcd_ca:/var/$path_etcd_ca  \
    -v $hostpath_etcd_cert:/var/$path_etcd_cert   \
    -v $hostpath_etcd_key:/var/$path_etcd_key     \
  -e ENDPOINTS="$etcd_addr" \
  registry.cn-hangzhou.aliyuncs.com/ringtail/lucas:0.0.1
