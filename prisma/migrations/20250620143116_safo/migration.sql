-- CreateEnum
CREATE TYPE "Role" AS ENUM ('REGISTRY', 'COORDINATOR', 'LECTURER', 'STAFF_REGISTRY');

-- CreateEnum
CREATE TYPE "Designation" AS ENUM ('ASSISTANT_LECTURER', 'LECTURER', 'SENIOR_LECTURER', 'PROFESSOR', 'ADMINISTRATIVE_STAFF', 'TECHNICAL_STAFF');

-- CreateEnum
CREATE TYPE "ClaimStatus" AS ENUM ('PENDING', 'APPROVED', 'REJECTED');

-- CreateEnum
CREATE TYPE "ClaimType" AS ENUM ('TEACHING', 'TRANSPORTATION', 'THESIS_PROJECT');

-- CreateEnum
CREATE TYPE "TransportType" AS ENUM ('PUBLIC', 'PRIVATE');

-- CreateEnum
CREATE TYPE "ThesisType" AS ENUM ('SUPERVISION', 'EXAMINATION');

-- CreateEnum
CREATE TYPE "SupervisionRank" AS ENUM ('PHD', 'MPHIL', 'MA', 'MSC', 'BED', 'BSC', 'BA', 'ED');

-- CreateEnum
CREATE TYPE "RequestStatus" AS ENUM ('PENDING', 'APPROVED', 'REJECTED');

-- CreateEnum
CREATE TYPE "ProgramCategory" AS ENUM ('DIPLOMA', 'UNDERGRADUATE', 'POSTGRADUATE', 'OTHER');

-- CreateEnum
CREATE TYPE "CourseLevel" AS ENUM ('LEVEL_100', 'LEVEL_200', 'LEVEL_300', 'LEVEL_400', 'LEVEL_500', 'LEVEL_600', 'LEVEL_700', 'LEVEL_800');

-- CreateEnum
CREATE TYPE "AcademicSemester" AS ENUM ('FIRST_SEMESTER', 'SECOND_SEMESTER');

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "name" TEXT,
    "password" TEXT NOT NULL,
    "role" "Role" NOT NULL,
    "designation" "Designation",
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "lecturerCenterId" TEXT,
    "departmentId" TEXT,
    "bankName" TEXT,
    "bankBranch" TEXT,
    "accountName" TEXT,
    "accountNumber" TEXT,
    "phoneNumber" TEXT,
    "approvedSignupRequestId" TEXT,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SignupRequest" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "hashedPassword" TEXT NOT NULL,
    "requestedRole" "Role" NOT NULL,
    "requestedCenterId" TEXT,
    "bankName" TEXT,
    "bankBranch" TEXT,
    "accountName" TEXT,
    "accountNumber" TEXT,
    "phoneNumber" TEXT,
    "status" "RequestStatus" NOT NULL DEFAULT 'PENDING',
    "submittedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "processedAt" TIMESTAMP(3),
    "processedByRegistryId" TEXT,

    CONSTRAINT "SignupRequest_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Center" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "coordinatorId" TEXT NOT NULL,

    CONSTRAINT "Center_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "StaffRegistryCenterAssignment" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "centerId" TEXT NOT NULL,
    "assignedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "StaffRegistryCenterAssignment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Department" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "centerId" TEXT NOT NULL,

    CONSTRAINT "Department_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Program" (
    "id" TEXT NOT NULL,
    "programCode" TEXT NOT NULL,
    "programTitle" TEXT NOT NULL,
    "programCategory" "ProgramCategory" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "departmentId" TEXT NOT NULL,

    CONSTRAINT "Program_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Course" (
    "id" TEXT NOT NULL,
    "courseId" TEXT NOT NULL,
    "courseTitle" TEXT NOT NULL,
    "creditHours" DOUBLE PRECISION NOT NULL,
    "level" "CourseLevel" NOT NULL,
    "academicSemester" "AcademicSemester" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "programId" TEXT NOT NULL,

    CONSTRAINT "Course_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Claim" (
    "id" TEXT NOT NULL,
    "claimType" "ClaimType" NOT NULL,
    "status" "ClaimStatus" NOT NULL DEFAULT 'PENDING',
    "submittedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "processedAt" TIMESTAMP(3),
    "submittedById" TEXT NOT NULL,
    "centerId" TEXT NOT NULL,
    "processedById" TEXT,
    "teachingDate" TIMESTAMP(3),
    "teachingStartTime" TEXT,
    "teachingEndTime" TEXT,
    "teachingHours" DOUBLE PRECISION,
    "courseTitle" TEXT,
    "courseCode" TEXT,
    "transportToTeachingInDate" TIMESTAMP(3),
    "transportToTeachingFrom" TEXT,
    "transportToTeachingTo" TEXT,
    "transportToTeachingOutDate" TIMESTAMP(3),
    "transportToTeachingReturnFrom" TEXT,
    "transportToTeachingReturnTo" TEXT,
    "transportToTeachingDistanceKM" DOUBLE PRECISION,
    "transportType" "TransportType",
    "transportDestinationTo" TEXT,
    "transportDestinationFrom" TEXT,
    "transportRegNumber" TEXT,
    "transportCubicCapacity" INTEGER,
    "transportAmount" DOUBLE PRECISION,
    "thesisType" "ThesisType",
    "thesisSupervisionRank" "SupervisionRank",
    "thesisExamCourseCode" TEXT,
    "thesisExamDate" TIMESTAMP(3),

    CONSTRAINT "Claim_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SupervisedStudent" (
    "id" TEXT NOT NULL,
    "studentName" TEXT NOT NULL,
    "thesisTitle" TEXT NOT NULL,
    "claimId" TEXT NOT NULL,
    "supervisorId" TEXT NOT NULL,

    CONSTRAINT "SupervisedStudent_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "User_accountNumber_key" ON "User"("accountNumber");

-- CreateIndex
CREATE UNIQUE INDEX "User_approvedSignupRequestId_key" ON "User"("approvedSignupRequestId");

-- CreateIndex
CREATE INDEX "User_lecturerCenterId_idx" ON "User"("lecturerCenterId");

-- CreateIndex
CREATE INDEX "User_departmentId_idx" ON "User"("departmentId");

-- CreateIndex
CREATE INDEX "User_approvedSignupRequestId_idx" ON "User"("approvedSignupRequestId");

-- CreateIndex
CREATE INDEX "User_phoneNumber_idx" ON "User"("phoneNumber");

-- CreateIndex
CREATE INDEX "User_accountNumber_idx" ON "User"("accountNumber");

-- CreateIndex
CREATE UNIQUE INDEX "SignupRequest_email_key" ON "SignupRequest"("email");

-- CreateIndex
CREATE INDEX "SignupRequest_status_idx" ON "SignupRequest"("status");

-- CreateIndex
CREATE INDEX "SignupRequest_processedByRegistryId_idx" ON "SignupRequest"("processedByRegistryId");

-- CreateIndex
CREATE INDEX "SignupRequest_requestedCenterId_idx" ON "SignupRequest"("requestedCenterId");

-- CreateIndex
CREATE INDEX "SignupRequest_accountNumber_idx" ON "SignupRequest"("accountNumber");

-- CreateIndex
CREATE INDEX "SignupRequest_phoneNumber_idx" ON "SignupRequest"("phoneNumber");

-- CreateIndex
CREATE UNIQUE INDEX "Center_name_key" ON "Center"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Center_coordinatorId_key" ON "Center"("coordinatorId");

-- CreateIndex
CREATE INDEX "StaffRegistryCenterAssignment_userId_idx" ON "StaffRegistryCenterAssignment"("userId");

-- CreateIndex
CREATE INDEX "StaffRegistryCenterAssignment_centerId_idx" ON "StaffRegistryCenterAssignment"("centerId");

-- CreateIndex
CREATE UNIQUE INDEX "StaffRegistryCenterAssignment_userId_centerId_key" ON "StaffRegistryCenterAssignment"("userId", "centerId");

-- CreateIndex
CREATE INDEX "Department_centerId_idx" ON "Department"("centerId");

-- CreateIndex
CREATE UNIQUE INDEX "Department_name_centerId_key" ON "Department"("name", "centerId");

-- CreateIndex
CREATE UNIQUE INDEX "Program_programCode_key" ON "Program"("programCode");

-- CreateIndex
CREATE INDEX "Program_departmentId_idx" ON "Program"("departmentId");

-- CreateIndex
CREATE INDEX "Program_programCategory_idx" ON "Program"("programCategory");

-- CreateIndex
CREATE UNIQUE INDEX "Course_courseId_key" ON "Course"("courseId");

-- CreateIndex
CREATE INDEX "Course_programId_idx" ON "Course"("programId");

-- CreateIndex
CREATE INDEX "Course_level_idx" ON "Course"("level");

-- CreateIndex
CREATE INDEX "Course_academicSemester_idx" ON "Course"("academicSemester");

-- CreateIndex
CREATE INDEX "Claim_submittedById_idx" ON "Claim"("submittedById");

-- CreateIndex
CREATE INDEX "Claim_centerId_idx" ON "Claim"("centerId");

-- CreateIndex
CREATE INDEX "Claim_processedById_idx" ON "Claim"("processedById");

-- CreateIndex
CREATE INDEX "Claim_claimType_idx" ON "Claim"("claimType");

-- CreateIndex
CREATE INDEX "Claim_status_idx" ON "Claim"("status");

-- CreateIndex
CREATE INDEX "SupervisedStudent_claimId_idx" ON "SupervisedStudent"("claimId");

-- CreateIndex
CREATE INDEX "SupervisedStudent_supervisorId_idx" ON "SupervisedStudent"("supervisorId");

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_lecturerCenterId_fkey" FOREIGN KEY ("lecturerCenterId") REFERENCES "Center"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_departmentId_fkey" FOREIGN KEY ("departmentId") REFERENCES "Department"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_approvedSignupRequestId_fkey" FOREIGN KEY ("approvedSignupRequestId") REFERENCES "SignupRequest"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SignupRequest" ADD CONSTRAINT "SignupRequest_processedByRegistryId_fkey" FOREIGN KEY ("processedByRegistryId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Center" ADD CONSTRAINT "Center_coordinatorId_fkey" FOREIGN KEY ("coordinatorId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StaffRegistryCenterAssignment" ADD CONSTRAINT "StaffRegistryCenterAssignment_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StaffRegistryCenterAssignment" ADD CONSTRAINT "StaffRegistryCenterAssignment_centerId_fkey" FOREIGN KEY ("centerId") REFERENCES "Center"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Department" ADD CONSTRAINT "Department_centerId_fkey" FOREIGN KEY ("centerId") REFERENCES "Center"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Program" ADD CONSTRAINT "Program_departmentId_fkey" FOREIGN KEY ("departmentId") REFERENCES "Department"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Course" ADD CONSTRAINT "Course_programId_fkey" FOREIGN KEY ("programId") REFERENCES "Program"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Claim" ADD CONSTRAINT "Claim_submittedById_fkey" FOREIGN KEY ("submittedById") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Claim" ADD CONSTRAINT "Claim_centerId_fkey" FOREIGN KEY ("centerId") REFERENCES "Center"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Claim" ADD CONSTRAINT "Claim_processedById_fkey" FOREIGN KEY ("processedById") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupervisedStudent" ADD CONSTRAINT "SupervisedStudent_claimId_fkey" FOREIGN KEY ("claimId") REFERENCES "Claim"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupervisedStudent" ADD CONSTRAINT "SupervisedStudent_supervisorId_fkey" FOREIGN KEY ("supervisorId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
