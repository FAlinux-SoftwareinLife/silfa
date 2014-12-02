/**    
    @file     famap.h
    @date     2010/12/1
    @author   오재경 freefrug@falinux.com  FALinux.Co.,Ltd.
    @brief    mmap 유틸리티이다.
              Ver 0.1.0
              
    @modify   
    @todo     
    @bug     
    @remark   
    @warning   tmmap.c  tmmap.h 와는 같이 사용하지 않는다.
*/
//----------------------------------------------------------------------------

#ifndef _FA_MMAP_H_
#define _FA_MMAP_H_


#ifndef  PAGE_SIZE
#define  PAGE_SIZE  (1024*4)
#endif

/// mmap 를 위한 개별 관리 구조체
typedef struct {
	
	int            dev;         // /dev/mem 파일핸들
	unsigned long  phys;        // 물리주소
	unsigned long  size;        // 크기
	int            base_ofs;    // 베이스 주소가 4K 정렬이 되지 않았을때 사용

	void          *virt;        // 할당받은 메모리포인터
	
} mmap_alloc_t;

#ifdef __cplusplus 
extern "C" { 
#endif 	

extern void  *fa_mmap_alloc( mmap_alloc_t *ma, unsigned long phys_base, unsigned long size );
extern void   fa_mmap_free ( mmap_alloc_t *ma );

#ifdef __cplusplus 
}
#endif 

#endif // _FA_MMAP_H_
