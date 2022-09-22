package com.ruoyi.system.controller;


import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.system.domain.Vo.GameInsertVo;
import com.ruoyi.system.domain.Vo.GameResultVo;

import com.ruoyi.system.mapper.SportGamesMapper;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
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
@Api("运动会信息管理")
@RestController
@RequestMapping("/system/games")
public class SportGamesController extends BaseController {
    @Autowired
    private ISportGamesService sportGamesService;

    @Autowired
    private SportGamesMapper sportGamesMapper;

    /**
     * 获取报名比赛的必要信息
     */
    @PreAuthorize("@ss.hasPermi('system:games:query')")
    @GetMapping(value = "/register")
    public AjaxResult getRegisterInfo() {
        return AjaxResult.success(sportGamesService.selectSportGamesRegisterDict());
    }

    /**
     * 获取比赛字典信息
     */
    @PreAuthorize("@ss.hasPermi('system:games:query')")
    @GetMapping(value = "/dict")
    public AjaxResult getInfo() {
        return AjaxResult.success(sportGamesService.selectSportGamesDict());
    }

    /**
     * 查询比赛管理列表
     */
    @PreAuthorize("@ss.hasPermi('system:games:list')")
    @GetMapping("/list")
    public TableDataInfo list(SportGames sportGames) {
        startPage();
        List<SportGames> list = sportGamesService.selectSportGamesList(sportGames);
        return getDataTable(list);
    }

    /**
     * 根据比赛ID查询具体比赛结果
     */
    @ApiOperation("根据比赛id查询比赛结果")
    @PreAuthorize("@ss.hasPermi('system:games:list')")
    @GetMapping("/single/{id}")
    public AjaxResult SelectGameResultByGameId(@PathVariable Long id) {
        if (null == id) {
            return AjaxResult.error("请传入比赛Id");
        }
        List<GameResultVo> gameResultVos = sportGamesService.selectGameResultByGameId(id);
        return AjaxResult.success(gameResultVos);
    }

    /**
     * 根据比赛id查询待记录分数人员
     */
    @ApiOperation("根据比赛id查询待记录分数人员")
    @PreAuthorize("@ss.hasPermi('system:games:list')")
    @GetMapping("/insert/{gameId}")
    public TableDataInfo SelectGameInsertVoByGameId(@PathVariable Long gameId) {
        if (null == gameId) {
            throw new ServiceException("请选择比赛项目");
        }
        startPage();
        List<GameInsertVo> gameInsertVos = sportGamesService.SelectGameInsertVoByGameId(gameId);
        return getDataTable(gameInsertVos);
    }


    /**
     * 导出比赛管理列表
     */
    @PreAuthorize("@ss.hasPermi('system:games:export')")
    @Log(title = "比赛管理", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, SportGames sportGames) {
        List<SportGames> list = sportGamesService.selectSportGamesList(sportGames);
        ExcelUtil<SportGames> util = new ExcelUtil<SportGames>(SportGames.class);
        util.exportExcel(response, list, "比赛管理数据");
    }


    /**
     * 获取比赛字典信息
     */
    @PreAuthorize("@ss.hasPermi('system:games:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getDict(@PathVariable("id") Long id) {
        return AjaxResult.success(sportGamesService.selectSportGamesById(id));
    }

    /**
     * 新增比赛管理
     */
    @PreAuthorize("@ss.hasPermi('system:games:add')")
    @Log(title = "比赛管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody SportGames sportGames) {
        return toAjax(sportGamesService.insertSportGames(sportGames));
    }

    /**
     * 修改比赛管理
     */
    @PreAuthorize("@ss.hasPermi('system:games:edit')")
    @Log(title = "比赛管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody SportGames sportGames) {
        return toAjax(sportGamesService.updateSportGames(sportGames));
    }

    /**
     * 删除比赛管理
     */
    @PreAuthorize("@ss.hasPermi('system:games:remove')")
    @Log(title = "比赛管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids) {
        return toAjax(sportGamesService.deleteSportGamesByIds(ids));
    }


    /**
     * 查询比赛分类后的列表
     */
    @PreAuthorize("@ss.hasPermi('system:games:list')")
    @GetMapping("/game-order")
    public TableDataInfo listView(Map<String, Integer> mp) {
        Integer type = mp.get("type");
        List<SportGames> list = null;
        // 田赛
        if (type.equals(1)) {
            list = sportGamesMapper.selectFieldGames();
        // 径赛
        } else if (type.equals(2)){
            list = sportGamesMapper.selectTrackGames();
        // 团体赛
        } else if (type.equals(3)) {
            list = sportGamesMapper.selectGroupGames();
        }

        return getDataTable(list);
    }
}
