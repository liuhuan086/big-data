# 前言

### 2020.02.29

目前只实现了Hadoop一键部署和启动，并且其中还有些问题

## 一、暂未通过ansible实现

以下环境是**提前准备好的**，还未通过ansible实现一键完成

1. 修改主机名
2. ssh免密登陆
3. 修改/etc/hosts文件
4. Java 1.8安装
5. 修改/etc/profile
6. 使用root以外的账户进行操作



## 二、准备

1. 操作主机安装ansible

2. 提前下载好hadoop.3.2.1.tar.gz并放入packages包中

3. 虚拟机分配

| 主机名 | nn   | zk   | dn   | zfkc | jn   |
| ------ | ---- | ---- | ---- | ---- | ---- |
| node1  | Y    |      |      | Y    | Y    |
| node2  | Y    |      |      | Y    | Y    |
| node3  |      | Y    | Y    |      | Y    |
| node4  |      | Y    | Y    |      |      |
| node5  |      | Y    | Y    |      |      |


## 2020.03.14
### 目前实现：
 * hadoop hbase zookeeper集群一键安装和部署
 * ssh免密登陆配置
 * jdk的安装，环境变量的配置
 * 主机名的修改，hosts文件添加
 * 使用install.sh脚本一键部署
 * 实现普通用户安装

**注意：该脚本实现了普通用户安装，在安装之前请详细查看`roles/user/tasks/main.yml`中
关于user模块的remove的作用，确认之后自行决定是否取消注释。请谨慎操作！！！**

## 2020.03.18
### 新增变动：
变动速览：
 * site.yml
  * 判断zfkc是否首次格式化
  * 判断nodename2是否首次standby
  * 当某些任务执行失败时，停止执行后面的任务
  * roles/user中，修改bug，由root用户执行roles/user中的操作
 * hosts中:
  * IP地址换成节点名称
  * 精简代码
 * roles：
  * 将各个role中的安装版本切换为变量，使用不同的安装版本只需修改各个roles/vars中的参数
 * roles/ssh：
  * 添加执行主机公钥时，修复有几台远程主机添加几次的问题，目前只添加一次
 * roles:
  * 增加健壮性，使用template模块，可能会遇到`dest`不存在时，执行失败的情况