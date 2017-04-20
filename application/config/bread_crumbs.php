<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');
/*
| -------------------------------------------------------------------
| 后台位置导航配置
| -------------------------------------------------------------------
*/
$config['bread_crumbs'] = array('backend' => array(
        'menu' => array(
            '#' => '系统管理',
            'menu' => '菜单管理',
            ),
        'menu_add' => array(
            '#' => '系统管理',
            'menu' => '菜单管理',
            'menu/add' => '添加菜单'),
        'menu_edit' => array(
            '#' => '系统管理',
            'menu' => '菜单管理',
            'menu/edit' => '修改菜单'),
        'permission' => array(
            '#' => '系统管理',
            'permission' => '管理员权限管理',
            ),
        'permission_add' => array(
            '#' => '系统管理',
            'permission' => '管理员权限管理',
            'permission/add' => '添加管理员权限',
            ),
        'permission_edit' => array(
            '#' => '系统管理',
            'permission' => '管理员权限管理',
            'permission/edit' => '修改管理员权限',
            ),
        'permission_assign_priv' => array(
            '#' => '系统管理',
            'permission' => '管理员权限管理',
            'permission/assignPriv' => '分派权限',
            ),
        'admin' => array(
            '#' => '系统管理',
            'admin' => '管理员管理',
            ),
        'admin_add' => array(
            '#' => '系统管理',
            'admin' => '管理员管理',
            'admin/add' => '添加管理员',
            ),
        'admin_edit' => array(
            '#' => '系统管理',
            'admin' => '管理员管理',
            'admin/edit' => '修改管理员',
            ),
        'admin_user_profile' => array(
            '#' => '系统管理',
            'admin' => '管理员管理',
            'admin/info' => '管理员信息管理',
            ),
        'role' => array(
            '#' => '系统管理',
            'role' => '管理员角色管理',
            ),
        'role_add' => array(
            '#' => '系统管理',
            'role' => '管理员角色管理',
            'role/add' => '添加管理员角色',
            ),
        'role_edit' => array(
            '#' => '系统管理',
            'role' => '管理员角色管理',
            'role/edit' => '修改管理员角色',
            ),
        'adminLog' => array(
            '#' => '系统管理',
            'log' => '管理员日志管理',
            ),
        'customerApply' => array(
            '#' => '数据报表',
            'customer/customerApply' => '每日战况',
            ),
        'customerOperation' => array(
            '#' => '数据报表',
            'customer/customerOperation' => '用户池',
            ),
        'leadsKey' => array(
            '#' => '运营管理',
            'customer/leadsKey' => '天猫Key值管理',
            ),
        'leadsKeyEdit' => array(
            '#' => '运营管理',
            'customer/leadsKey' => 'Key值管理',
            'customer/leadsKeyEdit' => '新增Key值',
            ),
        'tmallKeyEdit' => array(
            '#' => '运营管理',
            'customer/leadsKey' => 'Key值管理',
            'customer/tmallKeyEdit' => '维护天猫宝贝数据',
            ),
        'grouponList' => array(
            '#' => '内容管理',
            'grouopon/index' => '车团长',
            ),
        'vipDealerVerify' => array(
            '#' => '运营管理',
            'vipdealer/verify' => '订单核销',
            ),
        'vipDealerCarManage' => array(
            '#' => '内容管理',
            'vipdealer/car' => '一口价',
            ),
        'addVipDealerCar' => array(
            '#' => '内容管理',
            'vipdealer/car' => '一口价',
            'vipdealer/addCar' => '添加一口价'),
        'editVipDealerCar' => array(
            '#' => '内容管理',
            'vipdealer/car' => '一口价',
            'vipdealer/editCar' => '修改一口价'),
        'addGroupon' => array(
            '#' => '内容管理',
            'grouopon/index' => '车团长',
            'grouopon/add' => '添加车团长'),
        'editGroupon' => array(
            '#' => '内容管理',
            'grouopon/index' => '车团长',
            'grouopon/edit' => '修改车团长'),
        'grouponDetailList' => array(
            '#' => '内容管理',
            'grouopon/index' => '车团长',
            'grouopon/detailList' => '车团长报名列表',
            ),
        'grouponDetailAdd' => array(
            '#' => '内容管理',
            'grouopon/index' => '车团长',
            '' => '车团长报名',
            ),
        'grouponDetailEdit' => array(
            '#' => '内容管理',
            'grouopon/index' => '车团长',
            '' => '车团长报名修改',
            ),
        'articleManage' => array(
            '#' => '内容管理',
            'article/index' => '车团长往期回顾',
            ),
        'articleAdd' => array(
            '#' => '内容管理',
            'article/index' => '车团长往期回顾',
            'article/add' => '添加文章',
            ),
        'articleEdit' => array(
            '#' => '内容管理',
            'article/index' => '车团长往期回顾',
            'article/edit' => '修改文章',
            ),
        'articleManage' => array(
            '#' => '内容管理',
            'article/index' => '车团长往期回顾',
            ),
        'VipDealerOrdersManage' => array(
            '#' => '内容管理',
            'vipdealer/orders' => '查看订单'),
        'adManage' => array('#' => '广告管理', 'ad/index' => '广告列表'),
        'adAdd' => array(
            '#' => '广告管理',
            'ad/index' => '广告列表',
            'ad/add' => '添加广告'),
        'adEdit' => array(
            '#' => '广告管理',
            'ad/index' => '广告列表',
            'ad/edit' => '修改广告'),
        'easyCar' => array('#' => '内容管理', 'easyCar' => '易租车'),
        'easyCarEdit' => array(
            '#' => '内容管理',
            'easyCar' => '易租车',
            'easyCar/easyCarEdit' => '活动编辑'),
        'messageManage' => array(
            '#' => '运营管理',
            'customer/messageManage' => '短信管理',
            ),
        'messageEdit' => array(
            '#' => '运营管理',
            'customer/messageManage' => '短信管理',
            'customer/messageEdit' => '短信模板编辑'),
        'couponManage' => array(
            '#' => '优惠券管理',
            'coupon/index' => '优惠券列表',
            ),
        'couponEdit' => array(
            '#' => '优惠券管理',
            'coupon/index' => '优惠券列表',
            'coupon/edit' => '优惠券编辑',
            ),
        'seriesAc' => array('#' => '运营管理', 'activity' => '专题管理'),
        'seriesAcEdit' => array(
            '#' => '运营管理',
            'activity' => '专题管理',
            'activity/seriesAcEdit' => '专题编辑'),
        'seriesAcAdd' => array(
            '#' => '运营管理',
            'activity' => '专题管理',
            'activity/seriesAcAdd' => '专题添加'),
        'prizeManage' => array(
            '#' => '内容管理',
            'prize' => '抽奖管理 ',
            ),
        'prizeMainAdd' => array(
            '#' => '内容管理',
            'prize' => '抽奖管理 ',
            'prize/add' => '抽奖活动添加',
            ),
        'prizeMainEdit' => array(
            '#' => '内容管理',
            'prize' => '抽奖管理 ',
            'prize/edit' => '抽奖活动修改',
            ),

        'prizeDetailList' => array(
            '#' => '内容管理',
            'prize' => '抽奖管理 ',
            '' => '抽奖奖项',
            ),

        'prizeDetailAdd' => array(
            '#' => '内容管理',
            'prize' => '抽奖管理 ',
            '' => '添加奖项',
            ),

        'prizeDetailEdit' => array(
            '#' => '内容管理',
            'prize' => '抽奖管理 ',
            '' => '修改奖项',
        ),

        'seriesManage' => array(
            '#' => '运营管理',
            'series' => '车系管理 ',
        ),

        'seriesAdd' => array(
            '#' => '运营管理',
            'series' => '车系管理',
            'series/add' => '车系添加',
        ),

        'seriesEdit' => array(
            '#' => '运营管理',
            'series' => '车系管理',
            'series/edit' => '车系修改',
        ),

        'lucky' => array(
            '#' => '运营管理',
            'lukcy' => '查询中奖名单',
        ),

        'win' => array(
            '#' => '运营管理',
            'win' => '中奖名单管理',
        ),
        'winAdd' => array(
            '#' => '运营管理',
            'win' => '中奖名单管理',
            'win/add' => '中奖名单添加',
        ),
        'winEdit' => array(
            '#' => '运营管理',
            'win' => '中奖名单管理',
            'win/edit' => '中奖名单修改',
        ),
        'orderList'=>array(
            '#'=>'订单管理',
            'orderList'=>'订单列表'
        ),
        'orderDetail'=>array(
            '#'=>'订单管理',
            'orderDetail'=>'订单详情'
        ),
        'orderScan'=>array(
            '#'=>'订单管理',
            'orderScan'=>'扫码支付'
        )
    
    ), 
);

/* End of file site_config.php */
/* Location: ./system/application/config/site_config.php */
