package shisho.resource

test_is_excepted {
	# A matching exception list (*)
	is_excepted(["*"], "aws-efs-filesystem|ap-northeast-1|fs-0000") with input as {}

	# A matching exception list (exact match)
	is_excepted(["aws-efs-filesystem|ap-northeast-1|fs-0000"], "aws-efs-filesystem|ap-northeast-1|fs-0000") with input as {}

	# A matching exception list (exact match + redundunt entries)
	is_excepted(
		[
			"aws-efs-filesystem|ap-northeast-1|fs-0000",
			"aws-efs-filesystem|ap-northeast-1|fs-1111",
		],
		"aws-efs-filesystem|ap-northeast-1|fs-0000",
	) with input as {}

	# A matching exception list (* + redundunt entries)
	is_excepted(
		[
			"aws-efs-filesystem|ap-northeast-1|fs-1111",
			"*",
		],
		"aws-efs-filesystem|ap-northeast-1|fs-0000",
	) with input as {}

	# A non-matching exception list
	not is_excepted(["aws-efs-filesystem|ap-northeast-1|fs-1111"], "aws-efs-filesystem|ap-northeast-1|fs-0000") with input as {}

	# An empty exception list
	not is_excepted(null, "aws-efs-filesystem|ap-northeast-1|fs-0000") with input as {}

	# An empty exception list
	not is_excepted([], "aws-efs-filesystem|ap-northeast-1|fs-0000") with input as {}
}
