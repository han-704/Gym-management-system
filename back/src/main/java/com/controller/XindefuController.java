package com.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Map;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;

import com.utils.ValidatorUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.annotation.IgnoreAuth;

import com.entity.XindefuEntity;
import com.entity.view.XindefuView;
import com.entity.XindefuThumbsupEntity;
import com.entity.XindefuCollectEntity;
import com.entity.HuiyuanEntity;

import com.service.XindefuService;
import com.service.XindefuThumbsupService;
import com.service.XindefuCollectService;
import com.service.TokenService;
import com.service.HuiyuanService;
import com.utils.PageUtils;
import com.utils.R;
import com.utils.MD5Util;
import com.utils.MPUtil;
import com.utils.CommonUtil;


/**
 * 健身心得分享
 * 后端接口
 * @author 
 * @email 
 * @date 2021-05-12 00:06:36
 */
@RestController
@RequestMapping("/xindefu")
public class XindefuController {
    @Autowired
    private XindefuService xindefuService;
    
    @Autowired
    private XindefuThumbsupService xindefuThumbsupService;
    
    @Autowired
    private XindefuCollectService xindefuCollectService;
    
    @Autowired
    private TokenService tokenService;
    
    @Autowired
    private HuiyuanService huiyuanService;
    
    @Autowired
    private javax.servlet.http.HttpServletRequest request;
    


    /**
     * 后端列表
     */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params,XindefuEntity xindefuEntity,
		HttpServletRequest request){
        EntityWrapper<XindefuEntity> ew = new EntityWrapper<XindefuEntity>();
		PageUtils page = xindefuService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, xindefuEntity), params), params));

        return R.ok().put("data", page);
    }
    
    /**
     * 前端列表
     */
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params,XindefuEntity xindefuEntity, 
		HttpServletRequest request){
        EntityWrapper<XindefuEntity> ew = new EntityWrapper<XindefuEntity>();
		PageUtils page = xindefuService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, xindefuEntity), params), params));
        
        // 获取当前登录用户的点赞状态
        String username = (String) request.getSession().getAttribute("username");
        if(username != null && page != null && page.getList() != null) {
            List<XindefuEntity> list = (List<XindefuEntity>) page.getList();
            for(XindefuEntity entity : list) {
                EntityWrapper<XindefuThumbsupEntity> thumbsupWrapper = new EntityWrapper<>();
                thumbsupWrapper.eq("xindefu_id", entity.getId());
                thumbsupWrapper.eq("huiyuanzhanghao", username);
                long count = xindefuThumbsupService.selectCount(thumbsupWrapper);
                entity.setHasThumbsup(count > 0);
            }
        }
        
        return R.ok().put("data", page);
    }

	/**
     * 列表
     */
    @RequestMapping("/lists")
    public R list( XindefuEntity xindefuEntity){
       	EntityWrapper<XindefuEntity> ew = new EntityWrapper<XindefuEntity>();
      	ew.allEq(MPUtil.allEQMapPre( xindefuEntity, "xindefu")); 
        return R.ok().put("data", xindefuService.selectListView(ew));
    }

	 /**
     * 查询
     */
    @RequestMapping("/query")
    public R query(XindefuEntity xindefuEntity){
        EntityWrapper< XindefuEntity> ew = new EntityWrapper< XindefuEntity>();
 		ew.allEq(MPUtil.allEQMapPre( xindefuEntity, "xindefu")); 
		XindefuView xindefuView =  xindefuService.selectView(ew);
		return R.ok("查询健身心得分享成功").put("data", xindefuView);
    }
	
    /**
     * 后端详情
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id){
        XindefuEntity xindefu = xindefuService.selectById(id);
        if(xindefu != null) {
            // 增加浏览量
            xindefu.setClicknum(xindefu.getClicknum() + 1);
            xindefuService.updateById(xindefu);
            
            // 检查当前用户是否点赞
            String username = (String) request.getSession().getAttribute("username");
            if(username != null) {
                EntityWrapper<XindefuThumbsupEntity> thumbsupWrapper = new EntityWrapper<>();
                thumbsupWrapper.eq("xindefu_id", id);
                thumbsupWrapper.eq("huiyuanzhanghao", username);
                long count = xindefuThumbsupService.selectCount(thumbsupWrapper);
                xindefu.setHasThumbsup(count > 0);
            }
        }
        return R.ok().put("data", xindefu);
    }

    /**
     * 前端详情
     */
    @RequestMapping("/detail/{id}")
    public R detail(@PathVariable("id") Long id){
        XindefuEntity xindefu = xindefuService.selectById(id);
        if(xindefu != null) {
            // 增加浏览量
            xindefu.setClicknum(xindefu.getClicknum() + 1);
            xindefuService.updateById(xindefu);
            
            // 检查当前用户是否点赞
            String username = (String) request.getSession().getAttribute("username");
            if(username != null) {
                EntityWrapper<XindefuThumbsupEntity> thumbsupWrapper = new EntityWrapper<>();
                thumbsupWrapper.eq("xindefu_id", id);
                thumbsupWrapper.eq("huiyuanzhanghao", username);
                long count = xindefuThumbsupService.selectCount(thumbsupWrapper);
                xindefu.setHasThumbsup(count > 0);
            }
        }
        return R.ok().put("data", xindefu);
    }
    
    /**
     * 获取分类列表
     */
    @RequestMapping("/fenleiList")
    public R fenleiList() {
        List<String> fenleiList = new ArrayList<>();
        fenleiList.add("增肌");
        fenleiList.add("减脂");
        fenleiList.add("塑形");
        fenleiList.add("营养恢复");
        fenleiList.add("训练心得");
        fenleiList.add("器材使用");
        fenleiList.add("其他");
        return R.ok().put("data", fenleiList);
    }


    /**
     * 后端保存
     */
    @RequestMapping("/save")
    public R save(@RequestBody XindefuEntity xindefuEntity, HttpServletRequest request){
    	xindefuEntity.setId(new Date().getTime()+new Double(Math.floor(Math.random()*1000)).longValue());
    	xindefuEntity.setFabushijian(new Date());
    	xindefuEntity.setThumbsupnum(0);
    	xindefuEntity.setClicknum(0);
    	//ValidatorUtils.validateEntity(xindefuEntity);
        xindefuService.insert(xindefuEntity);
        return R.ok();
    }
    
    /**
     * 前端保存
     */
    @RequestMapping("/add")
    public R add(@RequestBody XindefuEntity xindefuEntity, HttpServletRequest request){
    	xindefuEntity.setId(new Date().getTime()+new Double(Math.floor(Math.random()*1000)).longValue());
    	xindefuEntity.setFabushijian(new Date());
    	xindefuEntity.setThumbsupnum(0);
    	xindefuEntity.setClicknum(0);
    	
    	// 获取当前登录会员信息
    	String tableName = (String) request.getSession().getAttribute("tableName");
    	String username = (String) request.getSession().getAttribute("username");
    	
    	// 只有会员才能发布
    	if("huiyuan".equals(tableName) && username != null) {
    	    // 查询会员信息获取姓名
    	    EntityWrapper<HuiyuanEntity> wrapper = new EntityWrapper<>();
    	    wrapper.eq("huiyuanzhanghao", username);
    	    HuiyuanEntity huiyuan = huiyuanService.selectOne(wrapper);
    	    if(huiyuan != null) {
    	        xindefuEntity.setFabuzhanghao(huiyuan.getHuiyuanzhanghao());
    	        xindefuEntity.setFabuxingming(huiyuan.getHuiyuanxingming());
    	    } else {
    	        // 如果没查到，直接用username
    	        xindefuEntity.setFabuzhanghao(username);
    	        xindefuEntity.setFabuxingming(username);
    	    }
    	}
    	
    	//ValidatorUtils.validateEntity(xindefuEntity);
        xindefuService.insert(xindefuEntity);
        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    public R update(@RequestBody XindefuEntity xindefuEntity, HttpServletRequest request){
        //ValidatorUtils.validateEntity(xindefuEntity);
        // 权限校验：会员只能修改自己发布的心得
        String tableName = (String) request.getSession().getAttribute("tableName");
        String username = (String) request.getSession().getAttribute("username");
        if ("huiyuan".equals(tableName) && username != null) {
            XindefuEntity original = xindefuService.selectById(xindefuEntity.getId());
            if (original == null) {
                return R.error("心得不存在");
            }
            if (!username.equals(original.getFabuzhanghao())) {
                return R.error("无权修改他人发布的心得");
            }
        }
        xindefuService.updateById(xindefuEntity);//全部更新
        return R.ok();
    }
    
    /**
     * 点赞
     */
    @RequestMapping("/thumbsup/{id}")
    public R thumbsup(@PathVariable("id") Long id, HttpServletRequest request){
        String username = (String) request.getSession().getAttribute("username");
        if(username == null) {
            return R.error("请先登录");
        }
        
        // 检查是否已经点赞
        EntityWrapper<XindefuThumbsupEntity> wrapper = new EntityWrapper<>();
        wrapper.eq("xindefu_id", id);
        wrapper.eq("huiyuanzhanghao", username);
        XindefuThumbsupEntity existingThumbsup = xindefuThumbsupService.selectOne(wrapper);
        
        XindefuEntity xindefu = xindefuService.selectById(id);
        if(xindefu == null) {
            return R.error("心得不存在");
        }
        
        if(existingThumbsup != null) {
            // 取消点赞
            xindefuThumbsupService.deleteById(existingThumbsup.getId());
            xindefu.setThumbsupnum(xindefu.getThumbsupnum() - 1);
            xindefuService.updateById(xindefu);
            return R.ok("取消点赞成功");
        } else {
            // 点赞
            XindefuThumbsupEntity thumbsup = new XindefuThumbsupEntity();
            thumbsup.setId(new Date().getTime() + new Double(Math.floor(Math.random()*1000)).longValue());
            thumbsup.setXindefuId(id);
            thumbsup.setHuiyuanzhanghao(username);
            thumbsup.setAddtime(new Date());
            xindefuThumbsupService.insert(thumbsup);
            xindefu.setThumbsupnum(xindefu.getThumbsupnum() + 1);
            xindefuService.updateById(xindefu);
            return R.ok("点赞成功");
        }
    }
    
    /**
     * 收藏/取消收藏
     */
    @RequestMapping("/collect/{id}")
    public R collect(@PathVariable("id") Long id, HttpServletRequest request){
        String username = (String) request.getSession().getAttribute("username");
        if(username == null) {
            return R.error("请先登录");
        }
        
        // 检查是否已经收藏
        EntityWrapper<XindefuCollectEntity> wrapper = new EntityWrapper<>();
        wrapper.eq("xindefu_id", id);
        wrapper.eq("huiyuanzhanghao", username);
        XindefuCollectEntity existingCollect = xindefuCollectService.selectOne(wrapper);
        
        XindefuEntity xindefu = xindefuService.selectById(id);
        if(xindefu == null) {
            return R.error("心得不存在");
        }
        
        if(existingCollect != null) {
            // 取消收藏
            xindefuCollectService.deleteById(existingCollect.getId());
            xindefu.setCollectnum(xindefu.getCollectnum() != null && xindefu.getCollectnum() > 0 ? xindefu.getCollectnum() - 1 : 0);
            xindefuService.updateById(xindefu);
            return R.ok("取消收藏成功");
        } else {
            // 收藏
            XindefuCollectEntity collect = new XindefuCollectEntity();
            collect.setXindefuId(id);
            collect.setHuiyuanzhanghao(username);
            collect.setAddtime(new Date());
            xindefuCollectService.insert(collect);
            xindefu.setCollectnum(xindefu.getCollectnum() != null ? xindefu.getCollectnum() + 1 : 1);
            xindefuService.updateById(xindefu);
            return R.ok("收藏成功");
        }
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody Long[] ids, HttpServletRequest request){
        // 权限校验：会员只能删除自己发布的心得
        String tableName = (String) request.getSession().getAttribute("tableName");
        String username = (String) request.getSession().getAttribute("username");
        if ("huiyuan".equals(tableName) && username != null) {
            for (Long id : ids) {
                XindefuEntity xindefu = xindefuService.selectById(id);
                if (xindefu != null && !username.equals(xindefu.getFabuzhanghao())) {
                    return R.error("无权删除他人发布的心得");
                }
            }
        }
        xindefuService.deleteBatchIds(Arrays.asList(ids));
        return R.ok();
    }
    
    /**
     * 提醒接口
     */
	@RequestMapping("/remind/{columnName}/{type}")
	public R remindCount(@PathVariable("columnName") String columnName, HttpServletRequest request, 
						 @PathVariable("type") String type,@RequestParam Map<String, Object> map) {
		map.put("column", columnName);
		map.put("type", type);
		
		if(type.equals("2")) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar c = Calendar.getInstance();
			Date remindStartDate = null;
			Date remindEndDate = null;
			if(map.get("remindstart")!=null) {
				Integer remindStart = Integer.parseInt(map.get("remindstart").toString());
				c.setTime(new Date()); 
				c.add(Calendar.DAY_OF_MONTH,remindStart);
				remindStartDate = c.getTime();
				map.put("remindstart", sdf.format(remindStartDate));
			}
			if(map.get("remindend")!=null) {
				Integer remindEnd = Integer.parseInt(map.get("remindend").toString());
				c.setTime(new Date());
				c.add(Calendar.DAY_OF_MONTH,remindEnd);
				remindEndDate = c.getTime();
				map.put("remindend", sdf.format(remindEndDate));
			}
		}
		
		Wrapper<XindefuEntity> wrapper = new EntityWrapper<XindefuEntity>();
		if(map.get("remindstart")!=null) {
			wrapper.ge(columnName, map.get("remindstart"));
		}
		if(map.get("remindend")!=null) {
			wrapper.le(columnName, map.get("remindend"));
		}

		String tableName = request.getSession().getAttribute("tableName").toString();
		if(tableName.equals("huiyuan")) {
			wrapper.eq("fabuzhanghao", (String)request.getSession().getAttribute("username"));
		}

		int count = xindefuService.selectCount(wrapper);
		return R.ok().put("count", count);
	}
	
	/**
	 * 我的列表
	 */
	@RequestMapping("/myList")
	public R myList(@RequestParam Map<String, Object> params, XindefuEntity xindefuEntity, HttpServletRequest request) {
	    String tableName = (String) request.getSession().getAttribute("tableName");
	    String username = (String) request.getSession().getAttribute("username");
	    if(username == null) {
	        return R.error("请先登录");
	    }
	    // 设置发布账号过滤条件
	    if("huiyuan".equals(tableName)) {
	        xindefuEntity.setFabuzhanghao(username);
	    }
        EntityWrapper<XindefuEntity> ew = new EntityWrapper<XindefuEntity>();
        params.put("sort", "fabushijian");
        params.put("order", "desc");
		PageUtils page = xindefuService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, xindefuEntity), params), params));
        return R.ok().put("data", page);
	}

}
