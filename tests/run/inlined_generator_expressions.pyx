
cimport cython

def range_tuple_genexp(int N):
    """
    >>> range_tuple_genexp(5)
    (0, 1, 2, 3, 4)
    """
    return tuple(i for i in range(N))


@cython.test_assert_path_exists('//ForFromStatNode',
                                "//InlinedGeneratorExpressionNode")
@cython.test_fail_if_path_exists('//SimpleCallNode',
                                 '//ForInStatNode')
def range_sum(int N):
    """
    >>> sum(range(10))
    45
    >>> range_sum(10)
    45
    """
    result = sum(i for i in range(N))
    return result


@cython.test_assert_path_exists('//ForFromStatNode',
                                "//InlinedGeneratorExpressionNode")
@cython.test_fail_if_path_exists('//SimpleCallNode',
                                 '//CoerceFromPyTypeNode//InlinedGeneratorExpressionNode',
                                 '//ForInStatNode')
def range_sum_typed(int N):
    """
    >>> sum(range(10))
    45
    >>> range_sum_typed(10)
    45
    """
    cdef int result = sum(i for i in range(N))
    return result


@cython.test_assert_path_exists('//ForFromStatNode',
                                "//InlinedGeneratorExpressionNode",
                                "//ReturnStatNode//InlinedGeneratorExpressionNode",
                                "//ReturnStatNode//CoerceToPyTypeNode//InlinedGeneratorExpressionNode")
@cython.test_fail_if_path_exists('//SimpleCallNode',
                                 '//CoerceFromPyTypeNode//InlinedGeneratorExpressionNode',
                                 '//TypecastNode//InlinedGeneratorExpressionNode',
                                 '//ForInStatNode')
def return_range_sum_cast(int N):
    """
    >>> sum(range(10))
    45
    >>> return_range_sum_cast(10)
    45
    """
    return <int>sum(i for i in range(N))


@cython.test_assert_path_exists('//ForFromStatNode',
                                "//InlinedGeneratorExpressionNode")
@cython.test_fail_if_path_exists('//SimpleCallNode',
                                 '//ForInStatNode')
def return_range_sum(int N):
    """
    >>> sum(range(10))
    45
    >>> return_range_sum(10)
    45
    """
    return sum(i for i in range(N))


@cython.test_assert_path_exists('//ForFromStatNode',
                                "//InlinedGeneratorExpressionNode")
@cython.test_fail_if_path_exists('//SimpleCallNode',
                                 '//ForInStatNode')
def return_range_sum_squares(int N):
    """
    >>> sum([i*i for i in range(10)])
    285
    >>> return_range_sum_squares(10)
    285

    >>> sum([i*i for i in range(10000)])
    333283335000
    >>> return_range_sum_squares(10000)
    333283335000
    """
    return sum(i*i for i in range(N))


@cython.test_assert_path_exists('//ForInStatNode',
                                "//InlinedGeneratorExpressionNode")
@cython.test_fail_if_path_exists('//SimpleCallNode')
def return_sum_squares(seq):
    """
    >>> sum([i*i for i in range(10)])
    285
    >>> return_sum_squares(range(10))
    285

    >>> sum([i*i for i in range(10000)])
    333283335000
    >>> return_sum_squares(range(10000))
    333283335000
    """
    return sum(i*i for i in seq)


@cython.test_assert_path_exists('//ForInStatNode',
                                "//InlinedGeneratorExpressionNode")
@cython.test_fail_if_path_exists('//SimpleCallNode')
def return_sum_squares_start(seq, int start):
    """
    >>> sum([i*i for i in range(10)], -1)
    284
    >>> return_sum_squares_start(range(10), -1)
    284

    >>> sum([i*i for i in range(10000)], 9)
    333283335009
    >>> return_sum_squares_start(range(10000), 9)
    333283335009
    """
    return sum((i*i for i in seq), start)
