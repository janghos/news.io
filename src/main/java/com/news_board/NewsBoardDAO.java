package com.news_board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;

import com.Vo.CommentVo;
import com.Vo.NewsVo;
import com.Vo.ReporterVo;
import com.Vo.UserVo;



@Component
public class NewsBoardDAO {
	final String JDBC_DRIVER = "org.h2.Driver";
	final String JDBC_URL = "jdbc:h2:tcp://localhost/~/jwbookdb";
	
	// DB 연결을 가져오는 메서드, DBCP를 사용하는 것이 좋음
	public Connection open() {
		Connection conn = null;
		try {
			Class.forName(JDBC_DRIVER);
			conn = DriverManager.getConnection(JDBC_URL,"jwbook","1234");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
	
	//C(insert)  //Reporter
	public void addNews(NewsVo n) throws Exception {
		Connection conn = open();
		
		String sql = "insert into news(TITLE, WRITER, CONTENT, IMG, DATE,HIT) values(?,?,?,?,CURRENT_TIMESTAMP(),0)";
	    
	
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		try(conn; pstmt) {
			pstmt.setString(1, n.getTitle());
			pstmt.setString(2, n.getWriter());
			pstmt.setString(3, n.getContent());
			pstmt.setString(4, n.getImg());
			pstmt.executeUpdate();			
		}
	}
	
	//R (ListAll)
	public List<NewsVo> listAll() throws SQLException{		
		Connection conn = open();
		List<NewsVo> list = new ArrayList<>();
		
		String sql = "SELECT AID,TITLE, WRITER, PARSEDATETIME(DATE,'yyyy-MM-dd hh:mm:ss'),img,content,hit AS CDATE FROM NEWS";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		try(conn; pstmt; rs){
			while(rs.next()) {
				NewsVo n = new NewsVo();
				n.setAid(rs.getInt("aid"));
				n.setTitle(rs.getString("title"));
				n.setWriter(rs.getString("writer"));				
				n.setDate(rs.getString("cdate"));
				n.setImg(rs.getString("img"));
				n.setContent(rs.getString("content"));
				n.setHit(rs.getInt("hit"));
				
				list.add(n);
			}
			return list;
		}
	}
	
	//상세 리스트
	public NewsVo getNews(int aid) throws SQLException {
		Connection conn = open();
		
		NewsVo n = new NewsVo();
		String sql = "select aid, title,writer, img, PARSEDATETIME(date,'yyyy-MM-dd hh:mm:ss') as cdate, content,comment,hit from news where aid=?";
	    
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setInt(1, aid);
		ResultSet rs = pstmt.executeQuery();
		
		rs.next();
		
		try(conn; pstmt; rs) {
			int count = rs.getInt("hit");
			n.setAid(rs.getInt("aid"));
			n.setTitle(rs.getString("title"));
			n.setWriter(rs.getString("writer"));
			n.setImg(rs.getString("img"));
			n.setDate(rs.getString("cdate"));
			n.setContent(rs.getString("content"));
			n.setComment(rs.getString("comment"));
			n.setHit(count);
			pstmt.executeQuery();
			return n;
			
		}
	}
	
	//삭제
	public void deleteNews(int aid) throws SQLException {
		Connection conn = open();
		
		String sql = "DELETE FROM NEWS WHERE AID=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		try(conn; pstmt){
			pstmt.setInt(1, aid);
			// 삭제된 뉴스 기사가 없을 경우
			if(pstmt.executeUpdate() == 0) {
				throw new SQLException("DB에러");
			}
			
		}
		
		
	}
	
	//뉴스수정
	public void receNews(NewsVo n, int aid) throws Exception {
		Connection conn = open();
		String sql = "UPDATE news SET title=?, img=?,content=?  WHERE aid= ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);

		try (conn; pstmt) {
			pstmt.setString(1, n.getTitle());
			pstmt.setString(2, n.getImg());
			pstmt.setString(3, n.getContent());
			pstmt.setInt(4, aid);

			pstmt.executeUpdate();
		}

	}
	
	//댓글 가져오기
		public List<CommentVo> getCommentAll(int aid) throws Exception {
			Connection conn = open();
			List<CommentVo> commentList = new ArrayList<>();
			
			String sql = "select id,com from comment where aid=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, aid);
			ResultSet rs = pstmt.executeQuery();
			
			try(conn; pstmt; rs) {
				while(rs.next()) {
					CommentVo c = new CommentVo();
					c.setId(rs.getString("id"));
					c.setCom(rs.getString("com")); 
					
					commentList.add(c);
				}
				return commentList;			
			}
		}
		
		
		//댓글 추가 
		public void commentAdd(CommentVo c) throws Exception {
			Connection conn = open();
			
			String sql = "insert into comment(id,com,aid) values(?,?,?)";
			PreparedStatement pstmt = conn.prepareStatement(sql);
		
			try(conn; pstmt) {
				pstmt.setString(1, c.getId());
				pstmt.setString(2, c.getCom());
				pstmt.setString(3, c.getAid());
				pstmt.executeUpdate();			
			}
		}
	
	
		// 회원가입-reporter
		public void r_join(ReporterVo reporter) throws Exception {
			Connection conn = open();

			String sql = "insert into Reporter(r_name, r_id, r_pw,r_email,r_birthday,r_group,r_phonenumber) values(?,?,?,?,?,?,?)";

			PreparedStatement pstmt = conn.prepareStatement(sql);

			try (conn; pstmt) {
				pstmt.setString(1, reporter.getR_name());
				pstmt.setString(2, reporter.getR_id());
				pstmt.setString(3, reporter.getR_pw());
				pstmt.setString(4, reporter.getR_email());
				pstmt.setString(5, reporter.getR_birthday());
				pstmt.setString(6, reporter.getR_group());
				pstmt.setString(7, reporter.getR_phonenumber());

				pstmt.executeUpdate();
			}
		}

		// 회원가입- user

		public void u_join(UserVo user) throws Exception {
			Connection conn = open();

			String sql = "insert into User(u_name, u_id, u_pw,u_email,u_birthday,u_phonenumber) values(?,?,?,?,?,?)";

			PreparedStatement pstmt = conn.prepareStatement(sql);

			try (conn; pstmt) {
				pstmt.setString(1, user.getU_name());
				pstmt.setString(2, user.getU_id());
				pstmt.setString(3, user.getU_pw());
				pstmt.setString(4, user.getU_email());
				pstmt.setString(5, user.getU_birthday());
				pstmt.setString(6, user.getU_phonenumber());

				pstmt.executeUpdate();
			}
		}

	//조회수 증가
		public void addHit(int aid) throws SQLException {
			Connection conn = open();
			String sql = "UPDATE news set hit=hit+1 where aid=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			try(conn; pstmt) {
				pstmt.setInt(1, aid);
				//조회할 데이터가 없을 경우
				if(pstmt.executeUpdate() == 0) {
					throw new SQLException("DB에러");
				}
				
			}
		}
		
		// 로그인 - reporter
		public boolean r_login(ReporterVo r) throws Exception {
			Connection conn = open();
			String sql = "select r_name from reporter where r_id=? and r_pw=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, r.getR_id());
			pstmt.setString(2, r.getR_pw());
			ResultSet rs = pstmt.executeQuery();
			try (conn; pstmt; rs) {

				if (rs.next() == true) {
					return true; // 로그인 성공
				} else {
					return false; // 회원가입 안 됨
				}
			}
		}

		// 로그인 - user
		public boolean u_login(UserVo u) throws Exception {
			Connection conn = open();
			String sql = "select u_name from user where u_id=? and u_pw=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, u.getU_id());
			pstmt.setString(2, u.getU_pw());
			ResultSet rs = pstmt.executeQuery();
			try (conn; pstmt; rs) {

				if (rs.next() == true) {
					return true; // 로그인 성공
				} else {
					return false; // 회원가입 안 됨
				}
			}
		}
		
		//개인정보수정 - reporter
		public void r_modify(ReporterVo rm) throws Exception {
			Connection conn= open();
			String sql = "UPDATE Reporter SET r_name=?,r_pw=?,r_email=?,r_birthday=?,r_group=?,r_phonenumber=?  where r_id=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			
			try(conn; pstmt){
				pstmt.setString(1, rm.getR_name());
				pstmt.setString(2, rm.getR_pw());
				pstmt.setString(3, rm.getR_email());
				pstmt.setString(4, rm.getR_birthday());
				pstmt.setString(5, rm.getR_group());
				pstmt.setString(6, rm.getR_phonenumber());
				pstmt.setString(7, rm.getR_id());
				
				pstmt.executeUpdate();
			}
		
		}
		
		//개인정보 수정 - user
		public void u_modify(UserVo um) throws Exception {
			Connection conn= open();
			String sql = "UPDATE User SET u_name=?,u_pw=?,u_email=?,u_birthday=?,u_phonenumber=?  where u_id=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			
			try(conn; pstmt){
				pstmt.setString(1, um.getU_name());
				pstmt.setString(2, um.getU_pw());
				pstmt.setString(3, um.getU_email());
				pstmt.setString(4, um.getU_birthday());
				pstmt.setString(5, um.getU_phonenumber());
				pstmt.setString(6, um.getU_id());
				
				pstmt.executeUpdate();
			}
		
		}
		
		//기자 회원정보 가져오기
		public List<ReporterVo> repoterAll() throws SQLException{		
			Connection conn = open();
			List<ReporterVo> reporterList = new ArrayList<>();
			
			String sql = "select r_name,r_id,r_pw,r_email,r_birthday,r_group,r_phonenumber from reporter";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			
			try(conn; pstmt; rs){
				while(rs.next()) {
					ReporterVo n = new ReporterVo();
					n.setR_name(rs.getString("r_name"));
					n.setR_id(rs.getString("r_id"));
					n.setR_pw(rs.getString("r_pw"));				
					n.setR_birthday(rs.getString("r_birthday"));
					n.setR_group(rs.getString("r_group"));
					n.setR_phonenumber(rs.getString("r_phonenumber"));					
					
					reporterList.add(n);
				}
				return reporterList;
			}
		}
		
		//일반 회원정보 가져오기
		public List<UserVo> userAll() throws SQLException{		
			Connection conn = open();
			List<UserVo> userList = new ArrayList<>();
			
			String sql = "select u_name,u_id,u_pw,u_birthday,u_phonenumber from user";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			
			try(conn; pstmt; rs){
				while(rs.next()) {
					UserVo u = new UserVo();
					u.setU_name(rs.getString("u_name"));
					u.setU_id(rs.getString("u_id"));
					u.setU_pw(rs.getString("u_pw"));				
					u.setU_birthday(rs.getString("u_birthday"));
					u.setU_phonenumber(rs.getString("u_phonenumber"));					
					
					userList.add(u);
				}
				return userList;
			}
		}
		
	
}
	
	
	
	
	
	
	
	
	
