package com.ruoyi.system.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.utils.SecurityUtils;
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
import com.ruoyi.system.domain.FitnessTestActivity;
import com.ruoyi.system.service.IFitnessTestActivityService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 体测Controller
 *
 * @author leftHand
 * @date 2022-08-15
 */
@RestController
@RequestMapping("/system/activity")
public class FitnessTestActivityController extends BaseController
{
    @Autowired
    private IFitnessTestActivityService fitnessTestActivityService;

    /**
     * 查询体测列表
     */
    @PreAuthorize("@ss.hasPermi('system:activity:list')")
    @GetMapping("/list")
    public TableDataInfo list(FitnessTestActivity fitnessTestActivity)
    {
        startPage();
        List<FitnessTestActivity> list = fitnessTestActivityService.selectFitnessTestActivityList(fitnessTestActivity);
        return getDataTable(list);
    }

    /**
     * 导出体测列表
     */
    @PreAuthorize("@ss.hasPermi('system:activity:export')")
    @Log(title = "体测", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, FitnessTestActivity fitnessTestActivity)
    {
        List<FitnessTestActivity> list = fitnessTestActivityService.selectFitnessTestActivityList(fitnessTestActivity);
        ExcelUtil<FitnessTestActivity> util = new ExcelUtil<FitnessTestActivity>(FitnessTestActivity.class);
        util.exportExcel(response, list, "体测数据");
    }

    /**
     * 获取体测详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:activity:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return AjaxResult.success(fitnessTestActivityService.selectFitnessTestActivityById(id));
    }

    /**
     * 新增体测
     */
    @PreAuthorize("@ss.hasPermi('system:activity:add')")
    @Log(title = "体测", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody FitnessTestActivity fitnessTestActivity)
    {
        return toAjax(fitnessTestActivityService.insertFitnessTestActivity(fitnessTestActivity));
    }

    /**
     * 修改体测
     */
    @PreAuthorize("@ss.hasPermi('system:activity:edit')")
    @Log(title = "体测", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody FitnessTestActivity fitnessTestActivity)
    {
        return toAjax(fitnessTestActivityService.updateFitnessTestActivity(fitnessTestActivity));
    }

    /**
     * 删除体测
     */
    @PreAuthorize("@ss.hasPermi('system:activity:remove')")
    @Log(title = "体测", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(fitnessTestActivityService.deleteFitnessTestActivityByIds(ids));
    }
    /*
    * 查询进行中的体测活动
    *
    * */
    @GetMapping(value = "/testing")
    public AjaxResult testing()
    {
        FitnessTestActivity condition = new FitnessTestActivity();
        condition.setStatus(2L);
        return AjaxResult.success(fitnessTestActivityService.selectFitnessTestActivityList(condition));
    }

    @PreAuthorize("@ss.hasPermi('system:activity:query')")
    @GetMapping(value = "/dict")
    public AjaxResult getInfo()
    {
        return AjaxResult.success(fitnessTestActivityService.selectTestActivityDict());
    }
    @RequestMapping(value = "/signed")
    public AjaxResult querySignedAct() {
        SysUser user = SecurityUtils.getLoginUser().getUser();
        if (user != null) {
            return AjaxResult.success(fitnessTestActivityService.querySigned(user));
        } else {
            return AjaxResult.error("非法用户");
        }
    }
}
