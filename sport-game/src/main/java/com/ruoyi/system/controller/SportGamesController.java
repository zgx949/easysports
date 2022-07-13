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
import com.ruoyi.system.domain.SportGames;
import com.ruoyi.system.service.ISportGamesService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 比赛管理Controller
 *
 * @author ruoyi
 * @date 2022-07-05
 */
@RestController
@RequestMapping("/system/games")
public class SportGamesController extends BaseController
{
    @Autowired
    private ISportGamesService sportGamesService;

    /**
     * 获取报名比赛的必要信息
     */
    @PreAuthorize("@ss.hasPermi('system:games:query')")
    @GetMapping(value = "/register")
    public AjaxResult getRegisterInfo()
    {
        return AjaxResult.success(sportGamesService.selectSportGamesRegisterDict());
    }

    /**
     * 获取比赛字典信息
     */
    @PreAuthorize("@ss.hasPermi('system:games:query')")
    @GetMapping(value = "/dict")
    public AjaxResult getInfo()
    {
        return AjaxResult.success(sportGamesService.selectSportGamesDict());
    }

    /**
     * 查询比赛管理列表
     */
    @PreAuthorize("@ss.hasPermi('system:games:list')")
    @GetMapping("/list")
    public TableDataInfo list(SportGames sportGames)
    {
        startPage();
        List<SportGames> list = sportGamesService.selectSportGamesList(sportGames);
        return getDataTable(list);
    }

    /**
     * 导出比赛管理列表
     */
    @PreAuthorize("@ss.hasPermi('system:games:export')")
    @Log(title = "比赛管理", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, SportGames sportGames)
    {
        List<SportGames> list = sportGamesService.selectSportGamesList(sportGames);
        ExcelUtil<SportGames> util = new ExcelUtil<SportGames>(SportGames.class);
        util.exportExcel(response, list, "比赛管理数据");
    }


    /**
     * 获取比赛字典信息
     */
    @PreAuthorize("@ss.hasPermi('system:games:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getDict(@PathVariable("id") Long id)
    {
        return AjaxResult.success(sportGamesService.selectSportGamesById(id));
    }

    /**
     * 新增比赛管理
     */
    @PreAuthorize("@ss.hasPermi('system:games:add')")
    @Log(title = "比赛管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody SportGames sportGames)
    {
        return toAjax(sportGamesService.insertSportGames(sportGames));
    }

    /**
     * 修改比赛管理
     */
    @PreAuthorize("@ss.hasPermi('system:games:edit')")
    @Log(title = "比赛管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody SportGames sportGames)
    {
        return toAjax(sportGamesService.updateSportGames(sportGames));
    }

    /**
     * 删除比赛管理
     */
    @PreAuthorize("@ss.hasPermi('system:games:remove')")
    @Log(title = "比赛管理", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(sportGamesService.deleteSportGamesByIds(ids));
    }
}
