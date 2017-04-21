<?php

if (!defined('BASEPATH')) exit('No direct script access allowed');
require_once 'PHPExcel.php';
require_once 'PHPExcel/Writer/Excel2007.php';

class Export_excel
{
    public $query;
    public $writeObj;
    public $phpexcelObj;
    public $activeSheet;

    public function __construct()
    {
        $this->phpexcelObj = new PHPExcel();
        $this->writeObj = new PHPExcel_Writer_Excel2007($this->phpexcelObj);
        $this->activeSheet = $this->phpexcelObj->getActiveSheet();
    }

    /**
     * 导出excel
     * @param  String $fileName 文件名
     * @return File           
     */
    public function output($fileName='')
    {
        $fileName = !empty($fileName) ? $fileName : date('YmdHis', time()) . '.xls';
        header("Pragma: public");
        header("Expires: 0");
        header("Cache-Control:must-revalidate, post-check=0, pre-check=0");
        header("Content-Type:application/force-download");
        header("Content-Type:application/vnd.ms-execl");
        header('Content-Type: application/vnd.ms-excel;charset=utf-8');
        header("Content-Type:application/octet-stream");
        header("Content-Type:application/download");
        header("Content-Disposition:attachment;filename=$fileName");
        header("Content-Transfer-Encoding:binary");
        $this->writeObj->save("php://output");
        exit;
    }


    public function excelDataByArray($datas ,$fileName='')
    {
        $colNum = array("A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z");
        foreach($datas as $k => $item)
        {
            foreach($item as $j => $v)
            {
                //设置当列数大于26的情况
                $length = floor(count($v) / 26);
                if($length > 0) 
                {
                    $lengthKey = $length-1;
                    $colPre = $colNum[$lengthKey];
                }else
                {
                    $colPre = '';
                }
                $rowKey = $k+1;
                $this->activeSheet->setCellValue($colPre.$colNum[$j].$rowKey ,$v);
            }
        }

        $this->output($fileName);
    }

    /**
     * 根据数据库查询资源QUERY导出数据
     *
     * @param $query
     * @param string $fileName
     */
    public function excelDataByQuery($query ,$fileName='')
    {
        if (!is_object($query) || !method_exists($query, 'list_fields'))
        {
            //这里的错误提示根据需要修改
            echoMsg(10013);
        }
        $contentArr[0] = $query->list_fields();
        $result        = $query->result_array();

        foreach($result as $k => $item)
        {
            $contentArr[$k+1] = $item;
        }

        $this->excelDataByArray($contentArr);
        
    }
}
