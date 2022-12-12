package com.ruoyi.system.controller;

import java.util.List;
import java.util.concurrent.TimeUnit;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.common.annotation.DelPassCache;
import com.ruoyi.common.core.redis.RedisCache;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.FitnessTestScore;
import com.ruoyi.system.service.IFitnessTestScoreService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 体测成绩Controller
 *
 * @author leftHand
 * @date 2022-10-18
 */
@RestController
@RequestMapping("/system/fitness_score")
public class FitnessTestScoreController extends BaseController
{
    @Autowired
    private IFitnessTestScoreService fitnessTestScoreService;

    @Autowired
    private RedisCache redisCache;

    @Autowired
    private RabbitTemplate rabbitTemplate;


    /**
     * 查询体测成绩列表
     */
    @PreAuthorize("@ss.hasPermi('system:fitness_score:list')")
    @GetMapping("/list")
    public TableDataInfo list(FitnessTestScore fitnessTestScore)
    {
        startPage();
        List<FitnessTestScore> list = fitnessTestScoreService.selectFitnessTestScoreList(fitnessTestScore);
        return getDataTable(list);
    }

    /**
     * 导出体测成绩列表
     */
    @PreAuthorize("@ss.hasPermi('system:fitness_score:export')")
    @Log(title = "体测成绩", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, FitnessTestScore fitnessTestScore)
    {
        List<FitnessTestScore> list = fitnessTestScoreService.selectFitnessTestScoreList(fitnessTestScore);
        ExcelUtil<FitnessTestScore> util = new ExcelUtil<FitnessTestScore>(FitnessTestScore.class);
        util.exportExcel(response, list, "体测成绩数据");
    }

    /**
     * 获取体测成绩详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:fitness_score:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return AjaxResult.success(fitnessTestScoreService.selectFitnessTestScoreById(id));
    }

    /**
     * 新增体测成绩
     */
    @PreAuthorize("@ss.hasPermi('system:fitness_score:add')")
    @Log(title = "体测成绩", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody FitnessTestScore fitnessTestScore)
    {
        return toAjax(fitnessTestScoreService.insertFitnessTestScore(fitnessTestScore));
    }

    /**
     * 修改体测成绩
     */
    @PreAuthorize("@ss.hasPermi('system:fitness_score:edit')")
    @DelPassCache
    @Log(title = "体测成绩", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody FitnessTestScore fitnessTestScore)
    {
        return toAjax(fitnessTestScoreService.updateFitnessTestScore(fitnessTestScore));
    }

    /**
     * 删除体测成绩
     */
    @PreAuthorize("@ss.hasPermi('system:fitness_score:remove')")
    @Log(title = "体测成绩", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(fitnessTestScoreService.deleteFitnessTestScoreByIds(ids));
    }

    @Log(title = "刷新计算体测成绩", businessType = BusinessType.UPDATE)
    @GetMapping("/refresh")
    public AjaxResult refresh() {
        // 状态字： 0->刷新中， 1 -> 完成
        Integer status = redisCache.getCacheObject("fitness:score:refresh");
        if (status == null) {
            redisCache.setCacheObject("fitness:score:refresh", 0, 3000, TimeUnit.SECONDS);
            // 发送异步刷新消息
            rabbitTemplate.convertAndSend("refreshScore", "");
            return AjaxResult.success("已请求刷新");
        } else if (status == 0){
            return AjaxResult.error("正在刷新中");
        } else {
            return AjaxResult.success("刷新成功");
        }

    }
}
