package com.cooltrade.product.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cooltrade.product.model.service.ProductService;
import com.cooltrade.product.model.vo.Images;
import com.cooltrade.product.model.vo.Product;

/**
 * Servlet implementation class DetilProductViewController
 */
@WebServlet("/detail.po")
public class DetailProductViewController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DetailProductViewController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int pno = Integer.parseInt(request.getParameter("pno"));
		
		// 1. 조회수 증가
		int result = new ProductService().increaseCount(pno);
		
		// 2. 조회수 증가하면 성공
		if(result>0) {
			Product p = new ProductService().selectProductDetail(pno); 
			ArrayList<Images> imglist = new ProductService().selectImages(pno);
			request.setAttribute("p", p);
			request.setAttribute("imglist",	imglist);
			request.getRequestDispatcher("views/product/productDetailView.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}