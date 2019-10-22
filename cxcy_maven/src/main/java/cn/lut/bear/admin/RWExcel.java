package cn.lut.bear.admin;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.*;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;


public class RWExcel {	
	public static int LastRowNum(String filepath,String sheetName){
		InputStream ins=null;
		Workbook wb = null;
		try {
			ins = new FileInputStream(filepath);
			wb = WorkbookFactory.create(ins); 
		} catch (FileNotFoundException e) {
			System.out.println("系统找不到指定的文件！");
			e.printStackTrace();
		}catch (InvalidFormatException e) {
			System.out.println("工作表格式错误！");
			e.printStackTrace();
		} catch (IOException e) {
			System.out.println("输入输出错误，请检查数据文件！");
			e.printStackTrace();
		}
		Sheet sheet = wb.getSheet(sheetName);
		try {
			ins.close();
		} catch (IOException e) {
			System.out.println("文件关闭失败！");
			e.printStackTrace();
		}
		return sheet.getLastRowNum();
	}
	public static List<Object[]> listQuery(String filepath,String sheetName, int startRow,int endRow,int startCol,int endCol)
	{
		InputStream ins=null;
		Workbook wb = null;
		try {
			ins = new FileInputStream(filepath);
			wb = WorkbookFactory.create(ins); 
		} catch (FileNotFoundException e) {
			System.out.println("系统找不到指定的文件！");
			e.printStackTrace();
		}catch (InvalidFormatException e) {
			System.out.println("工作表格式错误！");
			e.printStackTrace();
		} catch (IOException e) {
			System.out.println("输入输出错误，请检查数据文件！");
			e.printStackTrace();
		}		
		
		Sheet sheet = wb.getSheet(sheetName);
		
		List<Object[]> notes = new ArrayList<Object[]>();
		int i = 0;		
		for (i=startRow;i<=endRow;i++) {
			
			Row row = sheet.getRow(i-1);
								
			Object[] note = new Object[endCol-startCol+1];				
			 
			for (int colnum=startCol;colnum<=endCol;colnum++) {
				Cell cell = row.getCell(colnum-1);				
				
				//CellReference cellRef = new CellReference(row.getRowNum(), cell.getColumnIndex());
				//System.out.print(cellRef.formatAsString());
				//System.out.print(" - ");
				String cellValue="";
				switch(cell.getCellType()) {
					case Cell.CELL_TYPE_STRING:
						cellValue = cell.getRichStringCellValue().getString();											
						break;

					case Cell.CELL_TYPE_NUMERIC:
						if(DateUtil.isCellDateFormatted(cell)) {
							SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd");							
							cellValue = String.valueOf(sdf.format(cell.getDateCellValue()));
							
						} else {
							DecimalFormat df = new DecimalFormat("#.000000");
							cellValue = String.valueOf(df.format(cell.getNumericCellValue()));						
						}
						break;
						
					case Cell.CELL_TYPE_BOOLEAN:
						cellValue = String.valueOf(cell.getBooleanCellValue());
						break;
					case Cell.CELL_TYPE_FORMULA:
						cellValue = String.valueOf(cell.getNumericCellValue());
						//obj = cell.getCellFormula();
						break;
					case Cell.CELL_TYPE_BLANK:
						cellValue=" ";
						break;
					
					case Cell.CELL_TYPE_ERROR:
						break;
					default:
						break;
						
				}
				if(cellValue.trim().equals("")||cellValue.trim().length()<=0) 
					cellValue=" ";
				note[colnum-1] = cellValue;	
				//System.out.print(cellValue);
				//System.out.print("-");
			}
			
			notes.add(note);
		}	
		try {
			ins.close();
		} catch (IOException e) {
			System.out.println("文件关闭失败！");
			e.printStackTrace();
		}
		//System.out.println(notes.size());
		
		return notes;
	}
	//在网页中打开
	public static int createTable(String filePath,String sheetName,String title1,String title2,
			String [] columString,List<Object[]> notes,HttpServletRequest request,
			HttpServletResponse response,ServletOutputStream out) {
		response.reset();
		response.setHeader("content-disposition", "attachment;filename="+filePath);
		response.setContentType("application/msexcel");
		int r = 0; //行号
		Workbook wb = null;
		String fileType = filePath.substring(filePath.indexOf('.')+1);
		if (fileType.equals("xls")) {  
			wb = new HSSFWorkbook();  
		}else if(fileType.equals("xlsx"))  {  
			wb = new XSSFWorkbook();  
		} else {  
			System.out.println("您的文档格式不正确！");  
		}		  
		Sheet sheet = wb.createSheet(sheetName);		
		//创建第一行
	    Row row = sheet.createRow(r++); 
	    row.setHeightInPoints(35);//设置行高    单位像素
	    //生成字体对象
	    Font font = wb.createFont();
	    font.setFontHeightInPoints((short)18);
	    font.setFontName("黑体");
	    font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);    
	    //生成样式对象
	    CellStyle style = wb.createCellStyle();
	    style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	    style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
	    style.setFont(font);
	    Cell cell = row.createCell(0);
	    cell.setCellValue(title1);	    
	    sheet.addMergedRegion(new CellRangeAddress(0,0,0,columString.length/2-1));	    
	    cell.setCellStyle(style);	    
	    
	    if( !"".equals(title2) ) {
		    //创建第二行第一列
		    row = sheet.createRow(r++); 
		    row.setHeightInPoints(30);//设置行高
		    font = wb.createFont();
		    font.setFontHeightInPoints((short)12);
		    font.setFontName("黑体");        
		    style = wb.createCellStyle(); 
		    style.setAlignment(HSSFCellStyle.ALIGN_LEFT);
		    style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		    style.setFont(font);
		    cell = row.createCell(0);
		    cell.setCellValue(title2);
		    sheet.addMergedRegion(new CellRangeAddress(1,1,0,columString.length/2-1));    
		    
		    cell.setCellStyle(style);
		    
		    //创建第二行第E列
		    //cell = row.createCell(4);
		    //cell.setCellValue("金额单位:元");    
		    //cell.setCellStyle(style);	    
	    
		    //创建第3行
		    row = sheet.createRow(r++);
		    row.setHeightInPoints(25);//设置行高
		    font = wb.createFont();
		    font.setFontHeightInPoints((short)12);
		    font.setFontName("宋体");     
		    style = wb.createCellStyle();
		    style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		    style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		    style.setFont(font);
		    style.setWrapText(true);  //自动换行
		    style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		    style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		    style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		    style.setBorderRight(HSSFCellStyle.BORDER_THIN);	    
		    for(int i=0;i<columString.length/2;i++){
			    sheet.setColumnWidth(i,Integer.parseInt(columString[2*i+1]));
			    cell = row.createCell(i);	    
				cell.setCellValue(columString[2*i]);    
				cell.setCellStyle(style);
		    }
	    }else { 
	    	//创建第2行
		    row = sheet.createRow(r++);
		    row.setHeightInPoints(25);//设置行高
		    font = wb.createFont();
		    font.setFontHeightInPoints((short)12);
		    font.setFontName("宋体");     
		    style = wb.createCellStyle();
		    style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		    style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		    style.setFont(font);
		    style.setWrapText(true);  //自动换行
		    style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		    style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		    style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		    style.setBorderRight(HSSFCellStyle.BORDER_THIN);	    
		    for(int i=0;i<columString.length/2;i++){
			    sheet.setColumnWidth(i,Integer.parseInt(columString[2*i+1]));
			    cell = row.createCell(i);	    
				cell.setCellValue(columString[2*i]);    
				cell.setCellStyle(style);
		    }
	    }
	    
	    //插入数据
	    for (Iterator<Object[]> it = notes.iterator(); it.hasNext();) {	
			Object[] note = it.next();
			row = sheet.createRow(r++);
		    row.setHeightInPoints(25);//设置行高
		    font = wb.createFont();
		    font.setFontHeightInPoints((short)10);
		    font.setFontName("宋体");     
		    style = wb.createCellStyle();
		    style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		    style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		    style.setFont(font);
		    style.setWrapText(true);  //自动换行
		    style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		    style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		    style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		    style.setBorderRight(HSSFCellStyle.BORDER_THIN);
		    for(int i=0;i<columString.length/2;i++){			    
			    cell = row.createCell(i);
			    if(note[i] == null)
			    	cell.setCellValue("");
			    else
			    	cell.setCellValue(note[i].toString());
				cell.setCellStyle(style);
		    }
	    }
	   
		try {						
			wb.write(out);			
		} catch (FileNotFoundException e) {	
			System.out.println("打开Excel文件错误！");
			e.printStackTrace();
		} catch (IOException e) {
			System.out.println("读写Excel文件错误！");
			e.printStackTrace();
		}  finally{
			try {
				out.flush();
				out.close();
			} catch (IOException e) {
				System.out.println("关闭Excel文件错误！");
				e.printStackTrace();
			}
		}
	    		
	    return ("".equals(title2))?r-2:r-3;
		
	}
	//输出到excel文件中
	public static int createTable(String filePath,String sheetName,String title1,String title2,
			String [] columString,List<Object[]> notes){		
		int r = 0; //行号
		Workbook wb = null;
		String fileType = filePath.substring(filePath.indexOf('.')+1);
		if (fileType.equals("xls")) {  
			wb = new HSSFWorkbook();  
		}else if(fileType.equals("xlsx"))  {  
			wb = new XSSFWorkbook();  
		} else {  
			System.out.println("您的文档格式不正确！");  
		}		  
		Sheet sheet = wb.createSheet(sheetName);		
		//创建第一行
	    Row row = sheet.createRow(r++); 
	    row.setHeightInPoints(35);//设置行高    单位像素
	    //生成字体对象
	    Font font = wb.createFont();
	    font.setFontHeightInPoints((short)18);
	    font.setFontName("黑体");
	    font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);    
	    //生成样式对象
	    CellStyle style = wb.createCellStyle();
	    style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	    style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
	    style.setFont(font);
	    Cell cell = row.createCell(0);
	    cell.setCellValue(title1);	    
	    sheet.addMergedRegion(new CellRangeAddress(0,0,0,columString.length/2-1));	    
	    cell.setCellStyle(style);	    
	    
	    if( !"".equals(title2) ) {
		    //创建第二行第一列
		    row = sheet.createRow(r++); 
		    row.setHeightInPoints(30);//设置行高
		    font = wb.createFont();
		    font.setFontHeightInPoints((short)12);
		    font.setFontName("黑体");        
		    style = wb.createCellStyle(); 
		    style.setAlignment(HSSFCellStyle.ALIGN_LEFT);
		    style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		    style.setFont(font);
		    cell = row.createCell(0);
		    cell.setCellValue(title2);
		    sheet.addMergedRegion(new CellRangeAddress(1,1,0,columString.length/2-1));    
		    
		    cell.setCellStyle(style);
		    
		    //创建第二行第E列
		    //cell = row.createCell(4);
		    //cell.setCellValue("金额单位:元");    
		    //cell.setCellStyle(style);	    
	    
		    //创建第3行
		    row = sheet.createRow(r++);
		    row.setHeightInPoints(25);//设置行高
		    font = wb.createFont();
		    font.setFontHeightInPoints((short)12);
		    font.setFontName("宋体");     
		    style = wb.createCellStyle();
		    style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		    style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		    style.setFont(font);
		    style.setWrapText(true);  //自动换行
		    style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		    style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		    style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		    style.setBorderRight(HSSFCellStyle.BORDER_THIN);	    
		    for(int i=0;i<columString.length/2;i++){
			    sheet.setColumnWidth(i,Integer.parseInt(columString[2*i+1]));
			    cell = row.createCell(i);	    
				cell.setCellValue(columString[2*i]);    
				cell.setCellStyle(style);
		    }
	    }else { 
	    	//创建第2行
		    row = sheet.createRow(r++);
		    row.setHeightInPoints(25);//设置行高
		    font = wb.createFont();
		    font.setFontHeightInPoints((short)12);
		    font.setFontName("宋体");     
		    style = wb.createCellStyle();
		    style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		    style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		    style.setFont(font);
		    style.setWrapText(true);  //自动换行
		    style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		    style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		    style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		    style.setBorderRight(HSSFCellStyle.BORDER_THIN);	    
		    for(int i=0;i<columString.length/2;i++){
			    sheet.setColumnWidth(i,Integer.parseInt(columString[2*i+1]));
			    cell = row.createCell(i);	    
				cell.setCellValue(columString[2*i]);    
				cell.setCellStyle(style);
		    }
	    }
	    
	    //插入数据
	    for (Iterator<Object[]> it = notes.iterator(); it.hasNext();) {	
			Object[] note = it.next();
			row = sheet.createRow(r++);
		    row.setHeightInPoints(25);//设置行高
		    font = wb.createFont();
		    font.setFontHeightInPoints((short)10);
		    font.setFontName("宋体");     
		    style = wb.createCellStyle();
		    style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		    style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		    style.setFont(font);
		    style.setWrapText(true);  //自动换行
		    style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		    style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		    style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		    style.setBorderRight(HSSFCellStyle.BORDER_THIN);
		    for(int i=0;i<columString.length/2;i++){			    
			    cell = row.createCell(i);
			    if(note[i] == null)
			    	cell.setCellValue("");
			    else
			    	cell.setCellValue(note[i].toString());
				cell.setCellStyle(style);
		    }
	    }
	    FileOutputStream fileOut = null;
		try {
			fileOut = new FileOutputStream(filePath);
			wb.write(fileOut);						
		} catch (FileNotFoundException e) {	
			System.out.println("打开Excel文件错误！");
			e.printStackTrace();
		} catch (IOException e) {
			System.out.println("读写Excel文件错误！");
			e.printStackTrace();
		}  finally{
			try {
				fileOut.flush();
				fileOut.close();
			} catch (IOException e) {
				System.out.println("关闭Excel文件错误！");
				e.printStackTrace();
			}
		}
	    		
	    return ("".equals(title2))?r-2:r-3;
		
	}
	
/*	
	public static void main(String arg[]){
		
		int notes = 0;
		String[] str = {"立项年份","3000","项目级别","3000","项目编号","3000","项目名称","4000","项目类型","3000","项目负责人姓名","4500","项目负责人学号","4500","项目负责人联系方式","5500","参与学生人数","4000","项目其他成员信息","5500","指导教师姓名","4000","指导教师职称","4000","项目所属一级学科代码","6500","资助金额","3000","项目结题时间","4000","项目简介(200字以内)","20000"};
	    
		notes = createTable("c:\\信息表.xls","信息表","国家级大学生创新创业训练计划项目信息表","联系人：                 联系电话：              电子邮箱：  ","xls",str);
		//System.out.println(notes.size());		
				
	}
*/

}
