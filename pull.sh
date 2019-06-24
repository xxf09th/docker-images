#!/bin/bash


image=${1}
tmp_image=${image#*\/}
gen_image=${tmp_image//[\/:]/-}
image_local=${2}


registry_address="registry.cn-beijing.aliyuncs.com"
aliyun_image="/kubeflow-xxf/pull-images"
version=${gen_image}


if [ $# = 2 ];
then
  #image=${1}
  #image_local=${2}
  echo "use default registry"
elif [ $# = 4 ];
then
  #image=${1}
  #image_local=${1}
  registry_address=${3}
  aliyun_image=${4}
  echo "change registry address to ${registry_address}${aliyun_image}"
else
  echo "invalid args number, cmd image_local reg_address aliyun_images"
  exit 1
fi


echo "will download this image from: ${registry_address}${aliyun_image}:${version}"
docker pull ${registry_address}${aliyun_image}:${version}
docker tag  ${registry_address}${aliyun_image}:${version} ${image_local}
docker rmi ${registry_address}${aliyun_image}:${version}
echo -e ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> download successfully!\n
