test_that("All variables core varibles exits", {
  df <- data.frame(a = 1, b = 2)

  expect_error(  create_ipctwg_table(.results = df, names1 = "c"))

})


## fcs > 112

# test_that("All variables core varibles exits", {
#
# })
#
#
# test_that("All variables core varibles exits", {
#
# })
