import { Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { environment } from '../../environments/environment';
import { Observable } from 'rxjs';
import { StockDetail } from './models/stock-detail.model';
import { StockProfit } from './models/stock-profit.model';
import { ApiResponse } from './models/api-response.model';

@Injectable({
  providedIn: 'root',
})
export class StockDetailsService {
  constructor(private http: HttpClient) {}

  readonly stockDetailsUrl = environment.apiURL + '/stock_details';

  public getAllStockDetails(): Observable<StockDetail[]> {
    return this.http.get<StockDetail[]>(`${this.stockDetailsUrl}`);
  }

  public getStockDetailById(id: string): Observable<StockDetail> {
    return this.http.get<StockDetail>(`${this.stockDetailsUrl}/${id}`);
  }

  public postStockDetails(stockDetail: StockDetail): Observable<StockDetail> {
    let stock_detail = {
        transaction_type: stockDetail.transaction_type,
        quantity: stockDetail.quantity,
        amount: stockDetail.amount,
        transaction_date: stockDetail.transaction_date,
        stock_id: stockDetail.stock_id,
    }
    return this.http.post<any>(this.stockDetailsUrl, { stock_detail });
  }

  public putStockDetails(stockDetail: StockDetail) {
    return this.http.put(`${this.stockDetailsUrl}/${stockDetail.id}`, {
      stockDetail,
    });
  }

  public deleteStock(id: string) {
    return this.http.delete(`${this.stockDetailsUrl}/${id}`);
  }

  public getProfit(): Observable<StockProfit> {
    return this.http.get<StockProfit>(
      `${this.stockDetailsUrl}/profit`
    );
  }

  public getStockProfit(): Observable<StockProfit[]> {
    return this.http.get<StockProfit[]>(
      `${this.stockDetailsUrl}/stock_profit`
    );
  }
}
