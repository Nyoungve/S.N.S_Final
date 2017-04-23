package spring.util;

import org.springframework.ui.Model;

// 유틸 패키지 사용법
// wantPageSize(한 페이지에서 보여줄  DB의 record갯수 )와 
//wantPageBlock(한 페이지에서 보여지는 페이징 블럭 갯수) 만 지정
// ${blockCount} 계산된 페이지 블럭 개수
//  ${wantPageBlock} 사용자가 원하는 한 페이지에 보여줄 블럭 갯수 
// ${startPage} 시작 블럭 숫자 
// ${endPage}  끝 블럭 숫자


// view 에서 사용 예시
//<c:if test="${ 전체 글 수 지정하세요 > 0}">
//
//<c:if test="${startPage >wantPageBlock}">
//   
//     <a href="list.do?pageNum=${startPage - wantPageBlock}">[이전]</a>
//</c:if>
//
//<c:forEach var="i" begin="${startPage}" end="${endPage}">
//   
//    <a href="list.do?pageNum=${i}">
//    
//    <c:if test="${ i== pageNum}">
//    <b>[${i}]</b>
//    </c:if>
//    <c:if test="${ i != pageNum}">
//    [${i}]
//    </c:if>
//    
//    </a>
//</c:forEach>
//
//<c:if test="${endPage < blockCount}">
//   
//     <a href="list.do?pageNum=${startPage + wantPageBlock}">[다음]</a>
//     
//</c:if>
//</c:if>

public class PageingUtil {

	public static void pageing(Model model, int totalCount, int wantPageSize, int pageNum, int wantPageBlock) {

		int blockCount = totalCount / wantPageSize + (totalCount % wantPageSize == 0 ? 0 : 1);

		// 계산된 페이지 블럭 갯수
		model.addAttribute("blockCount", blockCount);

		// 내가 설정해서 페이지에 보여줄 페이징블럭 갯수

		int result = (pageNum - 1) / wantPageBlock;
		int startPage = result * wantPageBlock + 1;
		int endPage = startPage + wantPageBlock - 1;

		if (endPage > blockCount) {
			// 계산된 값이 실제 값보다 많은 경우
			endPage = blockCount;
		}

		model.addAttribute("wantPageBlock", wantPageBlock);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);

	}

}
