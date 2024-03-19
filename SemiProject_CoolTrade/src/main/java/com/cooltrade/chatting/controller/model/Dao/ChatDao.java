package com.cooltrade.chatting.controller.model.Dao;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import static com.cooltrade.common.JDBCTemplate.*;

import com.cooltrade.chatting.controller.model.vo.Chat;
import com.cooltrade.chatting.controller.model.vo.ChatRoom;
import com.cooltrade.member.model.dao.MemberDao;

public class ChatDao {
	private Properties prop = new Properties();
	
	public ChatDao() {
		String filePath = MemberDao.class.getResource("/db/sql/chat-mapper.xml").getPath();
		try {
			prop.loadFromXML(new FileInputStream(filePath));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public int countChatRoom(Connection conn,String userId, String pno) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		ResultSet rset = null;
		
		String sql = prop.getProperty("countChatRoom");
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userId);
			pstmt.setString(2, pno);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				result = rset.getInt("count");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		return result;
		
	}
	
	public int createChatRoom(Connection conn,String userId, String pno) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("createChatRoom");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			pstmt.setString(2, pno);
			
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}
	
	public int getChatRoomNo(Connection conn, String userId, String pno) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("getChatRoomNo");
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userId);
			pstmt.setString(2, pno);
			
			rset = pstmt.executeQuery();
			if(rset.next()) {
				result = rset.getInt("chatroom_no");
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt); 
		}
		return result;
		
	}
	
	public ArrayList<Chat> getMessage(Connection conn, int chatRoomNo){
		ArrayList<Chat> list = new ArrayList<Chat>();
		Chat c = null;
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("getMessage");
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, chatRoomNo);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				list.add(new Chat(rset.getInt("message_no"),
								  rset.getString("message"),
								  rset.getDate("message_date"),
								  rset.getString("read_yn"),
								  rset.getInt("chatroom_no"),
								  rset.getString("sender")
								  ));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}
	public int insertMessage(Connection conn, String userId,String message, int chatRoomNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("insertMessage");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, message);
			pstmt.setInt(2, chatRoomNo);
			pstmt.setString(3, userId);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}
	
	public ArrayList<ChatRoom> getChatRoomList(Connection conn) {
		ArrayList<ChatRoom> list = new ArrayList<ChatRoom>();
		ChatRoom c = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("getChatRoomList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				list.add(new ChatRoom(rset.getInt("chatroom_no"),
									  rset.getString("chatroom_title"),
									  rset.getString("chatroom_status"),
									  rset.getString("user_id"),
									  rset.getString("seller_id")
									  ));
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		return list;
		
	}
	
	public String[] getChatRoomInfo(Connection conn,int chatRoomNo) {
		String[] userInfo = new String[2];
		PreparedStatement pstmt = null;
		
		ResultSet rset = null;
		
		String sql = prop.getProperty("getChatRoomInfo");
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, chatRoomNo);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				userInfo[0] = rset.getString("user_id");
				userInfo[1] = rset.getString("seller_id");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		return userInfo;
	}
}