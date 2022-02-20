require './program'

describe Program do
  context '#main' do
    subject { Program.new }

    let(:print_result) do
<<~END
=== Sales Viewer ===
+----------------------------------------------------------------------------------------------+
|          orderid |         userName |    numberOfItems |    totalOfBasket |        dateOfBuy |
+----------------------------------------------------------------------------------------------+
|                1 |            peter |                3 |           123.00 |       2021-11-30 |
|                2 |             paul |                1 |           433.50 |       2021-12-11 |
|                3 |            peter |                1 |           329.99 |       2021-12-18 |
|                4 |             john |                5 |           467.35 |       2021-12-30 |
|                5 |             john |                1 |            88.00 |       2022-01-04 |
+----------------------------------------------------------------------------------------------+
END
    end
    let(:report_result) do
<<~END
=== Sales Viewer ===
+---------------------------------------------+
|                Number of sales |          5 |
|              Number of clients |          0 |
|               Total items sold |         11 |
|             Total sales amount |    1441.84 |
|            Average amount/sale |     288.37 |
|             Average item price |     131.08 |
+---------------------------------------------+
END
    end

    it 'on print command returns' do
      expect(subject.main('print').inspect).to eq(print_result.inspect)
    end

    it 'on report command returns' do
      expect(subject.main('report').inspect).to eq(report_result.inspect)
    end
  end
end
