import Vue from 'vue';
//配置路由
import VueRouter from 'vue-router'
Vue.use(VueRouter);
//1.创建组件
import Index from '@/views/index'
import Home from '@/views/home'
import Login from '@/views/login'
import NotFound from '@/views/404'
import UpdatePassword from '@/views/update-password'
import pay from '@/views/pay'
import register from '@/views/register'
import center from '@/views/center'
    import yuangong from '@/views/modules/yuangong/list'
    import huiyuankaleixing from '@/views/modules/huiyuankaleixing/list'
    import jiaolianxinxi from '@/views/modules/jiaolianxinxi/list'
    import jianshenxiangmu from '@/views/modules/jianshenxiangmu/list'
    import jianshenhuodong from '@/views/modules/jianshenhuodong/list'
    import jianshenhuodongMyList from '@/views/modules/jianshenhuodong/my-list'
    import huiyuanka from '@/views/modules/huiyuanka/list'
    import jiepin from '@/views/modules/jiepin/list'
    import zhidaoxiangmu from '@/views/modules/zhidaoxiangmu/list'
    import zhidaoxiangmuMyZhidao from '@/views/modules/zhidaoxiangmu/myZhidao'
    import jianshenqicai from '@/views/modules/jianshenqicai/list'
    import huiyuan from '@/views/modules/huiyuan/list'
    import aicoach from '@/views/modules/aicoach/list'
    import aicoachChat from '@/views/modules/aicoach/chat'
    import aicoachAddOrUpdate from '@/views/modules/aicoach/add-or-update'
    import xindefu from '@/views/modules/xindefu/list'
    import xindefuDetail from '@/views/modules/xindefu/detail'
    import xindefuAddOrUpdate from '@/views/modules/xindefu/add-or-update'
    import xindefuMyCollect from '@/views/modules/xindefu/myCollect'
    import fitnessPlan from '@/views/modules/fitnessplan/plan-generate'
    import gymmap from '@/views/modules/gymmap/map'


//2.配置路由   注意：名字
const routes = [{
    path: '/index',
    name: '首页',
    component: Index,
    children: [{
      // 这里不设置值，是把main作为默认页面
      path: '/',
      name: '首页',
      component: Home,
      meta: {icon:'', title:'center'}
    }, {
      path: '/updatePassword',
      name: '修改密码',
      component: UpdatePassword,
      meta: {icon:'', title:'updatePassword'}
    }, {
      path: '/pay',
      name: '支付',
      component: pay,
      meta: {icon:'', title:'pay'}
    }, {
      path: '/center',
      name: '个人信息',
      component: center,
      meta: {icon:'', title:'center'}
    }
      ,{
	path: '/yuangong',
        name: '员工',
        component: yuangong
      }
      ,{
	path: '/huiyuankaleixing',
        name: '会员卡类型',
        component: huiyuankaleixing
      }
      ,{
	path: '/jiaolianxinxi',
        name: '教练信息',
        component: jiaolianxinxi
      }
      ,{
	path: '/jianshenxiangmu',
        name: '健身项目',
        component: jianshenxiangmu
      }
      ,{
	path: '/jianshenhuodong',
        name: '健身活动',
        component: jianshenhuodong
      }
      ,{
        path: '/jianshenhuodong/myList',
        name: '我的健身活动',
        component: jianshenhuodongMyList
      }
      ,{
	path: '/huiyuanka',
        name: '会员卡',
        component: huiyuanka
      }
      ,{
	path: '/jiepin',
        name: '解聘',
        component: jiepin
      }
      ,{
	path: '/zhidaoxiangmu',
        name: '指导项目',
        component: zhidaoxiangmu
      }
      ,{
        path: '/zhidaoxiangmu/myZhidao',
        name: '我的指导项目',
        component: zhidaoxiangmuMyZhidao
      }
      ,{
	path: '/jianshenqicai',
        name: '健身器材',
        component: jianshenqicai
      }
      ,{
	path: '/huiyuan',
        name: '会员',
        component: huiyuan
      }
      ,{
	path: '/aicoach',
        name: 'AI教练知识库',
        component: aicoach
      }
      ,{
	path: '/aicoach/add-or-update',
        name: 'AI教练知识库编辑',
        component: aicoachAddOrUpdate
      }
      ,{
	path: '/aicoachChat',
        name: 'AI教练',
        component: aicoachChat
      }
      ,{
        path: '/xindefu',
        name: '健身心得',
        component: xindefu
      }
      ,{
        path: '/xindefu/list',
        name: '健身心得列表',
        component: xindefu
      }
      ,{
        path: '/xindefu/detail',
        name: '健身心得详情',
        component: xindefuDetail
      }
      ,{
        path: '/xindefu/add-or-update',
        name: '健身心得发布',
        component: xindefuAddOrUpdate
      }
      ,{
        path: '/xindefu/myList',
        name: '我的心得',
        component: xindefu
      }
      ,{
        path: '/xindefu/myCollect',
        name: '我的收藏',
        component: xindefuMyCollect
      }
      ,{
        path: '/fitnessPlan',
        name: '智谱大模型健身计划生成',
        component: fitnessPlan
      }
      ,{
        path: '/gymmap',
        name: '附近健身房',
        component: gymmap
      }
    ]
  },
  {
    path: '/login',
    name: 'login',
    component: Login,
    meta: {icon:'', title:'login'}
  },
  {
    path: '/register',
    name: 'register',
    component: register,
    meta: {icon:'', title:'register'}
  },
  {
    path: '/',
    name: '首页',
    redirect: '/index'
  }, /*默认跳转路由*/
  {
    path: '*',
    component: NotFound
  }
]
//3.实例化VueRouter  注意：名字
const router = new VueRouter({
  mode: 'hash',
  /*hash模式改为history*/
  routes // （缩写）相当于 routes: routes
})

export default router;
