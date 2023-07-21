README
================
2023-07-21

``` r
##연습문제 풀이 ----


## 2. Data visualization ----



# 2.2.4 ----

library(tidyverse)

library(ggplot2)

library(palmerpenguins)
library(nycflights13)

# 1

# 344rows & 8 columns
library(palmerpenguins)


penguin

#2

# a number denoting bill depth(milimeters)



#3

penguins |>
  ggplot(aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point(mapping = aes(color = island))


# 4

#geom_point
penguins |>
  ggplot(aes(x= species, y = bill_depth_mm)) +
  geom_point()


# 5

# ggplot(data = penguins) + geom_point()
# x축과 y축의 정보가 존재 하지 않음


penguins |>
  ggplot(aes(x = species, y = bill_length_mm)) +
  geom_point()


#6

penguins |>
  ggplot(aes(x = species, y = bill_length_mm)) +
  geom_point(na.rm = TRUE)

# penguins 자료에 bill_length_mm에 데이터가 없는 자료가
# 존재하는데 이것을 지워주는 듯?



#7

penguins |>
  ggplot(aes(x = species, y = bill_length_mm)) +
  geom_point(na.rm = TRUE) +
  labs(title = "헠",
       subtitle = "엌",
       x= "풉", y = "아하"
  )

#8

penguins |>
  ggplot(aes(x= flipper_length_mm, y = body_mass_g)) +
  geom_point(mapping = aes(color = bill_depth_mm)) +
  geom_smooth(se = FALSE)


#9

#그냥 주어진 그림 그려보기


#10

penguins |>
  ggplot(aes(x = flipper_length_mm, y = body_mass_g)
  )+
  geom_point() +
  geom_smooth()



penguins |>
  ggplot() +
  geom_point(aes(x = flipper_length_mm, y = body_mass_g)
  ) +
  geom_smooth(aes(x = flipper_length_mm, y = body_mass_g)
  )

# 그래프는 같다


# 2.4.3 ----

# 1

penguins |>
  ggplot(aes(x = species)) +
  geom_bar()

penguins |>
  ggplot(aes(y = species)) +
  geom_bar()


# 2

ggplot(penguins, aes(x = species)) +
  geom_bar(color = "red")

ggplot(penguins, aes(x = species)) +
  geom_bar(fill = "red")


# 3

penguins |>
  ggplot(aes(x = bill_length_mm)) +
  geom_histogram(binwidth = 1)

# x축의 간격을 넓혀주거나 좁혀줌


# 2.5.5 ----

 # 1

# numerical : cty, hwy  etc  categorical : trans, manufacturer

View(mpg)

# 2

mpg |>
   ggplot(aes(x= hwy,
              y = displ)) +
   geom_point(aes(color = hwy,
                  shape = fl,
                  size = displ))


# 3??  ----

mpg |>
   ggplot(aes(x= hwy,
              y = displ)) +
  geom_point()



# 4

 mpg |>
   ggplot(aes(x = hwy, y = displ)) +
   geom_point(aes(x = hwy, y = displ))



# 5



penguins |>
  ggplot(aes(x = bill_depth_mm, y = bill_length_mm)) +
  geom_point(aes(color = species)) +
  facet_wrap(~species)


# 6

penguins |>
  ggplot(aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point(aes(color = species, shape = species)) +
  labs(color = "Species", shape = "Species")



# 7

penguins |>
  ggplot(aes(x = island, fill = species)) +
  geom_bar(position = "fill")



penguins |>
  ggplot(aes(x = species, fill = island)) +
  geom_bar(position = "fill")






# 2.6.1 ----


# 1

ggplot(mpg, aes(x = class)) +
  geom_bar()
ggplot(mpg, aes(x = cty, y = hwy)) +
  geom_point()


ggsave("mpg-plot.png")






## 3. Workflow: basics ----



# 3.5 ----


W
# 1

my_vaaable <- 10


# 2


library(tidyverse)

mpg |>
  ggplot(aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth()




# 3

# 단축키의 즐겨 찾기



# 4

?ggsave






## 4. Data transformation ----



# 4.2.5 ----




# 1

library(tidyverse)

library(nycflights13)

View(flights)

View(flights |>
  filter((arr_delay >= 120) &
         (dest == "IAH" | dest =="HOU" ) &
         (carrier == "AA" | carrier == "UA" | carrier == "DL") &
         (month == 7| month == 8 | month == 9))
)




# 2

flights |>
  arrange(desc(dep_delay))


flights |>
  arrange(hour)




# 3

flights_2 <- flights |>
  mutate(actual_time = air_time + arr_delay + dep_delay)

View(flights_2 |>
  arrange((actual_time))
)



# 4

View(flights |>
  filter(year == 2013) |>
  distinct(month, day) |>
  arrange(month)
 )




# 5


View(flights |>
  arrange(distance))

flights |>
  arrange(desc(distance))


min(flights$distance)




# 6

flights |>
   filter(month > 6) |>
   arrange()


 flights |>
   arrange(month) |>
   filter(month > 6)






# 4.3.5 ----


# 1


flights |>
   select(dep_time, sched_dep_time, dep_delay)


#실제 시간인 dep_time에서 sched_dep_time을 빼면 dep_delay가 나옴



# 2




# 3

flights |>
  select(dep_time, dep_time, dep_time)

# 똑같음



# 4


variables <- c("year", "month", "day", "dep_delay", "dep_delay")

flights |>
  select(any_of(variables))



# 5????  ----

flights |> select(contains("TIME"))




# 6

flights |>
  rename(air_time_min = air_time)




# 7

flights |>
  select(tailnum) |>
  arrange(arr_delay)

# 선택한 column은 tailnum이므로 tailnum colummn만 존재하게 됨



# 4.5.7 ----




# 1?? ----

flights |>
  group_by(carrier) |>
  summarize(avg_dep = mean(dep_delay, na.rm = TRUE))



View(flights |>
  group_by(dest, carrier) |>
  summarize(avg_dep = mean(dep_delay, na.rm = TRUE)))


ac <- flights |>
  group_by(carrier) |>
  summarize(count = n())

abc |>
  arrange(desc(count))


View(ac |>
  arrange(desc(count))
)


View(flights |>
  filter(carrier == "F9") |>
  summarize(mean_delay = mean(dep_delay, na.rm = TRUE), .by = dest) |>
    arrange(desc(mean_delay))
)


#CAE 공항이 avg_delay가 가장 긴것으로 보임
#항공사의 경우 F9가 가장 긴것으로 보임





# 2
View(flights |>
  group_by(dest) |>
  arrange(desc(dep_delay))
)



# 3


# 한시간 별로 데이터를 묶은 뒤에ex(0 ~ 60), 묶음별로 delay
# time의 평균값을 묶음 별로 비교



flights3 <- flights |>
  group_by(sched_dep_time >= 0 & sched_dep_time<500,
           sched_dep_time >= 500 & sched_dep_time< 600,
           sched_dep_time >= 600 & sched_dep_time< 700,
           sched_dep_time >= 700 & sched_dep_time< 800,
           sched_dep_time >= 800 & sched_dep_time< 900,
           sched_dep_time >= 900 & sched_dep_time< 1000,
           sched_dep_time >= 1000 & sched_dep_time< 1100,
           sched_dep_time >= 1100 & sched_dep_time< 1200,
           sched_dep_time >= 1200 & sched_dep_time< 1300,
           sched_dep_time >= 1300 & sched_dep_time< 1400,
           sched_dep_time >= 1400 & sched_dep_time< 1500,
           sched_dep_time >= 1500 & sched_dep_time< 1600,
           sched_dep_time >= 1600 & sched_dep_time< 1700,
           sched_dep_time >= 1700 & sched_dep_time< 1800,
           sched_dep_time >= 1800 & sched_dep_time< 1900,
           sched_dep_time >= 1900 & sched_dep_time< 2000,
           sched_dep_time >= 2000 & sched_dep_time< 2100,
           sched_dep_time >= 2100 & sched_dep_time< 2200,
           sched_dep_time >= 2200 & sched_dep_time< 2300,
           sched_dep_time >= 2300 & sched_dep_time< 2400) |>
  summarize(delay = mean(dep_delay, na.rm = TRUE), n = n()
            )


flights2 |>
  pivot_longer(
    cols = (sched_dep_time >= 0 & sched_dep_time<500 :
            sched_dep_time >= 2300 & sched_dep_time< 2400),
    names_to = "clock",
    values_to = "delay"
  )


flights3 <- flights |>
  mutate(time_zone =  case_when(
          (sched_dep_time >= 0 & sched_dep_time<500) ~"early morning",
          (sched_dep_time >= 500 & sched_dep_time< 600)  ~ "5",
          (sched_dep_time >= 600 & sched_dep_time< 700)  ~ "6",
          (sched_dep_time >= 700 & sched_dep_time< 800)  ~ "7",
          (sched_dep_time >= 800 & sched_dep_time< 900)  ~ "8",
          (sched_dep_time >= 900 & sched_dep_time< 1000)  ~ "9",
          (sched_dep_time >= 1000 & sched_dep_time< 1100)  ~ "10",
          (sched_dep_time >= 1100 & sched_dep_time< 1200)  ~ "11",
          (sched_dep_time >= 1200 & sched_dep_time< 1300)  ~ "12",
          (sched_dep_time >= 1300 & sched_dep_time< 1400)  ~ "13",
          (sched_dep_time >= 1400 & sched_dep_time< 1500)  ~ "14",
          (sched_dep_time >= 1500 & sched_dep_time< 1600)  ~ "15",
          (sched_dep_time >= 1600 & sched_dep_time< 1700)  ~ "16",
          (sched_dep_time >= 1700 & sched_dep_time< 1800)  ~ "17",
          (sched_dep_time >= 1800 & sched_dep_time< 1900)  ~ "18",
          (sched_dep_time >= 1900 & sched_dep_time< 2000)  ~ "19",
          (sched_dep_time >= 2000 & sched_dep_time< 2100)  ~ "20",
          (sched_dep_time >= 2100 & sched_dep_time< 2200)  ~ "21",
          (sched_dep_time >= 2200 & sched_dep_time< 2300)  ~ "22",
          (sched_dep_time >= 2300 & sched_dep_time< 2400)  ~ "23"))

flights3 |>
  summarize(delay1 = mean(dep_delay, na.rm = TRUE), .by = time_zone) |>
  ggplot(aes(x =reorder(time_zone, delay1), y = delay1)) + geom_point()


# 오전 5시 기준으로 시간이 지나면 지날 수록 depart_delay가 점점 커진다





# 4

flights_3 |>
  slice_min(avg_delay, n=1)


# 5


# 데이터의 개수 (ROW)의 갯수를 세어준다


# 6

tibble(
  x = 1:5,
  y = c("a", "b", "a", "a", "b"),
  z = c("K", "K", "L", "L", "K")
) |>
  group_by(y, z) |>
  mutate(mean_x = mean(x))

# .groups()의 의미를 잘 모르겠음


?summarize



## 5. Workflow: code style ----



# 5.6 ----


# 1


flights |>
  filter(dest == "IAH") |>
  group_by(year, month, day) |>
  summarize(n=n(),
            delay=mean(arr_delay,
                       na.rm=TRUE)) |>
  filter(n>10)

flights |>
  filter((carrier == "UA") &
         (dest == "IAH" | dest == "HOU") &
         (sched_dep_time > 0900 & sched_arr_time<2000)
         ) |>
  group_by(flight) |>
  summarize(delay = mean(arr_delay,na.rm=TRUE),
            cancelled=sum(is.na(arr_delay)),
            n=n()
            ) |>
  filter(n>10)


## 6.Data tidying ----



# 6.2.1 ----

# 2
table2


table2 |>
  pivot_wider(
    names_from = type,
    values_from = count) |>
  mutate(rates = cases/population*10000)


table3 |>
  separate(rate, into = c("cases", "population"), sep = "/"

  )



## 10. Visualize: Layers ----


# 10.2.1 ----

# 1

mpg |>
  ggplot(aes(x = hwy, y = displ)) +
  geom_point(mpg |>
               filter(class == '2seater'),
             color = 'red', shape = 'circle')

# 2

mpg |>
  ggplot(aes(x = displ, y = hwy, color = 'blue')) +
  geom_point()

#색을 'blue'라는 categorical value으로 나누라는 뜼
#그래서 색깔을 파란색으로 바꾸지은 듯
# 색을 바꾸려면 geom_point color = 'blue'를 넣어야함



# 3
?geom_point
mpg |>
  ggplot(aes(x = displ, y = hwy)) +
  geom_point(stroke = 1)


#stroke은 scatterplot에서 점으 넓이?? 사이즈를 정해줌



# 4

mpg |>
  ggplot(aes(color = displ<5)) +
  geom_point(aes(x = year, y = hwy))

# displ 중에서 5이하인 값과 5 이상인 값을 색으로 구분되어 표현




# 10.3.1 ----


# 1


# geom_line을 사용



# 2

mpg |>
  ggplot(aes(x = displ, y = hwy)) +
  geom_smooth(aes(color = drv), show.legend = FALSE)

# legend를 삭제해줌



# 3

mpg |>
  ggplot(aes(x = displ, y = hwy)) +
  geom_smooth(se = FALSE)

# smooth으로 만들어지는 선 주위의 신뢰 구간을 없애줌



# 4


mpg |>
  ggplot(aes(x = displ, y = hwy)) +
  geom_smooth(se = FALSE) +
  geom_point()

mpg |>
  ggplot(aes(x = displ, y = hwy)) +
  geom_smooth(aes(group = drv), se = FALSE) +
  geom_point()

mpg |>
  ggplot(aes(x = displ, y = hwy, color = drv)) +
  geom_smooth(aes(group = drv), se = FALSE) +
  geom_point()


mpg |>
  ggplot(aes(x = displ, y = hwy)) +
  geom_smooth(se = FALSE) +
  geom_point(aes(color = drv))


mpg |>
  ggplot(aes(x = displ, y = hwy)) +
  geom_smooth(aes(linetype = drv),se = FALSE) +
  geom_point(aes(color = drv))

mpg |>
  ggplot(aes(x = displ, y = hwy)) +
  geom_point(color = 'white', stroke = 3) +
  geom_point(aes(color = drv))


# 10.4.1 ----


# 1
mpg |>
  ggplot(aes(x = displ, y = cty)) +
  geom_point() +
  facet_wrap(~displ)

# 값 하나하나 마다 그래프를 그려줌


# 2

mpg |>
  ggplot(aes(x = drv, y = cyl)) +
  geom_point() +
  facet_wrap(drv~ cyl)

#데이터가 없으니까 비워져 있음, cyl == 5은 drv == f 값만 가짐



# 3

mpg |>
  ggplot(aes(x = displ, y = hwy)) +
  geom_point() +
  facet_wrap(drv ~ cyl)


# .으로 행이나 열은 생략하고 하나의 변수로만 나누도 싶을 때 사용하는 듯



# 4


mpg |>
  ggplot(aes(x = displ, y = hwy)) +
  geom_point() +
  facet_wrap(~class, nrow =1)


#색은 데이터가 많은경우 구분이 어려울 수 있으나 전체적인 그래프을
#확인이 가능하다. facet의 경우 그래프를 categorical value로 나누기
#때문에 각각의 데이터를 확인하는데 유용하지만, 전체적인 데이터의
#비교를 하기에는 부적합




# 5

#nrow는 그래프를 row 개수 만큼으로 배열, ncol도 같은 의미로 지정한 column
#의 갯수로 지정

#face_grid의 경우 column과 row를 직접 지정하기 때문에 column, row의
#갯수를 따로 지정하지 못함



# 6


mpg |>
  ggplot(aes(x = displ)) +
  geom_histogram() +
  facet_grid(drv~.)

mpg |>
  ggplot(aes(x = displ)) +
  geom_histogram() +
  facet_grid(.~drv)

# row로 정렬하는 첫번 째 plot이 보기에 더 좋음


# 7

mpg |>
  ggplot(aes( x = displ, y = hwy)) +
  geom_point() +
  facet_wrap(~drv, ncol = 1)

mpg |>
  ggplot(aes( x = displ, y = hwy)) +
  geom_point() +
  facet_wrap(drv~., strip.position ='right', scales = 'free_y')

# label이 오른쪽에 있었는데 wrap으로 수정하면 위로 위치함



# 10.5.1 ----

# 1
 diamonds |>
  ggplot(aes(x = cut, y = depth)) +
  geom_linerange(aes(xmin = cut, ymin = depth, ymax = depth))+
  geom_line()

#geom_linerage으로 비슷하게 표현이 가능하나 median을 점으로 표현은 불가능


# 2

diamonds |>
  ggplot(aes(x = cut, y = price)) +
  geom_col()

#geom_bar는 원하는 value에 대한 갯수를 세어주는 그래프
#geom_col은



# 3

diamonds |>
  ggplot(aes(x = cut, y = price)) +
  stat_smooth() + geom_point()


mtcars |>
  ggplot(aes(x = hp, y = mpg)) + stat_smooth()


# 5????? ----

ggplot(diamonds, aes(x = cut, fill = color)) +
  geom_bar()


ggplot(diamonds, aes(x = cut, fill = color, y = after_stat(prop),group = 'cut')) +
  geom_bar()




# 10.6.1 ----

# 1
mpg |>
  ggplot(aes(x = cty, y = hwy)) +
  geom_point()

# 무슨 문제인지 몰루???



# 2
ggplot(diamonds, aes(x = clarity, y = after_stat(prop), group = 1)) +
  geom_bar()

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point()

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(position = "identity")


# 4
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_jitter()


#jitter는 한점한점 모두 표시 되므로 분포를 알 수 있고,
#count는 한점한점 표시 되지만 겹치는 부분이 생기므로 밀집도를 알 수 있음


# 5
ggplot(mpg, aes(x = drv, y = hwy)) +
  geom_boxplot() +
  facet_grid(class~.)






## 13. Logical value  ----




# 13.2.3. ----


# 1
near(sqrt(2) ^ 2, 2)
sqrt(2) ^ 2 == 2

# 2


View(flights |>
  filter(!is.na(dep_time))
) |>
  count(year)
?count


flights |>
  summarize(.by = month, asdf = sum(is.na(dep_time))) |>
  arrange(month)


# 13.3.4 ----

# 1


View(
  flights |>
    filter(
           (!is.na(arr_delay)) &
           (dep_time %in% NA)
          )
)
#데이터가 없는듯??

fights2 <- flights |>
  filter(dep_time %in% NA)

write_csv(fights2,"flights.csv")




View(flights |>
  filter(!is.na(arr_time) &
          !is.na(sched_arr_time) &
           is.na(arr_delay)
         )
)


# 2


flights |>
  filter(is.na(dep_time)) |>
  count(dep_time)

# 8255개의 row가 NA, dep_time, dep_delay, arr_time,arr_delay 가 모두 NA값



# 3


flights12 <- flights |>
  filter(dep_time %in% NA
         ) |>
  count(day)


flights13 <- flights |>
       summarize(avg_dep_time = mean(dep_delay, na.rm = TRUE), .by = day
       )

flights_c <- flights12 |>
  mutate(avg_dep_time = flights13$avg_dep_time)

flights_c |>
  ggplot(aes(x = n , y = avg_dep_time)) +
  geom_point() + geom_smooth(se = FALSE)


# cancelled flights가 많을 수록 dep_delay가 많은 경향을 보임



# 13.4.4 ----



# 1
View(flights |>
  summarize(count = sum(is.na(dep_time)), .by = month )
)


# is.na()에서 mean은 TRUE의 개수를 센 뒤에 TRUE FALSE 중에서 TRUE인 비율을
# 알려주는 듯


# 2

flights1 <- flights |>
  mutate(dep = dep_delay <= 0) |>
  relocate(dep, .before = 1) |>
  filter(!is.na(dep))


prod(flights1$dep)
min(flights1$dep)

# logical value에서 TRUE 는 1, FALSE는 0으로 변환되어 계산된다, 만약 NA값이
# 같이 있게 되면 NA라고 표현
# min도 prod와 같은 방법으로 계산되므로 NA갑이 없으면 0,1으로 도출




# 13.5.4 ----


# 1

x <- c(1:20)

if_else(x%%2 == 0, "짝수", "홀수")



# 2

x <- c("Monday", "Saturday", "Wednesday")

if_else(x %in% c('Saturday', 'Sunday'), "weekends", 'weekdays')



# 3


x <- c(-4:4)

if_else(x<0, -x, x)


# 4

# Thanksgiving  3.31, 7.4, 1.1  12.25


flights |>
  mutate(filter = (month == 3 & day == 31) |
           (month == 1 & day == 1 ) |
           (month == 7 & day == 4) |
           (month == 12 & day == 25)
         ) |>
    relocate(filter, .after = 1) |>
  mutate(holiday = case_when(
    (month == 3 & day == 31)   ~ 'Thanksgiving day',
    (month == 1 & day == 1 )   ~ 'New years day',
    (month == 7 & day == 4)    ~ 'Independence day',
    (month == 12 & day == 25)  ~ 'Christmas',
    TRUE  ~ NA_character_

                            )
       ) |>
      relocate(holiday, .after = 1) |>
  count(holiday)


# 14. Numbers ----


# 14.3.1

# 1

flights |>
  summarize(dep_time  = sum(is.na(dep_time)), .by = carrier) |>
  arrange(desc(dep_time))


flights |>
  count(carrier, wt = is.na(dep_time)) |>
  arrange(desc(n))


# 2

flights |>
  count(dest, sort = TRUE)

flights |>
  summarize(n = n(), .by = dest) |>
  arrange(desc(n))


flights |>
  count(tailnum, wt = distance) |>
  arrange(desc(n))

flights |>
  summarize(n = sum(distance), .by = tailnum) |>
  arrange(desc(n))



# 14.4.8


# 1


# 2

 x <- c(pi/2)

 sin(x) == 1
#이러한 값이 도출되는거 보니까 호도법(Radian)이 아니라 각도법(Degree) 사용



# 3

 flights |>
   filter(month == 1, day == 1) |>
   ggplot(aes(x = sched_dep_time, y = dep_delay)) +
   geom_point()

flights |>
  filter(month == 1, day == 1) |>
  mutate(real_hour = sched_dep_time%/%100,
         real_minute = sched_dep_time%%100) |>
  relocate(real_hour, .before =1) |>
  relocate(real_minute, .after = 1) |>
  filter(!is.na(dep_delay)) |>
  select(year, month, day, real_hour, real_minute, dep_delay) |>
  mutate(sched_real_dep_time = make_datetime(year, month, day, real_hour, real_minute)
  ) |>
  ggplot(aes(x = sched_real_dep_time, y = dep_delay)) +
  geom_point() + scale_x_datetime(breaks = "6 hour")





# 4



View(flights |>
  mutate(dep_time1 = (round(dep_time/5)*5),
         arr_time1 = (round(arr_time/5))*5) |>
  relocate(dep_time1, .after = dep_time) |>
  relocate(arr_time1, .after = arr_time)
)



# 14.5.4 ----



?flights

# 1

flights1  <- flights |>
  summarise(dep_delay = mean(dep_delay, na.rm = TRUE), .by = flight)



min_rank(flights1$dep_delay)

flights1 |>
  arrange(desc(dep_delay))

flights1 |>
 filter(dep_delay == 497)



# 2

# 도착지연이 가장 심한 tailnum을 찾아야함

flights |>
  select(tailnum, arr_delay) |>
  arrange(desc(arr_delay))

min_rank(flights$arr_delay)

delay <- flights$arr_delay
# 잘 모르겠음, min_rank써서 는




# 3


flights1 <- flights |>
  select(year, month,day, hour, minute, arr_delay, dep_delay) |>
  mutate(real_time = make_datetime(year, month, day, hour, minute)) |>
  mutate(real_delay = arr_delay + dep_delay) |>
  summarize(real_delay1 = mean(real_delay, na.rm = TRUE), .by = hour) |>


ggplot(flights1, aes(x = hour, y = real_delay1)) +
  geom_point() + geom_line()


# 오전 5시에 시잔이 지날 수록 delay가 많아지는듯???





# 4 ----

View(flights |> group_by(dest) |> filter(row_number() < 4)
)

View(flights |>
       group_by(dest) |>
       arrange(desc(dest))
     )


View(flights |> group_by(dest) |> filter(row_number(dep_delay) < 4)
)

# flights data file을 보면 1,2,3 row값이 2,4를 갖는데 위의 식을 실행해보면
# dep_delay가 2보다 작은 값들을 알려주는 듯?



# 5

flights3 <- flights |>
  mutate(real_delay2 = dep_delay + arr_time, .before = 1) |>
  summarize(sum = sum(real_delay2, na.rm = TRUE), .by = dest)


flights3 <- flights3 |>
  mutate(prop = (sum/496894381))



# 6


flights |>
  mutate(hour = dep_time %/% 100) |>
  group_by(year, month, day, hour) |>
  summarize(
    dep_delay = mean(dep_delay, na.rm = TRUE),
    n = n(),
    .groups = "drop"
  ) |>
  filter(n > 5)



# 7

View(flights |>
  select(dep_time, arr_time, air_time, flight, dest, year, month, day) |>
  mutate(dep_hour = dep_time %/% 100, dep_minute = dep_time %% 100,
         arr_hour = arr_time %/% 100, arr_minute = arr_time %% 100) |>
  mutate(dep_time_real = make_datetime(year, month, day, dep_hour, dep_minute),
         arr_time_real = make_datetime(year, month, day, arr_hour, arr_minute)
  ) |>
  select(flight, dest, dep_time_real, air_time,
         arr_time_real) |>
  mutate(cal_air_Time = arr_time_real - dep_time_real) |>
  mutate(air_time == cal_air_Time)
)

flights

# 8
flights12 <- flights |>
  group_by(dest) |>
  summarise(carriers = n_distinct(carrier)) |>
  filter(carriers >1)


flights |>
  group_by(dest) |>
  filter()


unlist(flights12$dest)


flights |>
  filter(!(dest %in% c("ABQ", "ACK", "ALB", "ANC", "BHM", "BUR", "BZN",
                     "CAK", "CHO", "CRW", "EYW", "HDN", "ILM", "LEX",
                     "LGA", "LGB" ,"MDW", "MTJ", "MYR", "OAK", "OKC",
                     "PSE", "PSP", "PVD", "SAV", "SBN" ,"SMF", "SNA", "TUL"))) |>
  mutate(sum_delay = arr_delay + dep_delay) |>
  summarize(mean_sum_delay = mean(sum_delay, na.rm = TRUE), .by = carrier) |>
  ggplot(aes(x = carrier, y = mean_sum_delay)) + geom_point(position = )


flights |>
  filter(!(dest %in% c("ABQ", "ACK", "ALB", "ANC", "BHM", "BUR", "BZN",
                       "CAK", "CHO", "CRW", "EYW", "HDN", "ILM", "LEX",
                       "LGA", "LGB" ,"MDW", "MTJ", "MYR", "OAK", "OKC",
                       "PSE", "PSP", "PVD", "SAV", "SBN" ,"SMF", "SNA", "TUL"))) |>
  mutate(sum_delay = arr_delay + dep_delay) |>
  summarize(mean_sum_delay = mean(sum_delay, na.rm = TRUE), .by = carrier) |>
  ggplot(aes(x = reorder(carrier, mean_sum_delay), y = mean_sum_delay)) +
  geom_point() + scale_y_continuous(limits = c(-10, NA))

# 다음의 그림으로 설명가능 한 듯?


# 14.6.7 ----


# 1




# 2

flights |>
  summarize(mean = mean(air_time, na.rm = TRUE),
            sd = sd(air_time, na.rm = TRUE), .by = dest ) |>
  arrange(desc(sd))

# 3

View(flights |>
  filter(dest %in% "EGE" | origin %in% "'EGE")
)

#몰루?




## 15. Strings ----




# 15.2.4 ----



# 1


 z <- "He said \"That\'s amazing!\" \n \\a\\b\\c\\d  \n\\\\\\\\\\\\"

str_view(z)


# 2



# 15.3.4


# 1


str_c("hi ", NA)
str_c(letters[3:5], letters[1:3])


# str_c는 연결하려는 string에 NA가 포함되어 있으면 NA로 결과값을 도출
# paste는 NA를 chr으로 변환하기 때문에 NA와 다른 string을 그대로 도출

# 2


#paste와 paste0는 연결하려는 string간의 빈칸 유무이고, 위의 1번 예시에서
# str_c와 paste와 같은 결과값을 가질려면 아래처럼 해야함


str_c("hi ", "NA")

paste0("Hi ", NA)



# 3


z |>
  mutate(name = str_c( "The price of ", food, " is ", price))
z |>
  mutate(name =str_glue("The price of {food} is {price}"))



str_glue("I'm {age} years old and live in {country}")
str_c("I'm ", age , "years old and live in ", country)





# 15.5.3 ----

# 1

babynames |>
  count(length = str_length(name), wt = n)

# wt (가중치)를 주지 않으면 빈도수가 모두 동등하게 계산되기 때문에
# 이름 길이에 대한 상대적 중요성이 무시됨 -> 따라서 가중치를 설정해야함



# 2

babynames |>
  mutate(name_length = str_length(name)) |>
  select(name, name_length) |>
  mutate(middle_name = ifelse(name_length %% 2 == 1,
                               str_sub(name,start = (name_length%/%2)+1, end = (name_length%/%2)+1),
                               str_sub(name, start = (name_length%/%2), end = (name_length%/% 2))
                              )
         )


# Mary인 경우 a가 출력됨



# 3

babynames |>
  mutate(length = str_length(name)) |>
  summarize(mean = mean(length), .by = year) |>
  ggplot(aes(x = year, y = mean)) +  geom_line()

# 점점 길어지는 것을 알 수 있음


awe <- babynames |>
  mutate(first_name = str_sub(name, start = 1, end = 1),
         last_name = str_sub(name, start = -1, end = -1)) |>
  group_by(year) |>
  count(last_name)

awe |>
  filter(year>2010) |>
ggplot(aes(x = last_name, y = n)) + geom_point() +
  facet_wrap(~year)

#그림이 그려지느데 년도가 너무 많아서 구간별로 정해야함????, 대부분 비슷한듯


str_view(babynames$name, "^Z.*a$")


flights |>
  group_by(dest) |>
  distinct(carrier) |>
  summarize(carriers = str_flatten(carrier, ","))

## 16. Regular Expression ----


# 16.3.5 ----

# 1
babynames |>
  mutate(count = str_count(str_to_lower(name), "[aeiou]")) |>
  arrange(desc(count)) |>
  distinct(name, .keep_all = TRUE)

# Mariaguadalupe,  Mariadelrosario 8글자로 제일 많이 있음


babynames |>
  mutate(name = str_to_lower(name),
         total = str_count(name),
         vowel = str_count(name, "[aeiou]")) |>
  mutate(prop = vowel/total) |>
  arrange(desc(prop)) |>
  distinct(name, .keep_all = TRUE)

#eua, ea, ai, ia 등등 모두 모음으로 이루어진 이름이 존재

# 2

string <-  '\"a/b/c/d/e\"'
str_view(string)

string_1 <- str_replace_all(string, "/", "\\\\")
str_view(string_1)

# escape를 두번해야 되서 \\\\ 4개가 필요한듯??
string_1
string_2 <- str_replace_all(string_1, "\\\\", '/')

# 3 ----

# 몰루???


# 4

# Regular Expresssion은 버리자




x <- "appleb\\anana"
str_view(x, "apple")

str_detect(x, 'apple')

# 16.4.7 ----

string <- '\"\'\\'
str_view(string)


## 17. Factors ----

library(tidyverse)
library(ggplot2)
# 17.3.1 ----


# 1
ggplot(gss_cat, aes(x = rincome, y = after_stat(count), group = 1)) + geom_bar()


# levels로 앞에 값이 없는 것들 모두 NA로 처리 하면 그래도
# 모두 factor로 되어 있고 숫자가 아니라서

# 2
gss_cat |>
  count(partyid)



# 3
View(gss_cat |>
  group_by(denom) |>
  count(relig)
)
levels(gss_cat$relig)




rincome_summary <- gss_cat |>
  group_by(rincome) |>
  summarize(
    age = mean(age, na.rm = TRUE),
    n = n()
  )
ggplot(rincome_summary, aes(x = age, y = fct_relevel(rincome, "Not applicable")) +
  geom_point()
gss_cat
levels(gss_cat$rincome)
?fct_relevel









## 26. Functions ----

library(tidyverse)
library(nycflights13)

# 26.2.4 ----

# 1



# 2
#이하 생략


# 26.3.5 ----


flights |>
  filter(is.na(arr_time))

# 2

filter_severe <- function(df, vars, vars2){
  df |>
    filter(is.na({{vars}} | {{vars2}}>= 60)) |>
    summarize(n = n(), .by = dest )

}

View(flights |>
  filter_severe(arr_time, dep_delay)
)



# 4


summarize_weather <- function(df, vars, vars2){
  df |>
    summarize(minimum = min({{vars}}, na.rm = TRUE),
              maximum = max({{vars}} , na.rm = TRUE),
              mean = mean({{vars}}, na.rm = TRUE), .by = {{vars2}})
}

weather |>
  summarize_weather(temp, origin)


# 5


standarize_time <- function(df, vars){
  df |>
    mutate(real_time = make_datetime(year = year, month = month,
                                     day = day, hour = {{vars}} %/% 100,
                                     min = {{vars}} %% 100
    )
    )

}



View(flights |>
  standarize_time(sched_dep_time)
)
```

    ## Error: <text>:516:28: unexpected '>='
    ## 515:     cols = (sched_dep_time >= 0 & sched_dep_time<500 :
    ## 516:             sched_dep_time >=
    ##                                 ^
