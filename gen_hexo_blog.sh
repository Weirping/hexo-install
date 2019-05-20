#!/bin/bash

BLOG_DIR=blog

npm --registry https://registry.npm.taobao.org info underscore  # 使用淘宝 NPM 镜像

echo +++++++++++++++++++++++++++++++++++++++++++++++
INIT_PATH=$PWD
cd ..
UP_PATH=$PWD
BLOG_PATH=$PWD/$BLOG_DIR
cd $INIT_PATH
echo UP_PATH $UP_PATH
echo INIT_PATH $INIT_PATH
echo BLOG_PATH $BLOG_PATH
echo 

echo +++++++++++++++++++++++++++++++++++++++++++++++
echo reinstall Hexo 
npm uninstall hexo -g
npm install hexo -g  # 安装hexo模块
echo 

echo +++++++++++++++++++++++++++++++++++++++++++++++
echo init blog in $BLOG_PATH
rm -rf $BLOG_PATH
hexo init $BLOG_PATH  # 初始化一个博客目录
echo copy blog config into $BLOG_PATH/
cp $INIT_PATH/blog_config/_config.yml $BLOG_PATH/
echo 

echo +++++++++++++++++++++++++++++++++++++++++++++++
echo intstall plugins
cd $BLOG_PATH
npm install       #这样会在blog文件夹中生成整个博客程序
npm install hexo-deployer-git --save  # 安装 git
npm install hexo-generator-searchdb --save  # 安装 local search
cd $INIT_PATH
echo 

echo +++++++++++++++++++++++++++++++++++++++++++++++
echo install NexT theme
git clone https://github.com/theme-next/hexo-theme-next $BLOG_PATH/themes/next
cd $BLOG_PATH/themes/next
git checkout v6.5.0
cd -
echo copy NexT theme config into $BLOG_PATH/themes/next
cp $INIT_PATH/next_config/_config.yml $BLOG_PATH/themes/next/
echo 

echo +++++++++++++++++++++++++++++++++++++++++++++++
echo copy source
cp -r $INIT_PATH/avatar $BLOG_PATH/source/
cp -r $INIT_PATH/categories $BLOG_PATH/source/
cp -r $INIT_PATH/tags $BLOG_PATH/source/
echo 

echo +++++++++++++++++++++++++++++++++++++++++++++++
echo finished!
echo please change file $BLOG_PATH/node_modules/marked/lib/marked.js
echo 'escape: /^\\([\\`*{}\[\]()#+\-.!_>])/,  ===>   escape: /^\\([`*\[\]()# +\-.!_>])/,'
echo 'em: /^_([^\s_](?:[^_]|__)+?[^\s_])_\b|^\*((?:\*\*|[^*])+?)\*(?!\*)/,   ===>   em: /^\*((?:\*\*|[\s\S])+?)\*(?!\*)/,'
echo +++++++++++++++++++++++++++++++++++++++++++++++
echo please set github repo in $BLOG_PATH/_config.yml as blow
echo deploy:
echo '  type: git'
echo '  repository: git@github.com:Weirping/weirping.github.io.git'
echo '  branch: master'