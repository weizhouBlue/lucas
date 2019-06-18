#!/bin/bash


etcd_addr="https://10.6.185.110:12379"
#etcd_addr="https://10.6.185.110:12379,https://10.6.185.120:12379"

WEBUI_PORT="8088"


hostpath_etcd_ca=`find /etc -name "etcd-ca"`
hostpath_etcd_cert=`find /etc -name "etcd-cert"`
hostpath_etcd_key=`find /etc -name "etcd-key"`

#------------------------------------------
image="weizhoulan/etcdv3_browser:latest"
path_etcd_ca=`basename $hostpath_etcd_ca`
path_etcd_cert=`basename $hostpath_etcd_cert`
path_etcd_key=`basename $hostpath_etcd_key`


docker pull $image
docker run -d -p $WEBUI_PORT:8080  --name etcdv3-browser \
  -e CA_FILE=/var/$path_etcd_ca \
  -e CERT_FILE=/var/$path_etcd_cert \
  -e KEY_FILE=/var/$path_etcd_key \
    -v $hostpath_etcd_ca:/var/$path_etcd_ca  \
    -v $hostpath_etcd_cert:/var/$path_etcd_cert   \
    -v $hostpath_etcd_key:/var/$path_etcd_key     \
  -e ENDPOINTS="$etcd_addr" \
  $image
