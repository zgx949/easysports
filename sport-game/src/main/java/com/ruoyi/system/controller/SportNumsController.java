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
import com.ruoyi.system.domain.SportNums;
import com.ruoyi.system.service.ISportNumsService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 号码段管理Controller
 * 
 * @author ruoyi
 * @date 2022-06-30
 */
@RestController
@RequestMapping("/system/nums")
public class SportNumsController extends BaseController
{
    @Autowired
    private ISportNumsService sportNumsService;

    /**
     * 查询号码段管理列表
     */
    @PreAuthorize("@ss.hasPermi('system:nums:list')")
    @GetMapping("/list")
    public TableDataInfo list(SportNums sportNums)
    {
        startPage();
        List<SportNums> list = sportNumsService.selectSportNumsList(sportNums);
        return getDataTable(list);
    }

    /**
     * 导出号码段管理列表
     */
    @PreAuthorize("@ss.hasPermi('system:nums:export')")
    @Log(title = "号码段管理", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, SportNums sportNums)
    {
        List<SportNums> list = sportNumsService.selectSportNumsList(sportNums);
        ExcelUtil<SportNums> util = new ExcelUtil<SportNums>(SportNums.class);
        util.exportExcel(response, list, "号码段管理数据");
    }

    /**
     * 获取号码段管理详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:nums:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return AjaxResult.success(sportNumsService.selectSportNumsById(id));
    }

    /**
     * 新增号码段管理
     */
    @PreAuthorize("@ss.hasPermi('system:nums:add')")
    @Log(title = "号码段管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody SportNums sportNums)
    {
        return toAjax(sportNumsService.insertSportNums(sportNums));
    }

    /**
     * 修改号码段管理
     */
    @PreAuthorize("@ss.hasPermi('system:nums:edit')")
    @Log(title = "号码段管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody SportNums sportNums)
    {
        return toAjax(sportNumsService.updateSportNums(sportNums));
    }

    /**
     * 删除号码段管理
     */
    @PreAuthorize("@ss.hasPermi('system:nums:remove')")
    @Log(title = "号码段管理", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(sportNumsService.deleteSportNumsByIds(ids));
    }
}
