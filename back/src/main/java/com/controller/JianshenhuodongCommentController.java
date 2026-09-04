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

import com.entity.JianshenhuodongCommentEntity;
import com.entity.view.JianshenhuodongCommentView;

import com.service.JianshenhuodongCommentService;
import com.service.TokenService;
import com.utils.PageUtils;
import com.utils.R;
import com.utils.MD5Util;
import com.utils.MPUtil;
import com.utils.CommonUtil;


/**
 * 健身活动评论
 * 后端接口
 * @author 
 * @email 
 * @date 2021-05-12 00:06:36
 */
@RestController
@RequestMapping("/jianshenhuodongComment")
public class JianshenhuodongCommentController {
    @Autowired
    private JianshenhuodongCommentService jianshenhuodongCommentService;
    


    /**
     * 后端列表
     */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params,JianshenhuodongCommentEntity jianshenhuodongComment,
		HttpServletRequest request){
		String tableName = request.getSession().getAttribute("tableName").toString();
		if(tableName.equals("huiyuan")) {
			jianshenhuodongComment.setHuiyuanzhanghao((String)request.getSession().getAttribute("username"));
		}
        EntityWrapper<JianshenhuodongCommentEntity> ew = new EntityWrapper<JianshenhuodongCommentEntity>();
		PageUtils page = jianshenhuodongCommentService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, jianshenhuodongComment), params), params));

        return R.ok().put("data", page);
    }
    
    /**
     * 前端列表
     */
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params,JianshenhuodongCommentEntity jianshenhuodongComment, 
		HttpServletRequest request){
        EntityWrapper<JianshenhuodongCommentEntity> ew = new EntityWrapper<JianshenhuodongCommentEntity>();
		PageUtils page = jianshenhuodongCommentService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, jianshenhuodongComment), params), params));
        return R.ok().put("data", page);
    }

	/**
     * 列表
     */
    @RequestMapping("/lists")
    public R list( JianshenhuodongCommentEntity jianshenhuodongComment){
       	EntityWrapper<JianshenhuodongCommentEntity> ew = new EntityWrapper<JianshenhuodongCommentEntity>();
      	ew.allEq(MPUtil.allEQMapPre( jianshenhuodongComment, "jianshenhuodongComment")); 
        return R.ok().put("data", jianshenhuodongCommentService.selectListView(ew));
    }

	 /**
     * 查询
     */
    @RequestMapping("/query")
    public R query(JianshenhuodongCommentEntity jianshenhuodongComment){
        EntityWrapper< JianshenhuodongCommentEntity> ew = new EntityWrapper< JianshenhuodongCommentEntity>();
 		ew.allEq(MPUtil.allEQMapPre( jianshenhuodongComment, "jianshenhuodongComment")); 
		JianshenhuodongCommentView jianshenhuodongCommentView =  jianshenhuodongCommentService.selectView(ew);
		return R.ok("查询健身活动评论成功").put("data", jianshenhuodongCommentView);
    }
	
    /**
     * 后端详情
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id){
        JianshenhuodongCommentEntity jianshenhuodongComment = jianshenhuodongCommentService.selectById(id);
        return R.ok().put("data", jianshenhuodongComment);
    }

    /**
     * 前端详情
     */
    @RequestMapping("/detail/{id}")
    public R detail(@PathVariable("id") Long id){
        JianshenhuodongCommentEntity jianshenhuodongComment = jianshenhuodongCommentService.selectById(id);
        return R.ok().put("data", jianshenhuodongComment);
    }
    
    /**
     * 根据健身活动id查询评论
     */
    @RequestMapping("/listByJianshenhuodongId")
    public R listByJianshenhuodongId(@RequestParam Long jianshenhuodongId) {
        EntityWrapper<JianshenhuodongCommentEntity> ew = new EntityWrapper<JianshenhuodongCommentEntity>();
        ew.eq("jianshenhuodong_id", jianshenhuodongId);
        ew.orderBy("pinglunshijian", false);
        List<JianshenhuodongCommentEntity> list = jianshenhuodongCommentService.selectListView(ew);
        return R.ok().put("data", list);
    }


    /**
     * 后端保存
     */
    @RequestMapping("/save")
    public R save(@RequestBody JianshenhuodongCommentEntity jianshenhuodongComment, HttpServletRequest request){
    	jianshenhuodongComment.setId(new Date().getTime()+new Double(Math.floor(Math.random()*1000)).longValue());
    	jianshenhuodongComment.setPinglunshijian(new Date());
    	//ValidatorUtils.validateEntity(jianshenhuodongComment);
        jianshenhuodongCommentService.insert(jianshenhuodongComment);
        return R.ok();
    }
    
    /**
     * 前端保存
     */
    @RequestMapping("/add")
    public R add(@RequestBody JianshenhuodongCommentEntity jianshenhuodongComment, HttpServletRequest request){
    	jianshenhuodongComment.setId(new Date().getTime()+new Double(Math.floor(Math.random()*1000)).longValue());
    	jianshenhuodongComment.setPinglunshijian(new Date());
    	//ValidatorUtils.validateEntity(jianshenhuodongComment);
        jianshenhuodongCommentService.insert(jianshenhuodongComment);
        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    public R update(@RequestBody JianshenhuodongCommentEntity jianshenhuodongComment, HttpServletRequest request){
        //ValidatorUtils.validateEntity(jianshenhuodongComment);
        jianshenhuodongCommentService.updateById(jianshenhuodongComment);//全部更新
        return R.ok();
    }
    

    /**
     * 删除
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody Long[] ids){
        jianshenhuodongCommentService.deleteBatchIds(Arrays.asList(ids));
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
		
		Wrapper<JianshenhuodongCommentEntity> wrapper = new EntityWrapper<JianshenhuodongCommentEntity>();
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

		int count = jianshenhuodongCommentService.selectCount(wrapper);
		return R.ok().put("count", count);
	}
	
	


}
