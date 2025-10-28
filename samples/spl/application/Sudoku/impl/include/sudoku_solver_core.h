/* begin_generated_IBM_Teracloud_ApS_copyright_prolog               */
/*                                                                  */
/* This is an automatically generated copyright prolog.             */
/* After initializing,  DO NOT MODIFY OR MOVE                       */
/* **************************************************************** */
/* THIS SAMPLE CODE IS PROVIDED ON AN "AS IS" BASIS.                */
/* TERACLOUD APS AND IBM MAKES NO REPRESENTATIONS OR WARRANTIES,    */
/* EXPRESS OR IMPLIED, CONCERNING  USE OF THE SAMPLE CODE, OR THE   */
/* COMPLETENESS OR ACCURACY OF THE SAMPLE CODE. TERACLOUD APS       */
/* AND IBM DOES NOT WARRANT UNINTERRUPTED OR ERROR-FREE OPERATION   */
/* OF THIS SAMPLE CODE. TERACLOUD APS AND IBM IS NOT RESPONSIBLE FOR THE */
/* RESULTS OBTAINED FROM THE USE OF THE SAMPLE CODE OR ANY PORTION  */
/* OF THIS SAMPLE CODE.                                             */
/*                                                                  */
/* LIMITATION OF LIABILITY. IN NO EVENT WILL IBM BE LIABLE TO ANY   */
/* PARTY FOR ANY DIRECT, INDIRECT, SPECIAL OR OTHER CONSEQUENTIAL   */
/* DAMAGES FOR ANY USE OF THIS SAMPLE CODE, THE USE OF CODE FROM    */
/* THIS [ SAMPLE PACKAGE,] INCLUDING, WITHOUT LIMITATION, ANY LOST  */
/* PROFITS, BUSINESS INTERRUPTION, LOSS OF PROGRAMS OR OTHER DATA   */
/* ON YOUR INFORMATION HANDLING SYSTEM OR OTHERWISE.                */
/*                                                                  */
/* (C) Copyright Teracloud ApS 2024, 2025, IBM Corp. 2010, 2014     */
/* All Rights reserved.                                             */
/*                                                                  */
/* end_generated_IBM_Teracloud_ApS_copyright_prolog                 */
#ifndef SUDOKU_SOLVER_CORE_H_
#define SUDOKU_SOLVER_CORE_H_

#include <iostream>
#include <bitset>
#include <cassert>

    namespace sample
    {
        namespace sudoku
        {
            template <class T>
            class line_peer_iterator
            {
            public:
                line_peer_iterator(int * data, int skip)
                    : data_(data), index_(skip ? 0 : 1), skip_(skip) {}
                line_peer_iterator() : index_(T::size()) {}
                int const & operator *()
                {
                    return data_[T::idx(index_)];
                }
                line_peer_iterator & operator ++()
                {
                    inc(); return *this;
                }
                line_peer_iterator operator ++(int i)
                {
                    line_peer_iterator old = *this; inc(); return old;
                }
                bool operator ==(line_peer_iterator const & o) const
                {
                    return index_==o.index_;
                }
                bool operator !=(line_peer_iterator const & o) const
                {
                    return !(*this==o);
                }
            private:
                void inc()
                {
                    ++index_;
                    if(index_==skip_)
                        ++index_;
                }
                int const * data_;
                int index_;
                int skip_;
            };

            template <class T>
            class cell_peer_iterator
            {
            public:
                cell_peer_iterator(int * data, int rskip, int cskip)
                    : data_(data), row_(rskip ? 0 : 1), column_(cskip ? 0 : 1),
                      rskip_(rskip), cskip_(cskip), index_(row_*T::cell_size()+column_) {}
                cell_peer_iterator() : index_(T::size()) {}
                int const & operator *()
                {
                    return data_[T::idx(index_)];
                }
                cell_peer_iterator & operator ++()
                {
                    inc(); return *this;
                }
                cell_peer_iterator operator ++(int i)
                {
                    cell_peer_iterator old = *this; inc(); return old;
                }
                bool operator ==(cell_peer_iterator const & o) const
                {
                    return index_==o.index_;
                }
                bool operator !=(cell_peer_iterator const & o) const
                {
                    return !(*this==o);
                }
            private:
                void inc()
                {
                    int n = T::cell_size();
                    do {
                        index_++;
                        column_++;
                        if(column_==n) {
                            column_ = 0;
                            row_++;
                        }
                    } while(row_==rskip_ || column_==cskip_);
                    index_ = std::min(index_, T::size());
                }
                int const * data_;
                int row_;
                int column_;
                int rskip_;
                int cskip_;
                int index_;
            };

            template <int strideN, int cell_sizeN>
            class line
            {
                enum { sizeN = cell_sizeN*cell_sizeN, NaN = '.' };
            public:
                typedef line_peer_iterator<line> peer_iterator;
                line(int * data, int index)
                    : data_(data) {}
                line() {}
                static int size()
                {
                    return sizeN;
                }
                int index() const
                {
                    return index_;
                }
                int & operator [](int index)
                {
                    return data_[line::idx(index)];
                }
                int const & operator [](int index) const
                {
                    return data_[line::idx(index)];
                }
                peer_iterator peer_begin(int index)
                {
                    return peer_iterator(data_, index);
                }
                peer_iterator const & peer_end()
                {
                    return peer_iterator_end_;
                }
            protected:
                static peer_iterator peer_iterator_end_;
                static int idx(int index)
                {
                    return index * strideN;
                }
                static bool toChar(int value, char & c)
                {
                    if(value>=1 && value<=sizeN)
                        c = '0' + value;
                    else if(value==0)
                        c = NaN;
                    else return false;
                    return true;
                }
                static bool fromChar(int & value, char c)
                {
                    int n = c - '0';
                    if(n>=1 && n<=sizeN)
                        value = n;
                    else if(c==NaN)
                        value = 0;
                    else return false;
                    return true;
                }
                int * data_;
                int index_;
                template <class T>
                friend class line_peer_iterator;
            };

            template <int strideN, int cell_sizeN>
            line_peer_iterator<line<strideN, cell_sizeN> >
            line<strideN, cell_sizeN>::peer_iterator_end_;

            template <int cell_sizeN>
            class row : public line<1, cell_sizeN>
            {
                enum { sizeN = cell_sizeN*cell_sizeN };
            public:
                typedef line_peer_iterator<line<1, cell_sizeN> > peer_iterator;
                row(int * data, int index)
                    : line<1, cell_sizeN>(data+index*sizeN, index) {}
                row() {}
                static std::ostream & separator(std::ostream & ostr)
                {
                    for(int i = 0; i<cell_sizeN; ++i) {
                        if(i) ostr << "+";
                        for(int j = 0; j<cell_sizeN; ++j)
                            ostr << "--";
                    }
                    return ostr;
                }
            private:
                std::ostream & serialize(std::ostream & ostr) const
                {
                    for(int i = 0,k = 0; i<cell_sizeN; ++i) {
                        if(i) ostr << "|";
                        for(int j = 0; j<cell_sizeN; ++j) {
                            char c = ' ';
                            this->toChar(this->operator [](k++), c);
                            ostr << c << " ";
                        }
                    }
                    return ostr;
                }
                std::istream & deserialize(std::istream & istr)
                {
                    for(int i = 0, c; i<sizeN; ++i) {
                        do {
                            c = istr.get();
                            if(c==istr.eof()) {
                                istr.setstate(std::ios::failbit);
                                return istr;
                            }
                        } while(!this->fromChar(this->operator [](i), c));
                    }
                    return istr;
                }
                template <int size>
                friend std::ostream & operator <<(std::ostream &, row<size> const &);
                template <int size>
                friend std::istream & operator >>(std::istream &, row<size> &);
            };

            template <int cell_sizeN>
            class column : public line<cell_sizeN * cell_sizeN, cell_sizeN>
            {
                enum { sizeN = cell_sizeN*cell_sizeN };
            public:
                typedef line_peer_iterator<line<sizeN, cell_sizeN> > peer_iterator;
                column(int * data, int index)
                    : line<sizeN, cell_sizeN>(data+index, index) {}
                column() {}
            };

            template <int cell_sizeN>
            class cell
            {
                enum { sizeN = cell_sizeN*cell_sizeN };
            public:
                typedef cell_peer_iterator<cell> peer_iterator;
                cell(int * data, int crow, int ccolumn)
                    : data_(data+ccolumn*cell_sizeN+sizeN*cell_sizeN*crow),
                      crow_(crow), ccolumn_(ccolumn) {}
                cell() {}
                static int size()
                {
                    return sizeN;
                }
                static int cell_size()
                {
                    return cell_sizeN;
                }
                int crow_index() const
                {
                    return crow_;
                }
                int ccolumn_index() const
                {
                    return ccolumn_;
                }
                int & operator [](int index)
                {
                    return data_[this->idx(index)];
                }
                int const & operator [](int index) const
                {
                    return data_[this->idx(index)];
                }
                peer_iterator peer_begin(int row, int column)
                {
                    return peer_iterator(data_, lrow(row), lcolumn(column));
                }
                peer_iterator const & peer_end()
                {
                    return peer_iterator_end_;
                }
            private:
                static peer_iterator peer_iterator_end_;
                static int idx(int index)
                {
                    return (index%cell_sizeN)+(index/cell_sizeN)*sizeN;
                }
                int idx(int row, int column)
                {
                    return lrow(row)*cell_sizeN+lcolumn(column);
                }
                int lrow(int row)
                {
                    return row-crow_*cell_sizeN;
                }
                int lcolumn(int column)
                {
                    return column-ccolumn_*cell_sizeN;
                }
                int * data_;
                int crow_;
                int ccolumn_;
                template <class T>
                friend class cell_peer_iterator;
            };

            template <int cell_sizeN>
            cell_peer_iterator<cell<cell_sizeN> >
            cell<cell_sizeN>::peer_iterator_end_;

            template <int cell_sizeN>
            inline std::ostream & operator <<(std::ostream & ostr, row<cell_sizeN> const & r)
            {
                return r.serialize(ostr);
            }
            template <int cell_sizeN>
            inline std::istream & operator >>(std::istream & istr, row<cell_sizeN> & r)
            {
                return r.deserialize(istr);
            }

            template <int cell_sizeN>
            class board
            {
                enum { sizeN = cell_sizeN * cell_sizeN };
            public:
                board()
                {
                    init();
                }
                board(board const & other)
                {
                    init(); *this = other;
                }
                virtual ~board() {}
                int row_size() const
                {
                    return sizeN;
                }
                int column_size() const
                {
                    return sizeN;
                }
                int cell_size() const
                {
                    return cell_sizeN;
                }
                row<cell_sizeN> & row_at(int row)
                {
                    return rows_[row];
                }
                row<cell_sizeN> const & row_at(int row) const
                {
                    return rows_[row];
                }
                column<cell_sizeN> & column_at(int column)
                {
                    return columns_[column];
                }
                column<cell_sizeN> const & column_at(int column) const
                {
                    return columns_[column];
                }
                cell<cell_sizeN> & cell_at(int row, int column)
                {
                    return cells_[row/cell_sizeN][column/cell_sizeN];
                }
                cell<cell_sizeN> const & cell_at(int row, int column) const
                {
                    return cells_[row/cell_sizeN][column/cell_sizeN];
                }
                int at(int row, int column) const
                {
                    return data_[row][column];
                }
                int & at(int row, int column)
                {
                    return data_[row][column];
                }
                board & operator =(board const & other)
                {
                    if(this==&other)
                        return *this;
                    memcpy(data_, other.data_, sizeof(int)*sizeN*sizeN);
                    solve_size_ = other.solve_size_;
                    for(int i = 0; i<sizeN; ++i)
                        for(int j = 0; j<sizeN; ++j)
                            solve_state_[i][j] = other.solve_state_[i][j];
                    return *this;
                }
                void solve()
                {
                    solver_init();
                    solver_run();
                    assert(verify());
                }
                bool solve_unique()
                {
                    solver_init();
                    try {
                        solver_run(true);
                    } catch(multisolution const & e) {
                        return false;
                    }
                    assert(verify());
                    return true;
                }
                bool verify()
                {
                    for(int i = 0; i<sizeN; ++i)
                        if(!verify(this->row_at(i)))
                            return false;
                    for(int j = 0; j<sizeN; ++j)
                        if(!verify(this->column_at(j)))
                            return false;
                    for(int ci = 0; ci<cell_sizeN; ++ci) {
                        for(int cj = 0; cj<cell_sizeN; ++cj) {
                            int i = ci*cell_sizeN, j = cj*cell_sizeN;
                            if(!verify(this->cell_at(i, j)))
                                return false;
                        }
                    }
                    return true;
                }
            private:
                struct conflict : std::exception {};
                struct multisolution : std::exception {};
                void init()
                {
                    rdata_ = &data_[0][0];
                    for(int i = 0; i<sizeN; ++i) {
                        rows_[i] = row<cell_sizeN>(rdata_, i);
                        columns_[i] = column<cell_sizeN>(rdata_, i);
                    }
                    for(int i = 0; i<cell_sizeN; ++i) {
                        for(int j = 0; j<cell_sizeN; ++j)
                            cells_[i][j] = cell<cell_sizeN>(rdata_, i, j);
                    }
                }
                void solver_init()
                {
                    solve_size_ = 0;
                    for(int i = 0; i<sizeN; ++i)
                        for(int j = 0; j<sizeN; ++j)
                            solve_state_[i][j].reset();
                    for(int i = 0; i<sizeN; ++i) {
                        for(int j = 0; j<sizeN; ++j) {
                            int d = data_[i][j];
                            if(!d) continue; // not yet decided
                            solver_decide(i, j, d);
                        }
                    }
                }
                void solver_run(bool multisol = false)
                {
                    int last_solve_size = 0;
                    int N2 = sizeN * sizeN;
                    do {
                        last_solve_size = solve_size_;
                        solver_pass();
                    } while(last_solve_size<solve_size_);
                    if(solve_size_!=N2)
                        solver_search(multisol);
                }
                void solver_pass()
                {
                    // do elimination
                    for(int i = 0; i<sizeN; ++i) {
                        for(int j = 0; j<sizeN; ++j) {
                            int d = data_[i][j];
                            if(d) continue; // already decided
                            if(solve_state_[i][j].size()==1)
                                solver_decide(i, j, 0);
                        }
                    }
                    // check for single appearances of missing values
                    for(int d = 1; d<=sizeN; ++d) {
                        for(int i = 0; i<sizeN; ++i) { // in rows
                            row<cell_sizeN> & r = this->row_at(i);
                            solver_singleton_pass(r, d);
                        }
                        for(int j = 0; j<sizeN; ++j) { // in columns
                            column<cell_sizeN> & c = this->column_at(j);
                            solver_singleton_pass(c, d);
                        }
                        for(int ci = 0; ci<cell_sizeN; ++ci) { // in cells
                            for(int cj = 0; cj<cell_sizeN; ++cj) {
                                int i = ci*cell_sizeN, j = cj*cell_sizeN;
                                cell<cell_sizeN> & c = this->cell_at(i, j);
                                solver_singleton_pass(c, d);
                            }
                        }
                    }
                }
                template <class T>
                void solver_singleton_pass(T & bucket, int d)
                {
                    int ifound = -1, jfound = -1;
                    for(int k = 0; k<sizeN; ++k) {
                        int const & v = bucket[k];
                        if(v==d) return; // no need to search, it is there
                        if(v) continue; // already decided
                        int const * vaddr = &v;
                        int diff = vaddr - rdata_;
                        int i = diff / sizeN, j = diff % sizeN;
                        state & s = solve_state_[i][j];
                        if(s.status(d)) continue; // already eliminated
                        if(ifound>=0) {
                            ifound = -1; break;
                        }                         // more than one candidate
                        ifound = i; jfound = j; // the current candidate
                    }
                    if(ifound>=0) // only one candidate
                        solver_decide(ifound, jfound, d);
                }
                void solver_decide(int i, int j, int d)
                {
                    solve_size_++;
                    state & s = solve_state_[i][j];
                    if(!d) {
                        assert(s.size()==1);
                        d = s.solve();
                    }
                    s.decide(d);
                    data_[i][j] = d;
                    solver_elimination(i, j, d);
                }
                void solver_elimination(int i, int j, int d)
                {
                    row<cell_sizeN> & r = this->row_at(i);
                    for(typename row<cell_sizeN>::peer_iterator it = r.peer_begin(j); it!=r.peer_end(); ++it)
                        solver_elimination(*it, d);
                    column<cell_sizeN> & c = this->column_at(j);
                    for(typename column<cell_sizeN>::peer_iterator it = c.peer_begin(i); it!=c.peer_end(); ++it)
                        solver_elimination(*it, d);
                    cell<cell_sizeN> & l = this->cell_at(i, j);
                    for(typename cell<cell_sizeN>::peer_iterator it = l.peer_begin(i, j); it!=l.peer_end(); ++it)
                        solver_elimination(*it, d);
                }
                void solver_elimination(int const & v, int d)
                {
                    int const * vaddr = &v;
                    int diff = vaddr - rdata_;
                    int i = diff / sizeN, j = diff % sizeN;
                    state & s = solve_state_[i][j];
                    s.eliminate(d);
                }
                void solver_search(bool multisol = false)
                {
                    int i = 0, j = 0;
                    solver_find_min(i, j);
                    state & s = solve_state_[i][j];
                    int numsols = 0;
                    std::unique_ptr<board> backup;
                    for(int d = 1; d<=sizeN; ++d) {
                        if(s.status(d)) continue; // already decided or eliminated
                        board other = *this;
                        bool suceeded = true;
                        try {
                            other.solver_decide(i, j, d);
                            other.solver_run();
                        } catch(conflict const & e) {
                            suceeded = false;
                        }
                        if(suceeded) {
                            ++numsols;
                            if(!multisol) {
                                *this = other;
                                return;
                            }
                            if(numsols>1)
                                throw multisolution();
                            backup.reset(new board(other));
                        }
                    }
                    if(numsols>0) {
                        *this = *backup;
                        return;
                    }
                    throw conflict();
                }
                void solver_find_min(int & io, int & jo)
                {
                    int min = sizeN+1;
                    for(int i = 0; i<sizeN; ++i) {
                        for(int j = 0; j<sizeN; ++j) {
                            state & s = solve_state_[i][j];
                            if(s.size()<min && s.size()>1) {
                                min = s.size();
                                io = i; jo = j;
                            }
                        }
                    }
                }
                template <class T>
                bool verify(T & bucket)
                {
                    std::bitset<sizeN> bits;
                    for(int i = 0; i<sizeN; ++i)
                        bits.set(bucket[i]-1);
                    return bits.count() == sizeN;
                }
                std::ostream & serialize(std::ostream & ostr) const
                {
                    for(int i = 0, k = 0; i<cell_sizeN; ++i) {
                        if(i) {
                            ostr << "\n";
                            row<cell_sizeN>::separator(ostr) << "\n";
                        }
                        for(int j = 0; j<cell_sizeN; ++j) {
                            if(j) ostr << "\n";
                            ostr << row_at(k++);
                        }
                    }
                    return ostr;
                }
                std::istream & deserialize(std::istream & istr)
                {
                    for(int i = 0; i<sizeN; ++i) {
                        istr >> row_at(i);
                        if(!istr)
                            return istr;
                    }
                    return istr;
                }
                class state
                {
                public:
                    state() : size_(sizeN)
                    {
                        status_.reset();
                    }
                    int size()
                    {
                        return size_;
                    }
                    void reset()
                    {
                        status_.reset();
                        size_ = sizeN;
                    }
                    void decide(int n)
                    {
                        status_.set();
                        status_.reset(n-1);
                        size_ = 1;
                    }
                    bool status(int n)
                    {
                        return status_[n-1];
                    }
                    void eliminate(int n)
                    {
                        if(!status_[n-1]) {
                            status_[n-1] = 1;
                            size_--;
                        }
                        if(size_==0)
                            throw conflict();
                    }
                    int solve()
                    {
                        assert(size_==1);
                        for(int i = 0; i<sizeN; ++i)
                            if(!status_[i])
                                return i+1;
                        assert(!"cannot happen");
                        return 0;
                    }
                private:
                    std::bitset<sizeN> status_;
                    int size_;
                };

                int * rdata_;
                int data_[sizeN][sizeN];
                row<cell_sizeN> rows_[sizeN];
                column<cell_sizeN> columns_[sizeN];
                cell<cell_sizeN> cells_[cell_sizeN][cell_sizeN];

                int solve_size_;
                state solve_state_[sizeN][sizeN];

                template <int size>
                friend std::ostream & operator <<(std::ostream &, board<size> const &);
                template <int size>
                friend std::istream & operator >>(std::istream &, board<size> &);
            };

            template <int cell_sizeN>
            inline std::ostream & operator <<(std::ostream & ostr, board<cell_sizeN> const & b)
            {
                return b.serialize(ostr);
            }
            template <int cell_sizeN>
            inline std::istream & operator >>(std::istream & istr, board<cell_sizeN> & b)
            {
                return b.deserialize(istr);
            }
        };
    }

#endif /* SUDOKU_SOLVER_CORE_H_ */
