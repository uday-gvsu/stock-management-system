import { Stock } from './stock.model';

export class StockDetail {
  id?: string;
  transaction_type?: string;
  quantity?: number;
  amount?: number;
  transaction_date?: string;
  stock_id?: string;
  stock?: Stock;
}
