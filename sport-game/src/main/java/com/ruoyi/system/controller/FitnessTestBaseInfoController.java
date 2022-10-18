package com.ruoyi.system.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;
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
import com.ruoyi.system.domain.FitnessTestBaseInfo;
import com.ruoyi.system.service.IFitnessTestBaseInfoService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 用户信息Controller
 * 
 * @author leftHand
 * @date 2022-10-17
 */
@RestController
@RequestMapping("/system/fitness_info")
public class FitnessTestBaseInfoController extends BaseController
{
    @Autowired
    private IFitnessTestBaseInfoService fitnessTestBaseInfoService;

    /**
     * 查询用户信息列表
     */
    @PreAuthorize("@ss.hasPermi('system:fitness_info:list')")
    @GetMapping("/list")
    public TableDataInfo list(FitnessTestBaseInfo fitnessTestBaseInfo)
    {
        startPage();
        List<FitnessTestBaseInfo> list = fitnessTestBaseInfoService.selectFitnessTestBaseInfoList(fitnessTestBaseInfo);
        return getDataTable(list);
    }

    /**
     * 导出用户信息列表
     */
    @PreAuthorize("@ss.hasPermi('system:fitness_info:export')")
    @Log(title = "用户信息", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, FitnessTestBaseInfo fitnessTestBaseInfo)
    {
        List<FitnessTestBaseInfo> list = fitnessTestBaseInfoService.selectFitnessTestBaseInfoList(fitnessTestBaseInfo);
        ExcelUtil<FitnessTestBaseInfo> util = new ExcelUtil<FitnessTestBaseInfo>(FitnessTestBaseInfo.class);
        util.exportExcel(response, list, "用户信息数据");
    }

    /**
     * 获取用户信息详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:fitness_info:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return AjaxResult.success(fitnessTestBaseInfoService.selectFitnessTestBaseInfoById(id));
    }

    /**
     * 新增用户信息
     */
    @PreAuthorize("@ss.hasPermi('system:fitness_info:add')")
    @Log(title = "用户信息", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody FitnessTestBaseInfo fitnessTestBaseInfo)
    {
        return toAjax(fitnessTestBaseInfoService.insertFitnessTestBaseInfo(fitnessTestBaseInfo));
    }

    /**
     * 修改用户信息
     */
    @PreAuthorize("@ss.hasPermi('system:fitness_info:edit')")
    @Log(title = "用户信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody FitnessTestBaseInfo fitnessTestBaseInfo)
    {
        return toAjax(fitnessTestBaseInfoService.updateFitnessTestBaseInfo(fitnessTestBaseInfo));
    }

    /**
     * 删除用户信息
     */
    @PreAuthorize("@ss.hasPermi('system:fitness_info:remove')")
    @Log(title = "用户信息", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(fitnessTestBaseInfoService.deleteFitnessTestBaseInfoByIds(ids));
    }
}
