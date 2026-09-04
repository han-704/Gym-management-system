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

import com.entity.XindefuCommentEntity;
import com.entity.view.XindefuCommentView;
import com.entity.HuiyuanEntity;

import com.service.XindefuCommentService;
import com.service.TokenService;
import com.service.HuiyuanService;
import com.utils.PageUtils;
import com.utils.R;
import com.utils.MD5Util;
import com.utils.MPUtil;
import com.utils.CommonUtil;


/**
 * 健身心得评论
 * 后端接口
 * @author 
 * @email 
 * @date 2021-05-12 00:06:36
 */
@RestController
@RequestMapping("/xindefuComment")
public class XindefuCommentController {
    @Autowired
    private XindefuCommentService xindefuCommentService;
    
    @Autowired
    private TokenService tokenService;
    
    @Autowired
    private HuiyuanService huiyuanService;
    


    /**
     * 后端列表
     */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params,XindefuCommentEntity xindefuComment,
		HttpServletRequest request){
		String tableName = request.getSession().getAttribute("tableName").toString();
		if(tableName.equals("huiyuan")) {
			xindefuComment.setHuiyuanzhanghao((String)request.getSession().getAttribute("username"));
		}
        EntityWrapper<XindefuCommentEntity> ew = new EntityWrapper<XindefuCommentEntity>();
		PageUtils page = xindefuCommentService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, xindefuComment), params), params));

        return R.ok().put("data", page);
    }
    
    /**
     * 前端列表
     */
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params,XindefuCommentEntity xindefuComment, 
		HttpServletRequest request){
        EntityWrapper<XindefuCommentEntity> ew = new EntityWrapper<XindefuCommentEntity>();
		PageUtils page = xindefuCommentService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, xindefuComment), params), params));
        return R.ok().put("data", page);
    }

	/**
     * 列表
     */
    @RequestMapping("/lists")
    public R list( XindefuCommentEntity xindefuComment){
       	EntityWrapper<XindefuCommentEntity> ew = new EntityWrapper<XindefuCommentEntity>();
      	ew.allEq(MPUtil.allEQMapPre( xindefuComment, "xindefuComment")); 
        return R.ok().put("data", xindefuCommentService.selectListView(ew));
    }

	 /**
     * 查询
     */
    @RequestMapping("/query")
    public R query(XindefuCommentEntity xindefuComment){
        EntityWrapper< XindefuCommentEntity> ew = new EntityWrapper< XindefuCommentEntity>();
 		ew.allEq(MPUtil.allEQMapPre( xindefuComment, "xindefuComment")); 
		XindefuCommentView xindefuCommentView =  xindefuCommentService.selectView(ew);
		return R.ok("查询健身心得评论成功").put("data", xindefuCommentView);
    }
	
    /**
     * 后端详情
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id){
        XindefuCommentEntity xindefuComment = xindefuCommentService.selectById(id);
        return R.ok().put("data", xindefuComment);
    }

    /**
     * 前端详情
     */
    @RequestMapping("/detail/{id}")
    public R detail(@PathVariable("id") Long id){
        XindefuCommentEntity xindefuComment = xindefuCommentService.selectById(id);
        return R.ok().put("data", xindefuComment);
    }
    
    /**
     * 根据健身心得id查询评论
     */
    @RequestMapping("/listByXindefuId")
    public R listByXindefuId(@RequestParam Long xindefuId) {
        EntityWrapper<XindefuCommentEntity> ew = new EntityWrapper<>();
        ew.eq("xindefu_id", xindefuId);
        ew.orderBy("pinglunshijian", false);
        List<XindefuCommentEntity> list = xindefuCommentService.selectListView(ew);
        return R.ok().put("data", list);
    }


    /**
     * 后端保存
     */
    @RequestMapping("/save")
    public R save(@RequestBody XindefuCommentEntity xindefuComment, HttpServletRequest request){
    	xindefuComment.setId(new Date().getTime()+new Double(Math.floor(Math.random()*1000)).longValue());
    	xindefuComment.setPinglunshijian(new Date());
    	//ValidatorUtils.validateEntity(xindefuComment);
        xindefuCommentService.insert(xindefuComment);
        return R.ok();
    }
    
    /**
     * 前端保存
     */
    @RequestMapping("/add")
    public R add(@RequestBody XindefuCommentEntity xindefuComment, HttpServletRequest request){
    	xindefuComment.setId(new Date().getTime()+new Double(Math.floor(Math.random()*1000)).longValue());
    	xindefuComment.setPinglunshijian(new Date());
    	
    	// 获取当前登录会员信息
    	String tableName = (String) request.getSession().getAttribute("tableName");
    	String username = (String) request.getSession().getAttribute("username");
    	
    	// 只有会员才能评论
    	if("huiyuan".equals(tableName) && username != null) {
    	    // 查询会员信息获取姓名
    	    EntityWrapper<HuiyuanEntity> wrapper = new EntityWrapper<>();
    	    wrapper.eq("huiyuanzhanghao", username);
    	    HuiyuanEntity huiyuan = huiyuanService.selectOne(wrapper);
    	    if(huiyuan != null) {
    	        xindefuComment.setHuiyuanzhanghao(huiyuan.getHuiyuanzhanghao());
    	        xindefuComment.setHuiyuanxingming(huiyuan.getHuiyuanxingming());
    	    } else {
    	        // 如果没查到，直接用username
    	        xindefuComment.setHuiyuanzhanghao(username);
    	        xindefuComment.setHuiyuanxingming(username);
    	    }
    	}
    	
    	//ValidatorUtils.validateEntity(xindefuComment);
        xindefuCommentService.insert(xindefuComment);
        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    public R update(@RequestBody XindefuCommentEntity xindefuComment, HttpServletRequest request){
        //ValidatorUtils.validateEntity(xindefuComment);
        xindefuCommentService.updateById(xindefuComment);//全部更新
        return R.ok();
    }
    

    /**
     * 删除
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody Long[] ids){
        xindefuCommentService.deleteBatchIds(Arrays.asList(ids));
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
		
		Wrapper<XindefuCommentEntity> wrapper = new EntityWrapper<XindefuCommentEntity>();
		if(map.get("remindstart")!=null) {
			wrapper.ge(columnName, map.get("remindstart"));
		}
		if(map.get("remindend")!=null) {
			wrapper.le(columnName, map.get("remindend"));
		}

		String tableName = request.getSession().getAttribute("tableName").toString();
		if(tableName.equals("huiyuan")) {
			wrapper.eq("huiyuanzhanghao", (String)request.getSession().getAttribute("username"));
		}

		int count = xindefuCommentService.selectCount(wrapper);
		return R.ok().put("count", count);
	}
	
	


}
