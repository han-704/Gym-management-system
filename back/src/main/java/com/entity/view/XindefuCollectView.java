package com.entity.view;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableName;
import lombok.Data;
import java.util.Date;
import java.util.List;

import com.entity.XindefuEntity;
import com.entity.XindefuCollectEntity;

/**
 * 健身心得收藏视图
 * 包含收藏记录和关联的心得详情
 * @author 
 * @email 
 * @date 2021-05-12 00:06:36
 */
@Data
@TableName("xindefu_collect")
public class XindefuCollectView extends XindefuCollectEntity {
    
    @TableField(exist = false)
    private XindefuEntity xindefu;
    
    /**
     * 获取心得详情，如果为空则返回新实例
     */
    public XindefuEntity getXindefu() {
        if (xindefu == null) {
            xindefu = new XindefuEntity();
        }
        return xindefu;
    }
    
}
