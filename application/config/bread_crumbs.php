<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');
/*
| -------------------------------------------------------------------
| 后台位置导航配置
| -------------------------------------------------------------------
*/
$config['bread_crumbs'] = [
    'backend' => [
        'menu' => [
            '#' => '系统管理',
            'menu' => '菜单管理',
        ],
        'menu_add' => [
            '#' => '系统管理',
            'menu' => '菜单管理',
            'menu/add' => '添加菜单'
        ],
        'menu_edit' => [
            '#' => '系统管理',
            'menu' => '菜单管理',
            'menu/edit' => '修改菜单'
        ],
        'permission' => [
            '#' => '系统管理',
            'permission' => '管理员权限管理',
        ],
        'permission_add' => [
            '#' => '系统管理',
            'permission' => '管理员权限管理',
            'permission/add' => '添加管理员权限',
        ],
        'permission_edit' => [
            '#' => '系统管理',
            'permission' => '管理员权限管理',
            'permission/edit' => '修改管理员权限',
        ],
        'permission_assign_priv' => [
            '#' => '系统管理',
            'permission' => '管理员权限管理',
            'permission/assignPriv' => '分派权限',
            ],
        'admin' => [
            '#' => '系统管理',
            'admin' => '管理员管理',
        ],
        'admin_add' => [
            '#' => '系统管理',
            'admin' => '管理员管理',
            'admin/add' => '添加管理员',
        ],
        'admin_edit' => [
            '#' => '系统管理',
            'admin' => '管理员管理',
            'admin/edit' => '修改管理员',
        ],
        'admin_user_profile' => [
            '#' => '系统管理',
            'admin' => '管理员管理',
            'admin/info' => '管理员信息管理',
        ],
        'role' => [
            '#' => '系统管理',
            'role' => '管理员角色管理',
        ],
        'role_add' => [
            '#' => '系统管理',
            'role' => '管理员角色管理',
            'role/add' => '添加管理员角色',
        ],
        'role_edit' => [
            '#' => '系统管理',
            'role' => '管理员角色管理',
            'role/edit' => '修改管理员角色',
        ],
        'adminLog' => [
            '#' => '系统管理',
            'log' => '管理员日志管理',
        ],
        'adManage' => [
            '#' => '广告管理',
            'ad/index' => '广告列表'
        ],
        'adAdd' => [
            '#' => '广告管理',
            'ad/index' => '广告列表',
            'ad/add' => '添加广告'
        ],
        'adEdit' => [
            '#' => '广告管理',
            'ad/index' => '广告列表',
            'ad/edit' => '修改广告'
        ],
    ],
];

/* End of file site_config.php */
/* Location: ./system/application/config/site_config.php */
