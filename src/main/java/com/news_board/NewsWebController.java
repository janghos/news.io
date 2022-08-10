package com.news_board;

import java.io.File;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.Vo.CommentVo;
import com.Vo.NewsVo;
import com.Vo.ReporterVo;
import com.Vo.UserVo;

@Controller
@RequestMapping("/news")
public class NewsWebController {
	final NewsBoardDAO dao;
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Value("${news.imgdir}")
	String fdir;

	@Autowired
	public NewsWebController(NewsBoardDAO dao) {
		this.dao = dao;
	}

	// 리스트 등록
	@PostMapping("/add")
	public String addNews(@ModelAttribute NewsVo news, Model m, @RequestParam("file") MultipartFile file) {
		try {
			// 저장 파일 객체 생성
			File dest = new File(fdir + "/" + file.getOriginalFilename());

			// 파일 저장
			file.transferTo(dest);

			// NewsVo 객체에 파일 이름 저장
			news.setImg("/img/" + dest.getName());
			dao.addNews(news);
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("뉴스 등록 과정 문제 발생");
			m.addAttribute("error", "뉴스 정상 등록 실패");
		}
		return "redirect:/news/list";
	}

	// 리스트 가져오기
	@GetMapping("/list")
	public String Newslist(Model m) {
		List<NewsVo> list;
		try {
			list = dao.listAll();
			m.addAttribute("newslist", list);
		} catch (Exception e) {
			e.printStackTrace();
			logger.warn("뉴스 목록 생성 과정에서 문제 발생!!");
			m.addAttribute("error", "뉴스 목록이 정상적으로 처리되지 않았습니다!!");
		}
		return "news/newsList";
	}

	// 게시물 하나 가져오기
	@GetMapping("/{aid}")
	public String getNews(@PathVariable int aid, Model m) {
		List<NewsVo> lists;
		try {
			lists = dao.listAll();
			NewsVo n = dao.getNews(aid);
			m.addAttribute("news", n);
			m.addAttribute("newslist", lists);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.warn("뉴스를 가져오는 과정에서 문제 발생!!");
			m.addAttribute("error", "뉴스를 정상적으로 가져오지 못했습니다!!");
		}
		List<CommentVo> list;
		try {
			list = dao.getCommentAll(aid);
			m.addAttribute("commentList", list);
		} catch (Exception e) {
			e.printStackTrace();
			logger.warn("댓글 목록 생성 과정에서 문제 발생!!");
			m.addAttribute("error", "댓글 목록이 정상적으로 처리되지 않았습니다!!");
		}
		return "news/newsView";
	}

	// 뉴스 조회수 // 조회수 위해서 뉴스 등록에 hit 0으로 초기 설정
	@GetMapping("/hit/{aid}")
	public String addHits(@PathVariable int aid) {
		try {
			dao.addHit(aid);
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("뉴스 등록 과정 문제 발생");
		}
		return "redirect:/news/{aid}";
	}

	// 수정할거니깐 데이터를 보내야함 >> rece/{aid}로 보냅니다.
	@PostMapping("/rece/{aid}")
	public String reNews(@PathVariable int aid, @ModelAttribute NewsVo news, Model m,
			@RequestParam("file") MultipartFile file) {
		try {
			// 저장 파일 객체 생성
			File dest = new File(fdir + "/" + file.getOriginalFilename());

			// 파일 저장
			file.transferTo(dest);

			// News 객체에 파일 이름 저장
			news.setImg("/img/" + dest.getName());
			dao.receNews(news, aid);

		} catch (Exception e) {
			e.printStackTrace();
			logger.info("뉴스 수정 과정에서 문제 발생!!");
			m.addAttribute("error", "뉴스가 정상적으로 등록되지 않았습니다!!");
		}
		return "redirect:/news/list";
	}

	// 댓글
	@PostMapping("/comment/{aid}")
	public String commentAdd(@ModelAttribute CommentVo comment, Model m) {
		try {
			dao.commentAdd(comment);
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("뉴스 댓글 등록 과정 문제 발생");
			m.addAttribute("error", "뉴스 댓글 등록 실패");
		}
		return "redirect:/news/{aid}";
	}

	// 삭제
	@GetMapping("/delete/{aid}")
	public String deleteNews(@PathVariable int aid, Model m) {
		try {
			dao.deleteNews(aid);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.warn("뉴스 삭제 과정에서 문제 발생!!");
			m.addAttribute("error", "뉴스가 정상적으로 삭제되지 않았습니다!!");
		}
		return "redirect:/news/list";
	}

	// 회원가입
	@PostMapping("/r_join")
	public String r_join(@ModelAttribute ReporterVo reporter, Model m) {
		try {
			dao.r_join(reporter);
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("회원가입(기자) 과정에서 문제 발생!");
			m.addAttribute("error", "회원가입(기자)이 정상적으로 수행되지 않았습니다!!");
		}
		return "news/newsLogin";
	}

	// user 로그인
	@PostMapping("/u_join")
	public String u_join(@ModelAttribute UserVo user, Model m) {
		try {
			dao.u_join(user);
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("회원가입(일반회원) 과정에서 문제 발생!");
			m.addAttribute("error", "회원가입(일반회원)이 정상적으로 수행되지 않았습니다!!");
		}
		return "news/newsLogin";
	}

	// 로그인 페이지
	@GetMapping("/login")
	public String login(Model m) {

		return "news/newsLogin";
	}

	// 로그인- 기자
	@PostMapping("/r_login")
	public String r_login(HttpSession session, @RequestParam("ID") String u_id, @RequestParam("ID") String r_id,
			@RequestParam("password") String r_pw, Model m) {
		ReporterVo r = new ReporterVo();//
		r.setR_id(r_id);
		r.setR_pw(r_pw);
		try {
			dao.r_login(r);
			boolean rs = dao.r_login(r);

			if (rs == true) {
				session.setAttribute("id", r_id);
				session.setAttribute("type", "reporter");
				return "redirect:/news/list"; // 로그인 성공하고 뉴스리스트로 넘어감.
			}
			if (rs == false) {
				return "redirect:/news/login"; // 로그인 화면으로 계속 머물러있음
			}

		} catch (Exception e) {
			e.printStackTrace();
			logger.warn("로그인(기자) 과정에서 문제 발생!");
			m.addAttribute("error", "로그인(기자)이 정상적으로 수행되지 않았습니다!!");
		}
		return "news/newsList";
	}

	// 로그인 - 일반회원
	@PostMapping("/u_login")
	public String u_login(HttpSession session, @RequestParam("ID") String u_id, @RequestParam("password") String u_pw,
			Model m) {
		UserVo u = new UserVo();
		u.setU_id(u_id);
		u.setU_pw(u_pw);
		try {
			dao.u_login(u);
			boolean rs = dao.u_login(u);
			if (rs == true) {
				session.setAttribute("id", u_id);
				session.setAttribute("type", "user");
				return "redirect:/news/list"; // 로그인 성공하고 뉴스리스트로 넘어감.
			}
			if (rs == false) {
				return "redirect:/news/login"; // 로그인 화면으로 계속 머물러있음
			}

		} catch (Exception e) {
			e.printStackTrace();
			logger.warn("로그인(일반회원) 과정에서 문제 발생!");
			m.addAttribute("error", "로그인(일반회원)이 정상적으로 수행되지 않았습니다!!");
		}
		return "news/newsLogin";
	}

	// 기자_회원가입 페이지
	@GetMapping("/signup_reporter")
	public String signup(Model m) {
		return "news/newsSignup_reporter";
	}

	// 일반회원_회원가입 페이지
	@GetMapping("/signup_user")
	public String signup_user(Model m) {

		return "news/newsSignup_user";
	}

	@GetMapping("/logout")
	public ModelAndView logout(HttpSession session) {
		ModelAndView mav = new ModelAndView();

		session.removeAttribute("id");
		session.removeAttribute("type");
		mav.setViewName("redirect:/news/list");

		return mav;
	}

	// 등록하기
	@GetMapping("/insert")
	public String insert() {

		return "news/newsInsert";
	}

	// 회원정보(기자) - 수정
	@PostMapping("/modify_Reporter/")
	public String modifyReporter(@ModelAttribute ReporterVo rm, Model m) {

		try {
			dao.r_modify(rm);

		} catch (Exception e) {
			e.printStackTrace();
			logger.info("개인정보(기자) 수정 과정에서 문제 발생!!");
			m.addAttribute("error", "뉴스가 정상적으로 ");
		}
		return "redirect:/news/login";
	}

	// 회원정보(일반회원) - 수정
	@PostMapping("/modify_User/")
	public String modifyUser(@ModelAttribute UserVo um, Model m) {

		try {
			dao.u_modify(um);

		} catch (Exception e) {
			e.printStackTrace();
			logger.info("개인정보(일반회원) 수정 과정에서 문제 발생!!");
			m.addAttribute("error", "뉴스가 정상적으로 ");
		}
		return "redirect:/news/login";
	}

	// 기자_회원정보 수정 페이지
	@GetMapping("/modify_Reporter")
	public String modify(Model m) {
		return "news/newsModify_repoter";
	}

	// 일반회원_회원정보 수정 페이지
	@GetMapping("/modify_user")
	public String modify_user(Model m) {

		return "news/newsModify_user";
	}

	// 회원정보 찾기 입력 페이지
	@GetMapping("/search")
	public String search(Model m) {

		return "fix/newsSearch";
	}

	// 정보찾는 과정
	@PostMapping("/search")
	public String search(HttpSession session, @RequestParam("ID") String u_id, @RequestParam("ID") String r_id,
			@RequestParam("password") String r_pw, Model m) {
		ReporterVo r = new ReporterVo();//
		r.setR_id(r_id);
		r.setR_pw(r_pw);
		try {
			dao.r_login(r);
			boolean rs = dao.r_login(r);

			if (rs == true) {
				session.setAttribute("id", r_id);
				session.setAttribute("type", "reporter");
				return "redirect:/news/search_c"; // 정보찾기 성공하고 정보보여주기로 넘어감.
			}
			if (rs == false) {
				return "redirect:/news/search"; // 정보찾기 화면으로 계속 머물러있음
			}

		} catch (Exception e) {
			e.printStackTrace();
			logger.warn("정보찾는 과정에서 문제 발생!");
			m.addAttribute("error", "정보찾기가 정상적으로 수행되지 않았습니다!!");
		}
		return "fix/newsSearch";
	}

	// 회원정보 찾기 출력 페이지
	@GetMapping("/search_c")
	public String search_c(Model m) {

		return "fix/newsSearch_C";
	}

	// 기자 아이디 중복체크
	@GetMapping("/readReporter")
	public String readReporter(Model m) {
		List<ReporterVo> list;
		try {
			list = dao.repoterAll();
			m.addAttribute("reporterList", list);
		} catch (Exception e) {
			e.printStackTrace();
			logger.warn("기자 계정 정보 불러오기 과정에서 문제 발생!!");
			m.addAttribute("error", "기자 계정 정보가 정상적으로 처리되지 않았습니다!!");
		}
		return "news/newsSignup_reporter";
	}
	
	//일반 아이디 중복체크
	@GetMapping("/readUser")
	public String readUser(Model m) {
		List<UserVo> list;
		try {
			list = dao.userAll();
			m.addAttribute("userList", list);
		} catch (Exception e) {
			e.printStackTrace();
			logger.warn("일반 계정 정보 불러오기 과정에서 문제 발생!!");
			m.addAttribute("error", "일반 계정 정보가 정상적으로 처리되지 않았습니다!!");
		}
		return "news/newsSignup_user";
	}

}
