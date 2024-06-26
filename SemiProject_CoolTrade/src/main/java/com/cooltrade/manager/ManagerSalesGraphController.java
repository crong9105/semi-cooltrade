package com.cooltrade.manager;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cooltrade.product.model.dao.ProductDao;
import com.cooltrade.product.model.service.ProductService;
import com.cooltrade.product.model.vo.Product;
import com.google.gson.Gson;

/**
 * Servlet implementation class ManagerSalesGraphController
 */
@WebServlet("/salesgraph.me")
public class ManagerSalesGraphController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ManagerSalesGraphController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int chart = Integer.parseInt(request.getParameter("chart"));
		ArrayList<Product> list = new ArrayList<Product>();
		if(chart == 2) {
			 list = new ProductService().selectMonthSales();
		}else {
			 list = new ProductService().selectDaySales();
		}
		
		response.setContentType("application/json; charset=utf-8");
		new Gson().toJson(list,response.getWriter());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
