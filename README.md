# NCP Terraform Public Server 구성

이 프로젝트는 Terraform을 사용하여 Naver Cloud Platform(NCP)에서 VPC, Subnet, Access Control Group(ACG), Server, Public IP, SSH Key를 자동으로 생성함

## 구성 리소스

- **VPC**: `yunseo-vpc` (10.0.0.0/16)
- **Subnet**: 퍼블릭 서브넷(10.0.1.0/24, KR-2)
- **ACG**: 퍼블릭 접근 제어 그룹 (인바운드 ICMP, TCP 허용, 아웃바운드 TCP 허용)
- **Login Key**: SSH 접속용 키페어(`yunseo-key`)
- **Server**: Ubuntu 22.04, 퍼블릭 서브넷에 생성
- **Public IP**: 서버에 연결

## 사용 방법

1. **Terraform 초기화**
   ```bash
   terraform init
   ```

2. **계획 확인**
   ```bash
   terraform plan
   ```

3. **적용 및 인프라 생성**
   ```bash
   terraform apply
   ```

4. **SSH Key(.pem) 파일 저장**
   - 최초 적용 시 출력되는 private key를 복사하여 `yunseo-key.pem` 파일로 저장
   - output 코드 (keypair.tf 안에 포함):
     ```terraform
     output "private_key" {
       value     = ncloud_login_key.key.private_key
       sensitive = true
     }
     ```
   - 출력 확인:
     ```bash
     terraform output private_key
     ```

5. **서버 접속**
   ```bash
   ssh -i yunseo-key.pem ubuntu@<할당된_공인_IP>
   ```

## 파일 설명

- `vpc_and_subnet.tf`: VPC, Subnet, ACG 및 ACG Rule 정의
- `keypair.tf`: SSH Key 생성
- `server_publicip.tf`: 서버 및 Public IP 생성

## 참고 사항

- .env 파일 생성하여 ncp의 Access key, Secret key EXPOSE 
- SSH Key는 최초 생성 시에만 확인 가능하니 반드시 백업
- 리소스 이름 규칙(NCP): 소문자, 숫자, 하이픈(-)만 사용, 영문자로 시작
- NCP API 인증 정보는 환경 변수 또는 provider 설정에 입력

---

문의: 하지마