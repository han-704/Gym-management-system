package com.controller;

import java.util.Map;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.utils.Query;

import com.entity.XindefuCollectEntity;
import com.entity.view.XindefuCollectView;

import com.service.XindefuCollectService;
import com.utils.PageUtils;
import com.utils.R;
import com.utils.MPUtil;


/**
 * 健身心得收藏
 * 后端接口
 * @author 
 * @email 
 * @date 2021-05-12 00:06:36
 */
@RestController
@RequestMapping("/xindefuCollect")
public class XindefuCollectController {
    @Autowired
    private XindefuCollectService xindefuCollectService;
    
    @Autowired
    private javax.servlet.http.HttpServletRequest request;
    

    /**
     * 后端分页列表（返回包含心得详情的收藏列表）
     */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params,XindefuCollectEntity xindefuCollectEntity, 
		HttpServletRequest request){
        EntityWrapper<XindefuCollectEntity> ew = new EntityWrapper<XindefuCollectEntity>();
        
        // 如果传了huiyuanzhanghao参数，按用户名过滤
        if(params.get("huiyuanzhanghao") != null && !"".equals(params.get("huiyuanzhanghao").toString())) {
            ew.eq("huiyuanzhanghao", params.get("huiyuanzhanghao").toString());
        }
        
        // 使用联表查询获取收藏列表及心得详情
        PageUtils page = xindefuCollectService.queryPageWithDetail(params, ew);

        return R.ok().put("data", page);
    }
    
    /**
     * 列表
     */
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params,XindefuCollectEntity xindefuCollectEntity, 
		HttpServletRequest request){
        EntityWrapper<XindefuCollectEntity> ew = new EntityWrapper<XindefuCollectEntity>();
        
        // 如果传了xindefuId参数，按心得ID过滤
        if(params.get("xindefuId") != null && !"".equals(params.get("xindefuId").toString())) {
            ew.eq("xindefu_id", Long.parseLong(params.get("xindefuId").toString()));
        }
        
		PageUtils page = xindefuCollectService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, xindefuCollectEntity), params), params));

        return R.ok().put("data", page);
    }
    
    /**
     * 检查是否已收藏（根据心得ID和用户名）
     */
    @RequestMapping("/check")
    public R check(@RequestParam("xindefuId") Long xindefuId, @RequestParam("huiyuanzhanghao") String huiyuanzhanghao) {
        EntityWrapper<XindefuCollectEntity> wrapper = new EntityWrapper<>();
        wrapper.eq("xindefu_id", xindefuId);
        wrapper.eq("huiyuanzhanghao", huiyuanzhanghao);
        XindefuCollectEntity collect = xindefuCollectService.selectOne(wrapper);
        return R.ok().put("data", collect != null);
    }

	/**
     * 查询
     */
    @RequestMapping("/query")
    public R query(XindefuCollectEntity xindefuCollectEntity){
        EntityWrapper< XindefuCollectEntity> ew = new EntityWrapper< XindefuCollectEntity>();
 		 ew.allEq(MPUtil.allEQMapPre( xindefuCollectEntity, "xindefuCollect")); 
		XindefuCollectEntity xindefuCollect = xindefuCollectService.selectOne(ew);
		return R.ok("查询健身心得收藏成功").put("data", xindefuCollect);
    }

    /**
     * 后端详情
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id){
        XindefuCollectEntity xindefuCollect = xindefuCollectService.selectById(id);

        return R.ok().put("data", xindefuCollect);
    }

    /**
     * 后端保存
     */
    @RequestMapping("/save")
    public R save(@RequestBody XindefuCollectEntity xindefuCollectEntity, HttpServletRequest request){
     xindefuCollectEntity.setId(new Date().getTime()+new Double(Math.floor(Math.random()*1000)).longValue());
     xindefuCollectEntity.setAddtime(new Date());
        xindefuCollectService.insert(xindefuCollectEntity);
        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    public R update(@RequestBody XindefuCollectEntity xindefuCollectEntity, HttpServletRequest request){
        xindefuCollectService.updateById(xindefuCollectEntity);//全部更新
        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody Long[] ids){
        xindefuCollectService.deleteBatchIds(java.util.Arrays.asList(ids));
        return R.ok();
    }

}
