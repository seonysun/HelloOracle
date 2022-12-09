// VO : 데이터 저장 클래스
package com.sist.dao;
import java.util.*;
/*
 * VO(Value Object), DTO : 오라클에서 가지고 오는 데이터 저장 목적
 * Manager : 외부 데이터 읽기 -> 크롤링
 * Service : DAO 여러개 묶어서 한번에 처리
 * DAO : 테이블당 하나씩, 데이터베이스 연결
 * 
 * - VO : 테이블 1개에 대한 데이터 정의
 * 		ex. 사원 1명에 대한 데이터 브라우저로 전송 -> 변수 취급
 * 		- 오라클의 데이터형과 자바의 데이터형 매칭시켜야 함
 *			ex. empno NUMBER -> int
 *				ename VARCHAR2 -> String
 *				job VARCHAR2 -> String
 *				mgr NUMBER -> int
 *				hiredate DATE -> java.util.Date
 *				sal NUMBER -> int
 *				comm NUMBER -> int
 *				deptno NUMBER -> int
 */
public class EmpVO {
	private int empno,mgr,sal,comm,deptno;
	private String ename,job;
	private Date hiredate;
	private DeptVO dvo=new DeptVO(); //JOIN -> 여러 테이블 동시에 가져옴
	private SalGradeVO svo=new SalGradeVO(); //JOIN
	public SalGradeVO getSvo() {
		return svo;
	}
	public void setSvo(SalGradeVO svo) {
		this.svo = svo;
	}
	public DeptVO getDvo() {
		return dvo;
	}
	public void setDvo(DeptVO dvo) {
		this.dvo = dvo;
	}
	public int getEmpno() {
		return empno;
	}
	public void setEmpno(int empno) {
		this.empno = empno;
	}
	public int getMgr() {
		return mgr;
	}
	public void setMgr(int mgr) {
		this.mgr = mgr;
	}
	public int getSal() {
		return sal;
	}
	public void setSal(int sal) {
		this.sal = sal;
	}
	public int getComm() {
		return comm;
	}
	public void setComm(int comm) {
		this.comm = comm;
	}
	public int getDeptno() {
		return deptno;
	}
	public void setDeptno(int deptno) {
		this.deptno = deptno;
	}
	public String getEname() {
		return ename;
	}
	public void setEname(String ename) {
		this.ename = ename;
	}
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
	public Date getHiredate() {
		return hiredate;
	}
	public void setHiredate(Date hiredate) {
		this.hiredate = hiredate;
	}
}
