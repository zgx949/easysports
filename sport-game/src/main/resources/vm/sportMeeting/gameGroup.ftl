<w:tr>
    <w:tblPrEx>
        <w:tblCellMar>
            <w:top w:w="0" w:type="dxa" />
            <w:left w:w="108" w:type="dxa" />
            <w:bottom w:w="0" w:type="dxa" />
            <w:right w:w="108" w:type="dxa" />
        </w:tblCellMar>
    </w:tblPrEx>
    <w:trPr>
        <w:trHeight w:val="440" w:h-rule="atLeast" />
    </w:trPr>
    <w:tc>
        <w:tcPr>
            <w:tcW w:w="10160" w:type="dxa" />
            <w:shd w:val="clear" w:color="auto" w:fill="auto" />
            <w:noWrap w:val="0" />
            <w:vAlign w:val="top" />
        </w:tcPr>
        <w:p>
            <w:pPr>
                <w:jc w:val="center" />
                <w:rPr>
                    <w:rFonts w:ascii="宋体" w:h-ansi="宋体" w:fareast="宋体" w:hint="default" />
                    <w:b />
                    <w:b-cs />
                    <w:sz w:val="24" />
                    <w:sz-cs w:val="24" />
                </w:rPr>
            </w:pPr>
            <w:r>
                <w:rPr>
                    <w:rFonts w:ascii="宋体" w:h-ansi="宋体" w:fareast="宋体" w:hint="fareast" />
                    <w:b />
                    <w:b-cs />
                    <w:sz w:val="24" />
                    <w:sz-cs w:val="24" />
                </w:rPr>
                <w:t>${itemType}</w:t>
            </w:r>
        </w:p>
    </w:tc>
</w:tr>
<#list games as game>
<w:tr>
    <w:tblPrEx>
        <w:tblCellMar>
            <w:top w:w="0" w:type="dxa" />
            <w:left w:w="108" w:type="dxa" />
            <w:bottom w:w="0" w:type="dxa" />
            <w:right w:w="108" w:type="dxa" />
        </w:tblCellMar>
    </w:tblPrEx>
    <w:trPr>
        <w:trHeight w:val="440" w:h-rule="atLeast" />
    </w:trPr>
    <w:tc>
        <w:tcPr>
            <w:tcW w:w="10160" w:type="dxa" />
            <w:shd w:val="clear" w:color="auto" w:fill="auto" />
            <w:noWrap w:val="0" />
            <w:vAlign w:val="top" />
        </w:tcPr>
        <w:p>
            <w:pPr>
                <w:jc w:val="left" />
                <w:rPr>
                    <w:rFonts w:ascii="宋体" w:h-ansi="宋体" w:fareast="宋体" w:hint="default" />
                    <w:sz w:val="18" />
                </w:rPr>
            </w:pPr>
            <w:r>
                <w:rPr>
                    <w:rFonts w:ascii="宋体" w:h-ansi="宋体" w:fareast="宋体" w:hint="fareast" />
                    <w:sz w:val="18" />
                </w:rPr>
                <w:t></w:t>
            </w:r>
            <w:r>
                <w:rPr>
                    <w:rFonts w:ascii="宋体" w:h-ansi="宋体" w:fareast="宋体" w:hint="default" />
                    <w:sz w:val="18" />
                    <w:lang w:val="EN-US" />
                </w:rPr>
                <w:t>${'\t\t'}${game.index}</w:t>
            </w:r>
            <w:r>
                <w:rPr>
                    <w:rFonts w:ascii="宋体" w:h-ansi="宋体" w:fareast="宋体" w:hint="fareast" />
                    <w:sz w:val="18" />
                </w:rPr>
                <w:t>、${game.gameName}</w:t>
            </w:r>

        </w:p>
    </w:tc>
</w:tr>
</#list>
