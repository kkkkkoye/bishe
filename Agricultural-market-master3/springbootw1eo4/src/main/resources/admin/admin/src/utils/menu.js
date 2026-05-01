const menu = {
    list() {
        return [{
            "backMenu": [{
                "child": [{
                    "appFrontIcon": "cuIcon-rank",
                    "buttons": ["新增", "查看", "修改", "删除"],
                    "menu": "用户",
                    "menuJump": "列表",
                    "tableName": "yonghu"
                }],
                "menu": "用户管理"
            }, {
                "child": [{
                    "appFrontIcon": "cuIcon-friend",
                    "buttons": ["新增", "查看", "修改", "删除"],
                    "menu": "商家",
                    "menuJump": "列表",
                    "tableName": "shangjia"
                }],
                "menu": "商家管理"
            }, {
                "child": [{
                    "appFrontIcon": "cuIcon-present",
                    "buttons": ["新增", "查看", "修改", "删除"],
                    "menu": "产品分类",
                    "menuJump": "列表",
                    "tableName": "chanpinfenlei"
                }],
                "menu": "产品分类管理"
            }, {
                "child": [{
                    "appFrontIcon": "cuIcon-addressbook",
                    "buttons": ["新增", "查看", "修改", "删除", "查看评论"],
                    "menu": "热销农产品",
                    "menuJump": "列表",
                    "tableName": "rexiaonongchanpin"
                }],
                "menu": "热销农产品管理"
            }, {
                "child": [{
                    "appFrontIcon": "cuIcon-service",
                    "buttons": ["新增", "查看", "修改", "删除"],
                    "menu": "在线客服",
                    "tableName": "chat"
                }, {
                    "appFrontIcon": "cuIcon-form",
                    "buttons": ["查看", "修改"],
                    "menu": "关于我们",
                    "tableName": "aboutus"
                }, {
                    "appFrontIcon": "cuIcon-flashlightopen",
                    "buttons": ["新增", "查看", "修改", "删除"],
                    "menu": "轮播图管理",
                    "tableName": "config"
                }, {
                    "appFrontIcon": "cuIcon-news",
                    "buttons": ["新增", "查看", "修改", "删除"],
                    "menu": "网站公告",
                    "tableName": "news"
                }],
                "menu": "系统管理"
            }, {
                "child": [{
                    "appFrontIcon": "cuIcon-copy",
                    "buttons": ["删除", "查看"],
                    "menu": "订单管理",
                    "tableName": "orders"
                }],
                "menu": "订单管理"
            }],
            "frontMenu": [],
            "hasBackLogin": "是",
            "hasBackRegister": "否",
            "hasFrontLogin": "否",
            "hasFrontRegister": "否",
            "roleName": "管理员",
            "tableName": "users"
        }, {
            // --- 商家角色功能增强 ---
            "backMenu": [{
                "child": [{
                    "appFrontIcon": "cuIcon-shop",
                    "buttons": ["查看", "修改"],
                    "menu": "店铺信息",
                    "tableName": "shangjia"
                }],
                "menu": "店铺管理"
            }, {
                "child": [{
                    "appFrontIcon": "cuIcon-goods",
                    "buttons": ["新增", "查看", "修改", "删除", "查看评论"],
                    "menu": "我的农产品",
                    "menuJump": "列表",
                    "tableName": "rexiaonongchanpin"
                }],
                "menu": "商品管理"
            }, {
                "child": [{
                    "appFrontIcon": "cuIcon-order",
                    "buttons": ["查看", "修改", "删除", "发货"],
                    "menu": "订单列表",
                    "tableName": "orders"
                }],
                "menu": "订单管理"
            }, {
                "child": [{
                    "appFrontIcon": "cuIcon-evaluate",
                    "buttons": ["查看", "修改", "回复", "删除"],
                    "menu": "商品评价管理",
                    "tableName": "discussrexiaonongchanpin"
                }],
                "menu": "评价管理"
            }, {
                "child": [{
                    "appFrontIcon": "cuIcon-discover",
                    "buttons": ["查看", "修改"],
                    "menu": "营销活动设置",
                    "menuJump": "列表",
                    "tableName": "rexiaonongchanpin"
                }],
                "menu": "营销管理"
            }],
            "frontMenu": [],
            "hasBackLogin": "是",
            "hasBackRegister": "是",
            "hasFrontLogin": "否",
            "hasFrontRegister": "否",
            "roleName": "商家",
            "tableName": "shangjia"
        }, {
            "backMenu": [{
                "child": [{
                    "appFrontIcon": "cuIcon-favor",
                    "buttons": ["查看", "删除"],
                    "menu": "我的收藏管理",
                    "tableName": "storeup"
                }],
                "menu": "我的收藏管理"
            }],
            "frontMenu": [],
            "hasBackLogin": "否",
            "hasBackRegister": "否",
            "hasFrontLogin": "是",
            "hasFrontRegister": "是",
            "roleName": "用户",
            "tableName": "yonghu"
        }]
    }
}
export default menu;