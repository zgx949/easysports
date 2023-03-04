<p align="center">
	<img width="200" height="200" alt="logo" src="http://sport.lefthand.top/static/img/logo.21648fa9.png">
</p>
<h1 align="center" style="margin: 30px 0 30px; font-weight: bold;">EasySports高校综合服务平台（RuoYi v3.8.3）</h1>
<h4 align="center">RuoYi基于SpringBoot+Vue前后端分离的Java快速开发框架</h4>
<p align="center">
	<a href="https://gitee.com/y_project/RuoYi-Vue/stargazers"><img src="https://gitee.com/y_project/RuoYi-Vue/badge/star.svg?theme=dark"></a>
	<a href="https://gitee.com/y_project/RuoYi-Vue"><img src="https://img.shields.io/badge/RuoYi-v3.8.3-brightgreen.svg"></a>
	<a href="https://gitee.com/y_project/RuoYi-Vue/blob/master/LICENSE"><img src="https://img.shields.io/github/license/mashape/apistatus.svg"></a>
</p>


## EasySports平台简介

EasySports是基于RuoYi的一套全部开源的快速开发平台，毫无保留给个人及企业免费使用。
> 本项目已在我就读的学校运行中，原计划商业化，由于本人正在考研，还有很多功能只能放弃开发，希望大家能够帮助我一同完善该项目。该项目还存在着许多地方尚未完善，数据库首次将数据部分脱敏，可能会存在部分问题，欢迎与我交流   ----一个热爱计算机的体育生

* 前端采用Vue、Element UI-Plus。
* 后端采用Spring Boot、MyBatis-Plus、Spring Security、MySql、RabbitMQ、Redis & Jwt等后端主流技术。
* 接口管理采用Knife4j
* 权限认证使用Jwt，支持多终端认证系统。
* 支持加载动态权限菜单，多方式轻松权限控制。
* 高效率开发，使用代码生成器可以一键生成前后端代码。
* 提供了技术栈（[Vue3](https://v3.cn.vuejs.org) [Element Plus](https://element-plus.org/zh-CN) [Vite](https://cn.vitejs.dev)）版本[RuoYi-Vue3](https://github.com/yangzongzhuan/RuoYi-Vue3)，保持同步更新。
* 特别鸣谢：[element](https://github.com/ElemeFE/element)，[vue-element-admin](https://github.com/PanJiaChen/vue-element-admin)，[eladmin-web](https://github.com/elunez/eladmin-web)。
## 目录结构
1. ruoyi-ui: 后台管理系统
2. uniapp-ui: 用户端UniAPP
3. docker: doker相关文件及数据库文件
4. bin: 编译脚本
5. 其他: 均为后端程序（启动项目为：ruoyi-admin）

## 内置功能
### RuoYi框架内置
1.  用户管理：用户是系统操作者，该功能主要完成系统用户配置。
2.  部门管理：配置系统组织机构（公司、部门、小组），树结构展现支持数据权限。
3.  岗位管理：配置系统用户所属担任职务。
4.  菜单管理：配置系统菜单，操作权限，按钮权限标识等。
5.  角色管理：角色菜单权限分配、设置角色按机构进行数据范围权限划分。
6.  字典管理：对系统中经常使用的一些较为固定的数据进行维护。
7.  参数管理：对系统动态配置常用参数。
8.  通知公告：系统通知公告信息发布维护。
9.  操作日志：系统正常操作日志记录和查询；系统异常信息日志记录和查询。
10. 登录日志：系统登录日志记录查询包含登录异常。
11. 在线用户：当前系统中活跃用户状态监控。
12. 定时任务：在线（添加、修改、删除)任务调度包含执行结果日志。
13. 代码生成：前后端代码的生成（java、html、xml、sql）支持CRUD下载 。
14. 系统接口：根据业务代码自动生成相关的api接口文档。
15. 服务监控：监视当前系统CPU、内存、磁盘、堆栈等相关信息。
16. 缓存监控：对系统的缓存信息查询，命令统计等。
17. 在线构建器：拖动表单元素生成相应的HTML代码。
18. 连接池监视：监视当前系统数据库连接池状态，可进行分析SQL找出系统性能瓶颈。

### EasySports功能

[项目计划、架构及文档](https://docs.qq.com/sheet/DT3FrcUNxSkZQd25M?tab=mo5m36&viewId=vh6ZPi)
1. 运动会比赛报名
2. 赛程安排模块
3. 运动会个人成绩查询
4. 获奖公示查询及打印
5. 反馈信息
6. UniApp用户端比赛排名界面
7. 报名审核后进行校验
8. 编排秩序册
9. 比赛成绩公示打印
10. 成绩输入
11. 报名约束条件校验
12. 时间编排
13. 径赛比赛单位换算
14. 晋级进入决赛名单导入
15. 成绩管理界面新功能
16. 微信云Docker流水线自动部署配置
17. APP逆向UI
18. 建立体测数据模型
19. 二维码生成
20. 各体测成绩录入界面
21. 成绩合格情况/补测资格审核
22. 合格情况/补测资格
23. 增加二维码扫码缓存
24. 成绩录入解耦
25. 增加成绩展示
26. 成绩查询缓存优化（空间局部性、时间局部性）

## RuoYi在线体验

演示地址：http://vue.ruoyi.vip  
RuoYi文档地址：http://doc.ruoyi.vip

## RuoYi后台演示图

<table>
    <tr>
        <td><img src="https://oscimg.oschina.net/oscnet/cd1f90be5f2684f4560c9519c0f2a232ee8.jpg"/></td>
        <td><img src="https://oscimg.oschina.net/oscnet/1cbcf0e6f257c7d3a063c0e3f2ff989e4b3.jpg"/></td>
    </tr>
    <tr>
        <td><img src="https://oscimg.oschina.net/oscnet/up-8074972883b5ba0622e13246738ebba237a.png"/></td>
        <td><img src="https://oscimg.oschina.net/oscnet/up-9f88719cdfca9af2e58b352a20e23d43b12.png"/></td>
    </tr>
    <tr>
        <td><img src="https://oscimg.oschina.net/oscnet/up-39bf2584ec3a529b0d5a3b70d15c9b37646.png"/></td>
        <td><img src="https://oscimg.oschina.net/oscnet/up-936ec82d1f4872e1bc980927654b6007307.png"/></td>
    </tr>
	<tr>
        <td><img src="https://oscimg.oschina.net/oscnet/up-b2d62ceb95d2dd9b3fbe157bb70d26001e9.png"/></td>
        <td><img src="https://oscimg.oschina.net/oscnet/up-d67451d308b7a79ad6819723396f7c3d77a.png"/></td>
    </tr>	 
    <tr>
        <td><img src="https://oscimg.oschina.net/oscnet/5e8c387724954459291aafd5eb52b456f53.jpg"/></td>
        <td><img src="https://oscimg.oschina.net/oscnet/644e78da53c2e92a95dfda4f76e6d117c4b.jpg"/></td>
    </tr>
	<tr>
        <td><img src="https://oscimg.oschina.net/oscnet/up-8370a0d02977eebf6dbf854c8450293c937.png"/></td>
        <td><img src="https://oscimg.oschina.net/oscnet/up-49003ed83f60f633e7153609a53a2b644f7.png"/></td>
    </tr>
	<tr>
        <td><img src="https://oscimg.oschina.net/oscnet/up-d4fe726319ece268d4746602c39cffc0621.png"/></td>
        <td><img src="https://oscimg.oschina.net/oscnet/up-c195234bbcd30be6927f037a6755e6ab69c.png"/></td>
    </tr>
    <tr>
        <td><img src="https://oscimg.oschina.net/oscnet/b6115bc8c31de52951982e509930b20684a.jpg"/></td>
        <td><img src="https://oscimg.oschina.net/oscnet/up-5e4daac0bb59612c5038448acbcef235e3a.png"/></td>
    </tr>
</table>

## EasySports演示图
![img_1.png](img_1.png)
![img_2.png](img_2.png)
![img_3.png](img_3.png)
![img.png](img/img.png)
![img_1.png](img/img_1.png)
![img_2.png](img/img_2.png)
![img_3.png](img/img_3.png)
![img_4.png](img/img_4.png)
![img_5.png](img/img_5.png)
![img_6.png](img/img_6.png)
![img_7.png](img/img_7.png)
![img_8.png](img/img_8.png)
![img_9.png](img/img_9.png)
![img_10.png](img/img_10.png)
![img_11.png](img/img_11.png)
![img_12.png](img/img_12.png)
![img_13.png](img/img_13.png)
![img_14.png](img/img_14.png)
![img_15.png](img/img_15.png)
![img_16.png](img/img_16.png)
![img_17.png](img/img_17.png)
![img_18.png](img/img_18.png)
![img_19.png](img/img_19.png)
![img_20.png](img/img_20.png)
![img_21.png](img/img_21.png)
![img_22.png](img/img_22.png)
![img_23.png](img/img_23.png)
![img.png](img.png)

