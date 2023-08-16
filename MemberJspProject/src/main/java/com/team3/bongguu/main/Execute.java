package com.team3.bongguu.main;

// 처리되는 것 잡다한 코드를 추가적으로 처리하기 위해서.
// 1. 실행되는 클래스 확인
// 2. 넘어가는 데이터 확인
// 3. 실행 결과 데이터 확인
// 4. 실행 시간 확인
// 5. 권한 처리

public class Execute {

	// Controller에서 실행한 Service를 new해서 넣어준다. 그리고 실행에 필요한 데이터(obj)도 넣어준다.
	public static Object run(Service service, Object obj) throws Exception{
		
		System.out.println("#########################################################################");
		// 1. 실행되는 클래스 확인
		System.out.println("# 실행 객체 : " + service.getClass().getSimpleName());
		// 2. 넘어가는 데이터 확인
		System.out.println("# 넘어가는 데이터 : " + obj);
		// 4. 실행시간을 위한 시작 시간
		long start = System.nanoTime();
		
		// 호출해서 실행한다.
		Object result = service.service(obj);
		
		// 3. 실행 결과 데이터 확인
		System.out.println("# 실행 결과 데이터 : " + result);
		
		long end = System.nanoTime();
		
		// 4. 실행 시간 확인
		System.out.println("# 실행 시간 : " + (end - start) + " ns");
		
		System.out.println("#########################################################################");
		return result;
	}
	
}
